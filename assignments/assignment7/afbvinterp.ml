open Afbvast;;

Random.self_init ();;

exception NotClosed of string
exception BuggyInterpreter
exception HeadOfEmptyList
exception MissingMatchCase of string
exception TypeMismatch of string

let _fresh_name_ctr = ref 0;;
let next_name () =
  _fresh_name_ctr := !_fresh_name_ctr + 1;
  Name("@" ^ string_of_int !_fresh_name_ctr)

module ActorMap = Map.Make(
  struct
    type t = name
    let compare = compare
  end
  );;

type state =
  { actors : expr ActorMap.t;
    messages : (name * expr) list;
  }
;;

let initial_state = { actors = ActorMap.empty; messages = [] };;

let pp_state fmt state =
  let ff = Format.fprintf in
  ff fmt "~~~ Actors:\n";
  state.actors
  |> ActorMap.bindings
  |> List.iter begin fun (Name name, expr) ->
    ff fmt "%S:@[%a@]\n" name Afbvpp.pp_expr expr
  end;
  ff fmt "~~~ Messages:\n";
  state.messages
  |> List.iter begin fun (Name name, expr) ->
    ff fmt "%S <- @[%a@]\n" name Afbvpp.pp_expr expr
  end
;;

(* A routine for printing values via the Print expression. *)
let rec value_to_printable_string (e : expr) : string =
  match e with
  | Int(_)
  | Bool(_)
  | Function(_, _)
  | Pair(_, _)
  | Variant(_, _)
  | EmptyList
  | Cons(_, _)
  | Actor(_) -> Format.asprintf "%a" Afbvpp.pp_expr e
  | String(s) -> s
  | _ -> raise BuggyInterpreter
;;

(* Routine to determine if an expression is closed.  If it is not, a NotClosed
   exception is raised. *)
let rec assert_closed expr ident_list =
  match expr with
    Var(x) ->
    if not (List.mem x ident_list) then
      let Ident s = x in raise (NotClosed s)
  | Int(x) -> ()
  | Bool(x) -> ()
  | String(x) -> ()
  | EmptyList -> ()
  | Function(i, x) -> assert_closed x (i::ident_list)
  | Appl(x, y) -> assert_closed x ident_list; assert_closed y ident_list
  | Plus(x, y) -> assert_closed x ident_list; assert_closed y ident_list
  | Minus(x, y) -> assert_closed x ident_list; assert_closed y ident_list
  | Equal(x, y) -> assert_closed x ident_list; assert_closed y ident_list
  | And(x, y) -> assert_closed x ident_list; assert_closed y ident_list
  | Or(x, y) -> assert_closed x ident_list; assert_closed y ident_list
  | Not(x) -> assert_closed x ident_list
  | If(x, y, z) ->
    assert_closed x ident_list;
    assert_closed y ident_list;
    assert_closed z ident_list
  | Seq(e1, e2) -> assert_closed e1 ident_list; assert_closed e2 ident_list
  | Let(id, e1, e2) ->
    assert_closed e1 ident_list; assert_closed e2 (id::ident_list)
  | Pair(e1, e2) ->
    assert_closed e1 ident_list; assert_closed e2 ident_list
  | Fst(e) -> assert_closed e ident_list
  | Snd(e) -> assert_closed e ident_list
  | Variant(n, e) -> assert_closed e ident_list
  | Match (e, pattern_list) ->
    assert_closed e ident_list;
    List.iter (fun (n, id, e) -> assert_closed e (id::ident_list)) pattern_list
  | Head(e) -> assert_closed e ident_list
  | Tail(e) -> assert_closed e ident_list
  | Cons(e1, e2) -> assert_closed e1 ident_list; assert_closed e2 ident_list
  | Create(e1, e2) -> assert_closed e1 ident_list; assert_closed e2 ident_list
  | Send(e1, e2) -> assert_closed e1 ident_list; assert_closed e2 ident_list
  | Actor(n) -> ()
  | Print(e) -> assert_closed e ident_list

