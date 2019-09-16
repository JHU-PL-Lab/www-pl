(*
 * Environment-based interpreter extension. 
 *)

open Fbast;;
open Fbinterp;;

(* contexts are strings of call sites, which for us are labeled with integers.  *)

type context = int list

(* eexpr is expressions for the evironment-based interpreter *)

type eexpr =
  | EVar of ident | EFunction of ident * eexpr | EAppl of int * eexpr * eexpr
  (*| ELet of ident * eexpr * eexpr - translate out for simplicity *) | ELetRec of ident * ident * eexpr * eexpr
  | EPlus of eexpr * eexpr | EMinus of eexpr * eexpr | EEqual of eexpr * eexpr
  | EAnd of eexpr * eexpr| EOr of eexpr * eexpr | ENot of eexpr
  | EIf of eexpr * eexpr * eexpr | EInt of int | EBool of bool
  | EClosure of eexpr * context

(* convert expr to eexpr *)

let newnewnum () =
  let count = ref 0 in
  let newnum () =
    let _ = count := !count + 1 in !count
  in newnum    
    
let expr_to_eexpr e =
  let newnum = newnewnum() in
  let rec expr_to_eexpr_worker e =
   match e with
       Var(x) -> EVar(x)
     | Int(x) -> EInt(x)
     | Bool(x) -> EBool(x)
     | Let(i, e1, e2) -> EAppl(newnum(),EFunction(i, expr_to_eexpr_worker e2), expr_to_eexpr_worker e1)
     | LetRec(i1, i2, e1, e2) -> failwith "unimplemented"
     | Function(i, e1) -> EFunction(i, expr_to_eexpr_worker e1)
     | Appl(e1, e2) -> EAppl(newnum(),expr_to_eexpr_worker e1, expr_to_eexpr_worker e2)
     | Plus(e1, e2) -> EPlus(expr_to_eexpr_worker e1, expr_to_eexpr_worker e2)
     | Minus(e1, e2) -> EMinus(expr_to_eexpr_worker e1, expr_to_eexpr_worker e2)
     | Equal(e1, e2) -> EEqual(expr_to_eexpr_worker e1, expr_to_eexpr_worker e2)
     | And(e1, e2) -> EAnd(expr_to_eexpr_worker e1, expr_to_eexpr_worker e2)
     | Or(e1, e2) -> EOr(expr_to_eexpr_worker e1, expr_to_eexpr_worker e2)
     | Not(e1) -> ENot(expr_to_eexpr_worker e1)
     | If(e1, e2, e3) -> EIf(expr_to_eexpr_worker e1, expr_to_eexpr_worker e2, expr_to_eexpr_worker e3)
                           
  in expr_to_eexpr_worker e

module IntListOrd =
       struct
         type t = int list
         let compare = Stdlib.compare
       end

module IntListMap = Map.Make(IntListOrd)

module IdentOrd =
       struct
         type t = ident
         let compare = Stdlib.compare
        end

module IdentMap = Map.Make(IdentOrd)

(* empty store *)

let init_s = (IntListMap.add [] IdentMap.empty (IntListMap.empty))

(* turn store map of maps into list representation for printing *)

let mapdump (x,y) = List.map (fun (c,value) -> (c, IdentMap.bindings value)) (IntListMap.bindings y)


  let rec eevaler e c s = 
    match e with
    | EVar(Ident(x)) -> 
      let envt = IntListMap.find c s in 
      let value = IdentMap.find (Ident(x)) envt in (value,s)
    | EBool(x) -> (EBool(x),s)
    | EInt(x) -> (EInt(x),s)
   (* | EClosure(f,c) -> EClosure(f,c) *)
    | EFunction(x, e1) -> (EClosure(EFunction(x, e1),c),s)
  (*   | ELet(i, e1, e2) -> let v1 = eevaler e1 c s in eevaler e2 c s *)
    | ELetRec(i1, i2, e1, e2) -> failwith "unimplemented"
    | EAnd(e1, e2) ->
        let (v1,s1) = eevaler e1 c s in
        let (v2,s2) = eevaler e2 c s1 in
        (match (v1,v2) with
        | (EBool(true), EBool(true)) -> (EBool(true),s)
        | (EBool(_), EBool(_)) -> (EBool(false),s)
        | _ -> raise TypeMismatch)
    | EOr(e1, e2) ->
      let (v1,s1) = eevaler e1 c s in
      let (v2,s2) = eevaler e2 c s1 in
        (match (v1,v2) with
          (EBool(false), EBool(false)) -> (EBool(false),s)
        | (EBool(_), EBool(_)) -> (EBool(true),s)
        | _ -> raise TypeMismatch)
    | ENot(e1) ->
       let (v1,s1) = eevaler e1 c s in
        (match v1 with
          EBool(true) -> (EBool(false),s)
        | EBool(false) -> (EBool(true),s)
        | _ -> raise TypeMismatch)
    | EPlus(e1, e2) ->
      let (v1,s1) = eevaler e1 c s in
      let (v2,s2) = eevaler e2 c s1 in
        (match (v1,v2) with
        | (EInt(x), EInt(y)) -> (EInt(x + y),s)
        | _ -> raise TypeMismatch)
    | EMinus(e1, e2) ->
      let (v1,s1) = eevaler e1 c s in
      let (v2,s2) = eevaler e2 c s1 in
        (match (v1,v2) with
        |  (EInt(x), EInt(y)) -> (EInt(x - y),s)
        | _ -> raise TypeMismatch)
    | EEqual(e1, e2) ->
      let (v1,s1) = eevaler e1 c s in
      let (v2,s2) = eevaler e2 c s1 in
        (match (v1,v2) with
        | (EInt x, EInt y) -> (EBool(x = y),s)
        | _ -> raise TypeMismatch)
    | EIf(p, e1, e2) ->
        (match eevaler p c s with
          (EBool(true),s') -> eevaler e1 c s'
        | (EBool(false),s') -> eevaler e2 c s'
        | _ -> raise TypeMismatch)
    | EAppl(l,e1, e2) ->
      let (v1,s1) = eevaler e1 c s in
      let (v2,s2) = eevaler e2 c s1 in
        (match (v1,v2) with
          (EClosure(EFunction(x, e'),c1), v2) -> 
          let funenvt = IntListMap.find c1 s2 in
          let newenvt = IdentMap.add x v2 funenvt in
          let newstore = IntListMap.add (l::c) newenvt s2 in
            eevaler e' (l::c) newstore
        | _ -> raise TypeMismatch)
    | _ -> raise TypeMismatch


let eeval e =
  if not (closedp e []) then
    raise NotClosed
  else eevaler (expr_to_eexpr e) [] init_s

(* expose subst-based eval here for top-loop construction *)

let eval = Fbinterp.eval

