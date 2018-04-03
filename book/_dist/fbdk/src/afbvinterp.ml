open Afbvast;;

(* TODO: Message handling is currently immediate - messages are processed as soon as they are sent - which can cause starvation.  Message handling should occur after the current evaluation stack finishes.  A mode for multi-threaded execution would be cool, too.  :) *)

exception NotClosed
exception BuggyInterpreter
exception HeadOfEmptyList

let idsource = ref 0 ;;

let nextid () = (idsource := !idsource + 1) ; Name(Printf.sprintf "A%d" !idsource) ;;

let global_actors = Hashtbl.create 10 ;;

let set_actor actorid expr = 
  match expr with 
    | Function(_, _) -> (
        (*ignore(
          print_string "Code for actor: " ; 
          print_string (Afbvpp.pretty_print actorid) ; 
          print_endline "" ;
          print_endline (Afbvpp.pretty_print expr)) ; *)
        (Hashtbl.replace global_actors actorid expr))
    | x               -> failwith ("Actor code must be a function :" ^ (Afbvpp.pretty_print x))

let get_code actorid = Hashtbl.find global_actors actorid 


let message_map = ref [] ;;
 
let add_message actorid message = 
  let newlist = (actorid, message)::(!message_map) in
  ignore( message_map := newlist )
  
let next_message () = 
  let index = Random.int (List.length (!message_map)) in
    List.nth (!message_map) index
    
let remove_message msg =
  let newlist = List.filter (fun x -> x != msg) (!message_map) in
    message_map := newlist ; (List.length (!message_map))    
    
let get_message_count () = List.length !message_map ;; 

let print_state () =
  let actor_name a = (match a with Actor(Name n) -> n | _ -> raise BuggyInterpreter) in
    let debug = Afbvoptions.get_debug () in
    if debug then ( 
	    (print_string "Actors:\n") ;
	    (Hashtbl.iter (fun a -> fun code -> Printf.printf "(%s, %s)\n" (actor_name a) (Afbvpp.pp code "")) global_actors) ;
        (* (Hashtbl.iter (fun a -> fun code -> Printf.printf "(%s)\n" (actor_name a)) global_actors) ; *)
	    (print_string "Messages:\n") ;
	    (print_string "{ ") ;
	    List.iter (function (a, v) -> Printf.printf "[%s <- %s] " (actor_name a) (Afbvpp.pp v "")) !message_map ;
	    (print_string " }\n\n") 
    ) else () 
;;
      
(* Predicate that tests whether an expression is closed. *)
let rec closedp e2 ident_list =
  match e2 with
    Var(x) -> 
      List.mem x ident_list
  | Int(x) -> true
  | Bool(x) -> true
  | String(x) -> true
  | EmptyList -> true
  | Function(i, x) -> closedp x (i::ident_list)
  | Appl(x, y) -> closedp x ident_list && closedp y ident_list
  | Plus(x, y) -> closedp x ident_list && closedp y ident_list
  | Minus(x, y) -> closedp x ident_list && closedp y ident_list
  | Equal(x, y) -> closedp x ident_list && closedp y ident_list
  | And(x, y) -> closedp x ident_list && closedp y ident_list
  | Or(x, y) -> closedp x ident_list && closedp y ident_list
  | Not(x) -> closedp x ident_list
  | If(x, y, z) ->  
      closedp x ident_list && 
      closedp y ident_list && 
      closedp z ident_list
  | Seq(e1, e2) -> closedp e1 ident_list && closedp e2 ident_list
  | Let(id, e1, e2) -> closedp e1 ident_list && (closedp e2 (id::ident_list))
  | Pair(e1, e2) -> closedp e1 ident_list && closedp e2 ident_list
  | Fst(e) -> closedp e ident_list 
  | Snd(e) -> closedp e ident_list
  | Variant(n, e) -> closedp e ident_list
  | Match (e, pattern_list) -> closedp e ident_list && (
      List.fold_left (
        fun res -> function (n, id, e) -> res && closedp e (id::ident_list)
      ) true pattern_list
    )
  | Head(e) -> closedp e ident_list
  | Tail(e) -> closedp e ident_list
  | Cons(e1, e2) -> closedp e1 ident_list && closedp e2 ident_list
  | Create(e1, e2) -> closedp e1 ident_list && closedp e2 ident_list
  | Send(e1, e2) -> closedp e1 ident_list && closedp e2 ident_list
  | Actor(n) -> true
  | Print(e) -> closedp e ident_list

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
  
exception TypeMismatch