(* We're assuming that we've already checked for closure *)
let rec subst e v id =
  match e with
    Var(x) ->
    if (x = id) then
      v
    else
      Var(x)
  | Appl(x, y) -> Appl(subst x v id, subst y v id)
  | Plus(x, y) -> Plus(subst x v id, subst y v id)
  | Minus(x, y) -> Minus(subst x v id, subst y v id)
  | Equal(x, y) -> Equal(subst x v id, subst y v id)
  | And(x, y) -> And(subst x v id, subst y v id)
  | Or(x, y) -> Or(subst x v id, subst y v id)
  | Not(x) -> Not(subst x v id)
  | If(x, y, z) -> If(subst x v id, subst y v id, subst z v id)
  | Function(i, exp) ->
    if i = id then
      Function(i, exp)
    else
      Function(i, subst exp v id)
  | Bool(x) -> Bool(x)
  | Int(x) -> Int(x)
  | String(x) -> String(x)
  | Seq(e1, e2) -> Seq(subst e1 v id, subst e2 v id)
  | Let(i, e1, e2) -> Let (i, subst e1 v id, (if i = id then e2 else (subst e2 v id)))
  | Pair(e1, e2) -> Pair(subst e1 v id, subst e2 v id)
  | Fst(e) -> Fst(subst e v id)
  | Snd(e) -> Snd(subst e v id)
  | Variant(n, e) -> Variant(n, subst e v id)
  | Match (e, pattern_list) ->
    let subst_patterns = List.map (
        fun (n, i, exp) -> (n, i, if (i = id) then exp else (subst exp v id))
      ) pattern_list
    in
    Match(subst e v id, subst_patterns)
  | EmptyList -> EmptyList
  | Head(e) -> Head(subst e v id)
  | Tail(e) -> Tail(subst e v id)
  | Cons(e1, e2) -> Cons(subst e1 v id, subst e2 v id)
  | Create(e1, e2) -> Create(subst e1 v id, subst e2 v id)
  | Send(e1, e2) -> Send(subst e1 v id, subst e2 v id)
  | Actor(n) -> Actor(n)
  | Print(e1) -> Print(subst e1 v id)

let global_state = ref initial_state;;

let invalid_args_1 op e1 =
  raise( TypeMismatch(
      Format.asprintf "Invalid arguments to %s: %a"
        op Afbvpp.pp_expr e1
    ))
;;

let invalid_args_2 op e1 e2 =
  raise( TypeMismatch(
      Format.asprintf "Invalid arguments to %s: %a, %a"
        op Afbvpp.pp_expr e1 Afbvpp.pp_expr e2
    ))
;;

