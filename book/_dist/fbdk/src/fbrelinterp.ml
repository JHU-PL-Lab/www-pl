open Fbrelast;;

(* TODO: Message handling is currently immediate - messages are processed as soon as they are sent - which can cause starvation.  Message handling should occur after the current evaluation stack finishes.  A mode for multi-threaded execution would be cool, too.  :) *)

exception NotClosed
exception BuggyInterpreter
exception HeadOfEmptyList
exception LabelNotFound

let idsource = ref 0 ;;

module Rmap = Map.Make(String);;

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
  | Let(id, e1, e2) -> closedp e1 ident_list && (closedp e2 (id::ident_list))
  | Match (e, e1, i1, i2, e2) ->
    closedp e ident_list && closedp e1 ident_list
    && closedp e2 (i1::i2::ident_list)
  | Cons(e1, e2) -> closedp e1 ident_list && closedp e2 ident_list
  | Record(body) -> (match body with
        [] -> true
      |(l,t)::xs -> closedp t ident_list && closedp (Record(xs)) ident_list
    )
  | Select(l, x) -> closedp x ident_list


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
  | Let(i, e1, e2) -> Let (i, subst e1 v id, (if i = id then e2 else (subst e2 v id)))
  | Match (e, e1, i1, i2, e2) ->
    Match(subst e v id, subst e1 v id, i1, i2,
          (if id = i1  || id = i2 then e2 else subst e2 v id) )
  | EmptyList -> EmptyList
  | Cons(e1, e2) -> Cons(subst e1 v id, subst e2 v id)
  | Select(l,e) -> Select(l,subst e v id)
  | Record(body) -> (match body with [] -> Record(body)
                                   | (l,t1)::xs -> Record(recordSubst(body,v,id)))

and
  recordSubst(body,sub,id) = (match body with [] -> []
                                            | ((l,t1)::xs) -> (l,subst t1 sub id)::recordSubst(xs,sub,id))



exception TypeMismatch

let rec lookupRecord (record,Lab l) = match record with
    [] -> raise LabelNotFound
  | (Lab l1,v)::xs -> if l1 = l then v else
      lookupRecord(xs,Lab l)

let rec addifnotpresent (lab, e) l =
  match l with
    [] -> [(lab,e)]
  | (l1,e1) :: tl ->
    if l1=lab then l else (l1,e1) :: (addifnotpresent (lab, e) tl)

let rec appendrecord l1 l2 =
  match l2 with
  | [] -> l1
  | (lab,e) :: l -> addifnotpresent (lab,e) (appendrecord l1 l)

let rec assoc_lists_equal l1 l2 =
  match l1 with
  | [] -> l2 = []
  | (k,v)::t ->
    match List.assoc_opt k l2 with
    | None -> false
    | Some v' ->
      if v <> v' then false else
        assoc_lists_equal t @@ List.remove_assoc k l2

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
      (match (eval e1) with
         Bool(false) -> Bool(false)
       | Bool(true) ->
         (match eval e2 with Bool(b) -> Bool(b) |  _ -> raise TypeMismatch)
       | _ -> raise TypeMismatch)
    | Or(e1, e2) ->
      (match (eval e1) with
         Bool(true) -> Bool(true)
       | Bool(false) ->
         (match eval e2 with Bool(b) -> Bool(b) |  _ -> raise TypeMismatch)
       | _ -> raise TypeMismatch)
    | Not(e1) ->
      (match (eval e1) with
         Bool(true) -> Bool(false)
       | Bool(false) -> Bool(true)
       | _ -> raise TypeMismatch)
    | Plus(e1, e2) ->
      (match (eval e1, eval e2) with
         (Int(x), Int(y)) -> Int(x + y)
       | (Record(l1), Record(l2)) -> Record(appendrecord l2 l1)
       | _ -> raise TypeMismatch)
    | Minus(e1, e2) ->
      (match (eval e1, eval e2) with
         (Int(x), Int(y)) -> Int(x - y)
       | _ -> raise TypeMismatch)
    | Equal(e1, e2) ->
      Bool(match (eval e1,eval e2) with
          | (Record(r1), Record(r2)) -> assoc_lists_equal r1 r2
          | (v1,v2) -> v1 = v2
        )
    | If(p, e1, e2) ->
      (match eval p with
         Bool(true) -> eval e1
       | Bool(false) -> eval e2
       | _ -> raise TypeMismatch)
    | Appl(e1, e2) ->
      (match Appl(eval e1, eval e2) with
         Appl(Function(i, e1), v2) -> eval (subst e1 v2 i)
       | _ -> raise TypeMismatch)

    | Let(i, e1, e2) -> let v = (eval e1) in eval (subst e2 v i)
    | Match (e, e1, i1, i2, e2) ->
      (match (eval e) with
       | EmptyList -> eval e1
       | Cons(v1,v2) -> eval (subst (subst e2 v1 i1) v2 i2)
       | _   -> raise TypeMismatch )
    | Cons(e1, e2) ->
      let (v1, v2) = (eval e1, eval e2) in
      let rec is_list e = match e with EmptyList -> true | Cons(e1, e2) -> is_list e2 | _ -> false in
      if (not (is_list v2)) then
        raise TypeMismatch
      else
        Cons(v1, v2)
    | Record(body) -> (evalRecord body)
    | Select(l,t) ->
      (match eval t with
         Record(body) -> lookupRecord(body,l)
       |       _ -> raise TypeMismatch)
    | Var(x) -> raise BuggyInterpreter

and
  evalRecord l = (match l with
      [] -> Record([])
    | ((Lab lab,t1)::xs) ->
      let x1 = eval t1 in
      (match evalRecord xs with
         Record(x2) -> (Record((Lab lab,x1)::x2))
       | _ -> raise TypeMismatch))