let rec eval e =
  if not (closedp e []) then
    raise NotClosed
  else
    match e with 
      Bool(x) -> Bool(x)
    | Int(x) -> Int(x)
    | String(x) -> String(x)
    | Function(i, x) -> Function(i, x)
    | EmptyList -> EmptyList
    | And(e1, e2) -> 
        (match (eval e1, eval e2) with
          (Bool(true), Bool(true)) -> Bool(true)
        | (Bool(_), Bool(_)) -> Bool(false)
        | _ -> raise TypeMismatch)
    | Or(e1, e2) ->
        (match (eval e1, eval e2) with
          (Bool(false), Bool(false)) -> Bool(false)
        | (Bool(_), Bool(_)) -> Bool(true)
        | _ -> raise TypeMismatch)
    | Not(e1) ->
        (match (eval e1) with
          Bool(true) -> Bool(false)
        | Bool(false) -> Bool(true)
        | _ -> raise TypeMismatch)
    | Plus(e1, e2) ->
        (match (eval e1, eval e2) with
          (Int(x), Int(y)) -> Int(x + y)
        | _ -> raise TypeMismatch)
    | Minus(e1, e2) ->
        (match (eval e1, eval e2) with
          (Int(x), Int(y)) -> Int(x - y)
        | _ -> raise TypeMismatch)
    | Equal(e1, e2) ->
        (match (eval e1, eval e2) with
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
        | _ -> raise TypeMismatch) (* was false but that is wrong wrt opsem *)
    | If(p, e1, e2) ->
        (match eval p with
          Bool(true) -> eval e1
        | Bool(false) -> eval e2
        | _ -> raise TypeMismatch)
    | Appl(e1, e2) ->
        (match Appl(eval e1, eval e2) with
          Appl(Function(i, e1), v2) -> eval (subst e1 v2 i)
        | _ -> raise TypeMismatch)

    | Seq(e1, e2) -> let _ = eval e1 in (eval e2)
	  | Let(i, e1, e2) -> let v = (eval e1) in eval (subst e2 v i)
	  | Pair(e1, e2) -> Pair(eval e1, eval e2)
	  | Fst(e) -> 
        (match (eval e) with
          | Pair(v1, v2) -> v1
          | _             -> raise TypeMismatch)
	  | Snd(e) -> 
        (match (eval e) with
          | Pair(v1, v2) -> v2
          | _             -> raise TypeMismatch)
	  | Variant(n, e) -> let v = eval e in (* print_string (Afbvpp.pretty_print v); *) Variant(n, v)
	  | Match (e, pattern_list) ->
      let pattern_search name plist = List.find ( function (n, id, exp) -> name = n ) plist in
        (match (eval e) with
          | Variant(n, v) -> 
            let (name, id, exp) = pattern_search n pattern_list in
              eval (subst exp v id) 
          | _              -> raise TypeMismatch) 
    | Cons(e1, e2) ->
      let (v1, v2) = (eval e1, eval e2) in 
      let rec is_list e = match e with EmptyList -> true | Cons(e1, e2) -> is_list e2 | _ -> false in
        if (not (is_list v2)) then
          raise TypeMismatch
        else
          Cons(v1, v2)
    | Head(e) -> (match (eval e) with
          | Cons(v1, v2) -> v1
          | EmptyList    -> raise HeadOfEmptyList
          | _             -> raise TypeMismatch)
    | Tail(e) -> (match (eval e) with
          | Cons(v1, v2) -> v2
          | EmptyList    -> EmptyList
          | _             -> raise TypeMismatch)
    | Create(e1, e2) -> (match (eval e1, eval e2) with
    | (Function(id, e) as f, v) -> 
        let actorid = Actor(nextid ()) in
        let actor_func = eval (Appl((Appl(f, actorid)), v)) in
          (set_actor actorid actor_func) ; actorid
      | _ -> raise TypeMismatch)  
	  | Send(e1, e2) -> (match (eval e1, eval e2) with
      | (Actor n as act, v) -> (add_message act v) ; (if get_message_count () = 1 then process_message () else () ) ; v
      | _             -> raise TypeMismatch) 
	  | Actor(n) -> Actor(n)
    | Print(e) -> (match (eval e) with
      | Int(x) -> (print_int x) ; (flush stdout) ; Bool true
      | Bool(x) -> (if x then print_string "True" else print_string "False") ; (flush stdout) ; Bool true
      | String(x) -> (print_string x) ; (flush stdout) ; Bool true
      | Actor(Name(s)) -> (print_string s) ; (flush stdout) ; Bool true
      | v       -> print_string "Cannot print expression. Only Int and Bool values are supported"; 
                   print_string (Afbvpp.pretty_print v) ;Bool false) 
      (* We should never get this far, since NotClosed should be
       * raised in the beginning of the call to eval.
       *)
    | Var(x) -> raise BuggyInterpreter

and

process_message () =
  print_state () ;
  let msg = next_message () in
  let (actorid, value) = msg in
  let code = get_code actorid in
  let newcode = (* print_endline "About to eval message" ; *) eval (Appl(code, value)) in
  (* print_endline "Finished. Setting new code for actor" ; *) (set_actor actorid newcode) ;(
  let count = remove_message msg in
    if (count > 0) then
      process_message ()
    else
      ())