let rec eval_expr e =
  match e with
    Bool(x) -> Bool(x)
  | Int(x) -> Int(x)
  | String(x) -> String(x)
  | Function(i, x) -> Function(i, x)
  | EmptyList -> EmptyList
  | And(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
       (Bool(true), Bool(true)) -> Bool(true)
     | (Bool(_), Bool(_)) -> Bool(false)
     | _ -> invalid_args_2 "And" e1 e2)
  | Or(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
       (Bool(false), Bool(false)) -> Bool(false)
     | (Bool(_), Bool(_)) -> Bool(true)
     | _ -> invalid_args_2 "Or" e1 e2)
  | Not(e1) ->
    (match (eval_expr e1) with
       Bool(true) -> Bool(false)
     | Bool(false) -> Bool(true)
     | _ -> invalid_args_1 "Not" e1)
  | Plus(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
       (Int(x), Int(y)) -> Int(x + y)
     | _ -> invalid_args_2 "+" e1 e2)
  | Minus(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
       (Int(x), Int(y)) -> Int(x - y)
     | _ -> invalid_args_2 "-" e1 e2)
  | Equal(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
       (Int x, Int y) -> Bool(x = y)
     | (Bool x, Bool y) -> Bool (x = y)
     | (String x, String y) -> Bool (x = y)
     | (EmptyList, EmptyList) -> Bool true
     | (EmptyList, Cons(h,t)) -> Bool false
     | (Cons(h,t), EmptyList) -> Bool false
     | (Cons(h1,t1), Cons(h2,t2)) -> Bool (h1 = h2 && t1 = t2)
     | (Actor a, Actor b) -> Bool (a = b)
     | (Pair(a1, b1), Pair(a2,b2)) -> Bool (a1 = a2 && b1 = b2)
     | (Variant(n1, v1), Variant(n2, v2)) -> Bool (n1 = n2 && v1 = v2)
     | _ -> invalid_args_2 "=" e1 e2)
  | If(p, e1, e2) ->
    (match eval_expr p with
       Bool(true) -> eval_expr e1
     | Bool(false) -> eval_expr e2
     | v ->
       raise (TypeMismatch(
           Format.asprintf "Invalid argument to If condition: %a"
             Afbvpp.pp_expr v
         ))
    )
  | Appl(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
       (Function(i, e'), v2) -> eval_expr (subst e' v2 i)
     | (v1,_) ->
       raise (TypeMismatch(
           Format.asprintf "Call of non-function: %a" Afbvpp.pp_expr v1
         ))
    )

  | Seq(e1, e2) -> let _ = eval_expr e1 in (eval_expr e2)
  | Let(i, e1, e2) -> let v = (eval_expr e1) in eval_expr (subst e2 v i)
  | Pair(e1, e2) -> Pair(eval_expr e1, eval_expr e2)
  | Fst(e) ->
    (match (eval_expr e) with
     | Pair(v1, v2) -> v1
     | v ->
       raise (TypeMismatch(
           Format.asprintf "Projection from non-tuple: %a"
             Afbvpp.pp_expr v
         ))
    )
  | Snd(e) ->
    (match (eval_expr e) with
     | Pair(v1, v2) -> v2
     | v ->
       raise (TypeMismatch(
           Format.asprintf "Projection from non-tuple: %a"
             Afbvpp.pp_expr v
         ))
    )
  | Variant(n, e) -> let v = eval_expr e in (* print_string Afbvpp.pp_expr v; *) Variant(n, v)
  | Match (e, pattern_list) ->
    (match (eval_expr e) with
     | Variant(Name variant_name, contained_value) ->
       let rec loop patterns =
         match patterns with
         | (Name pattern_name, var_id, body)::_
           when pattern_name = variant_name ->
           eval_expr (subst body contained_value var_id)
         | _::patterns' ->
           loop patterns'
         | [] ->
           raise @@ MissingMatchCase variant_name
       in
       loop pattern_list
     | v ->
       raise (TypeMismatch(
           Format.asprintf "Match on non-variant: %a"
             Afbvpp.pp_expr v
         ))
    )
  | Cons(e1, e2) ->
    let (v1, v2) = (eval_expr e1, eval_expr e2) in
    let rec is_list e = match e with EmptyList -> true | Cons(e1, e2) -> is_list e2 | _ -> false in
    if (not (is_list v2)) then
      raise (TypeMismatch(
          Format.asprintf "Cons with non-list: %a"
            Afbvpp.pp_expr v2
        ))
    else
      Cons(v1, v2)
  | Head(e) ->
    (match (eval_expr e) with
     | Cons(v1, v2) -> v1
     | EmptyList    -> raise HeadOfEmptyList
     | v ->
       raise (TypeMismatch(
           Format.asprintf "Head of non-list: %a"
             Afbvpp.pp_expr v
         ))
    )
  | Tail(e) ->
    (match (eval_expr e) with
     | Cons(v1, v2) -> v2
     | EmptyList    -> EmptyList
     | v ->
       raise (TypeMismatch(
           Format.asprintf "Head of non-list: %a"
             Afbvpp.pp_expr v
         ))
    )
  | Create(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
     | (Function(id, e) as f, v) ->
       let actor_name = next_name () in
       let actor_code = eval_expr (Appl(Appl(f, Actor actor_name),v)) in
       global_state :=
         { !global_state with
           actors = ActorMap.add actor_name actor_code !global_state.actors
         };
       Actor actor_name
     | (v1,_) ->
       raise (TypeMismatch(
           Format.asprintf "Create on non-function: %a"
             Afbvpp.pp_expr v1
         ))
    )
  | Send(e1, e2) ->
    (match (eval_expr e1, eval_expr e2) with
     | (Actor n, v) ->
       global_state :=
         { !global_state with
           messages = (n, v)::!global_state.messages
         };
       v
     | (v1,_) ->
       raise (TypeMismatch(
           Format.asprintf "Send to non-actor: %a"
             Afbvpp.pp_expr v1
         ))
    )
  | Actor(n) -> Actor(n)
  | Print(e) ->
    let v = eval_expr e in
    print_endline (value_to_printable_string v); flush stdout;
    Bool false
  (* We should never get this far, since NotClosed should be
   * raised in the beginning of the call to eval.
  *)
  | Var(x) -> raise BuggyInterpreter
;;

let rec process_messages () =
  if !Afbvoptions.show_states then begin
    Format.printf "%a\n" pp_state !global_state;
  end;
  if !global_state.messages = [] then () else
    (* If we are performing deterministic delivery, we definitely select the
       first message.  Otherwise, we select one at random. *)
    let next_message =
      if !Afbvoptions.deterministic_delivery then
        let message = List.hd !global_state.messages in
        global_state :=
          { !global_state with messages = List.tl !global_state.messages };
        message
      else
        let count = List.length !global_state.messages in
        let idx = Random.int count in
        let rec loop msgs n =
          match msgs with
          | [] -> raise BuggyInterpreter
          | msgh::msgt ->
            if n = 0 then (msgh,msgt) else
              let (msg,msgt') = loop msgt (n-1) in
              (msg,msgh::msgt')
        in
        let (message,rest) = loop !global_state.messages idx in
        global_state := { !global_state with messages = rest };
        message
    in
    let (destination, contents) = next_message in
    if !Afbvoptions.show_messages then begin
      Format.printf "Delivering to %s the message %a\n"
        (let (Name n) = destination in n)
        Afbvpp.pp_expr contents
    end;
    let actor_code = ActorMap.find destination !global_state.actors in
    let new_actor_code = eval_expr (Appl(actor_code, contents)) in
    global_state :=
      { !global_state with
        actors = ActorMap.add destination new_actor_code !global_state.actors
      };
    if [] <> !global_state.messages then process_messages ()
;;

let eval e =
  assert_closed e [];
  global_state := initial_state;
  _fresh_name_ctr := 0;
  let v = eval_expr e in
  process_messages ();
  v
;;
