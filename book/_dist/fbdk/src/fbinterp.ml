(*
 * Mike Grant <mike@acm.jhu.edu>
 *
 * Assignment 3: D interpreter
 *)

(* Open the Module containing the expr type *)

open Fbast;;

(* Insert your code here.  Use let rec if needed. *)

exception NotClosed
exception BuggyInterpreter

(* Predicate that tests whether an expression is closed. *)
let rec closedp e2 ident_list =
  match e2 with
    Var(x) ->
      List.mem x ident_list
  | Int(x) -> true
  | Bool(x) -> true
  | Let(i, e1, e2) ->
    closedp e1 ident_list && closedp e2 (i::ident_list)
  | LetRec(i1, i2, e1, e2) ->
      closedp e1 (i1::i2::ident_list) &&
      closedp e2 (i1::ident_list)
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

(* We're assuming that we've already checked for closure *)
let rec subst e1 e2 id =
  match e1 with
    Var(x) ->
      if (x = id) then
        e2
      else
        Var(x)
  | Appl(x, y) -> Appl(subst x e2 id, subst y e2 id)
  | Plus(x, y) -> Plus(subst x e2 id, subst y e2 id)
  | Minus(x, y) -> Minus(subst x e2 id, subst y e2 id)
  | Equal(x, y) -> Equal(subst x e2 id, subst y e2 id)
  | And(x, y) -> And(subst x e2 id, subst y e2 id)
  | Or(x, y) -> Or(subst x e2 id, subst y e2 id)
  | Not(x) -> Not(subst x e2 id)
  | If(x, y, z) -> If(subst x e2 id, subst y e2 id, subst z e2 id)
  | Function(i, x) ->
      if i = id then
        Function(i, x)
      else
        Function(i, subst x e2 id)
  | Let(i, x, y) ->
    Let(i, subst x e2 id, if i = id then y else subst y e2 id)
  | LetRec(i1, i2, x, y) ->
      if i1 = id then
        LetRec(i1, i2, x, y)
      else if i2 = id then
        LetRec(i1, i2, x, subst y e2 id)
      else
        LetRec(i1, i2, subst x e2 id, subst y e2 id)
  | Bool(x) -> Bool(x)
  | Int(x) -> Int(x)

exception TypeMismatch

let rec eval e =
  if not (closedp e []) then
    raise NotClosed
  else
    match e with
      Bool(x) -> Bool(x)
    | Int(x) -> Int(x)
    | Function(i, x) -> Function(i, x)
    | Let(i, e1, e2) -> let v1 = eval e1 in
      eval (subst e2 v1 i)
    | LetRec(i1, i2, e1, e2) ->
        let innersubst = subst e1 (LetRec(i1, i2, e1, Var(i1))) i1 in
        let outersubst = subst e2 (Function(i2, innersubst)) i1 in
        eval outersubst
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

      (* We should never get this far, since NotClosed should be
       * raised in the beginning of the call to eval.
       *)
    | Var(x) -> raise BuggyInterpreter
