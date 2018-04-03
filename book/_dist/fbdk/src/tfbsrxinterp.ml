(* Code surgery using FbSR as a base .. Not pretty at all .. In fact it looks more like a zombie .. Be warned *)

open Tfbsrxast;;

(* Insert your code here *)
exception TypeMismatch;;
exception InterpreterBug;;
exception NotImplemented;;
exception NotClosed;;
exception CellNotFound;;

(* put the store functionality in a separate module.  *)

module type STORE = 
  sig
    val empty : (expr * expr) list
    val fresh : unit -> expr
    val lookup : ((expr * expr) list) * expr -> expr
    val modify : ((expr * expr) list) * expr * expr -> (expr * expr) list
  end

(* the Store structure implements a (functional) store.  A simple
implementation could be via a list of pairs such as
[((Cell 2),(Int 4)); ((Cell 3),Plus((Int 5),(Int 4))); ... ]*)

module Store : STORE =

  struct
    let empty = (Cell 0,Int 0)::[]
    let fresh = (* a simple object which returns a fresh Cell name *)
      let count = ref 0 in
      function () -> ( count := !count + 1; Cell(!count) )
  (* note: this is not purely functional!  its difficult to make fresh
     purely functional *)

(* look up value of cell c in store s *)
    let rec lookup (s,c) = match s with [] -> raise CellNotFound
    | (cellnum,v)::xs -> if cellnum = c then v else lookup (xs,c)

(* add or modify aCellName to aValue in store s, returning new store *)
    let  modify(s,c,v) =  (c,v)::s
  end


let isClosed term = 
  let rec isClosed2 exp ilist =
    match exp with
      Var(x) -> List.mem x ilist
    | Int(x) -> true
    | Bool(x) -> true
    | Letrec(f, v, t1, e1, t2, e2) -> 
        isClosed2 e1 (f::v::ilist) &&
        isClosed2 e2 (f::ilist)
    | Function(i, t, x) -> isClosed2 x (i::ilist)
    | Appl(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | Plus(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | Minus(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | Equal(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | And(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | Or(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | Not(x) -> isClosed2 x ilist
    | If(x, y, z) ->  isClosed2 x ilist && isClosed2 y ilist && isClosed2 z ilist
    | Cell(n) -> true
    | Ref(x) -> isClosed2 x ilist
    | Set(x, y) -> isClosed2 x ilist && isClosed2 y ilist
    | Get(x) -> isClosed2 x ilist	  
    | Record(body) -> (match body with 
                            [] -> true
                           |(l,t)::xs -> isClosed2 t ilist && isClosed2 (Record(xs)) ilist
                      )
    | Select(l, x) -> isClosed2 x ilist
    | Raise(n, t, e) -> isClosed2 e ilist
    | Try(e1, exnid, var, t, e2) ->isClosed2 e1 ilist && isClosed2 e2 (var::ilist) 
  in isClosed2 term []

          
let rec recordSubst(body,sub,id) = (match body with [] -> []
      | ((l,t1)::xs) -> (l,subst(t1,sub,id))::recordSubst(xs,sub,id))

and subst(exp0,sub,ide0) = 
  match exp0 with
    Function(i,t,exp1) -> if i = ide0 then Function(i,t,exp1) 
    else Function(i,t,subst(exp1,sub,ide0))
  | Letrec(iname, i, t1, exp1, t2, exp2) -> 
      if iname = ide0 then
        Letrec(iname, i, t1, exp1, t2, exp2)
      else if i = ide0 then
        Letrec(iname, i, t1, exp1, t2, subst(exp2, sub, ide0))
      else
        Letrec(iname, i, t1, subst(exp1, sub, ide0), t2, subst(exp2, sub, ide0))
  | Var(i) -> if i = ide0 then sub else Var(i)
  | Appl(t1,t2) -> Appl(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | Plus(t1,t2) -> Plus(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | Minus(t1,t2) -> Minus(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | Equal(t1,t2) -> Equal(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | And(t1,t2) -> And(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | Or(t1,t2) -> Or(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | Not(t1) -> Not(subst(t1,sub,ide0))
  | If(t1,t2,t3) -> If(subst(t1,sub,ide0),subst(t2,sub,ide0),subst(t3,sub,ide0))
  | Int x -> Int x
  | Bool x -> Bool x
  | Cell(n) -> Cell(n)
  | Ref(t1) -> Ref(subst(t1,sub,ide0))
  | Set(t1,t2) -> Set(subst(t1,sub,ide0),subst(t2,sub,ide0))
  | Get(t1) -> Get(subst(t1,sub,ide0))
  | Record(body) -> (match body with [] -> Record(body)
    | (l,t1)::xs -> Record(recordSubst(body,sub,ide0)))
  | Select(l,t1) -> Select(l,subst(t1,sub,ide0))
  | Raise(n, t, e) -> Raise (n, t, subst(e, sub, ide0))
  | Try(e1, exnid, var, t, e2) ->
      let e1' = subst (e1, sub, ide0) in
      let e2'' = if (ide0 = var) then e2 else subst (e2, sub, ide0) in
        Try(e1', exnid, var, t, e2'')
      
let rec lookupRecord (record, Lab l) = match record with
  | [] -> raise CellNotFound 
  | (Lab l1, v)::xs -> if l1 = l then v else lookupRecord(xs,Lab l)
    
let rec evalRecord(lst, s) = 
  match lst with
    | []            -> (Record [], s)
    | (Lab l, e)::t -> 
      let (v, s') = eval1 (e, s) in (match v with
        | Raise(_,_,_) -> (v, s')
        | _            -> (match evalRecord (t, s') with
          | (Raise(_,_,_) as xn, s'') -> (xn, s'')
          | (Record r, s'')           -> (Record ((Lab l, v)::r), s'')
          | _                         -> raise TypeMismatch
          ))  
          
    
and
    
    
eval1 (exp, s) = 
  let binary_int_op e1 e2 s op =
    let (v1, s1) = eval1 (e1, s) in
    let (v2, s2) = eval1 (e2, s1) in
      match (v1, v2) with
        | (Raise(_,_,_) as xn, _)  -> (xn, s2)
        | (Int a, Int b)        	 -> (op a b, s2)
        | (_, (Raise(_,_,_) as r)) -> (r, s2)
        | _                     	 -> raise TypeMismatch
  in
  let binary_bool_op e1 e2 s op =
    let (v1, s1) = eval1 (e1, s) in
    let (v2, s2) = eval1 (e2, s1) in
      match (v1, v2) with
        | (Raise(_,_,_) as xn, _)   -> (xn, s2)
        | (_, (Raise(_,_,_) as xn)) -> (xn, s2)
        | (Bool a, Bool b)       		-> (op a b, s2)
        | _                      		-> raise TypeMismatch
  in
  let unary_op e s op =
    let (v, s1) = eval1 (e, s) in 
	    (match v with
	      | Raise(_,_,_) -> (v, s1)
        | Bool(a)   	 -> (op a, s1)
	      | _         	 -> raise TypeMismatch)
  in
  if isClosed(exp) then
	  (match exp with 
      | Int x        			-> (Int x, s)
      | Bool(v)      			-> (Bool v, s)
      | Function(v, t, e) -> (Function(v, t, e), s)
		  | Cell(n) 					-> (Cell(n), s)
       
		  | Not(e)       	-> unary_op e s (fun a -> Bool (not a))
      | And(e1, e2)  	-> binary_bool_op e1 e2 s (fun a -> fun b -> Bool (a && b))
      | Or(e1, e2)   	-> binary_bool_op e1 e2 s (fun a -> fun b -> Bool (a || b))
      
	    
	    | Plus(e1, e2) 	-> binary_int_op e1 e2 s (fun a -> fun b -> Int (a + b))
      | Minus(e1, e2) -> binary_int_op e1 e2 s (fun a -> fun b -> Int (a - b)) 
      | Equal(e1, e2) -> binary_int_op e1 e2 s (fun a -> fun b -> Bool (a = b))
     
	    | If(e, e1, e2) ->
	        let (v, s1) = eval1 (e, s) in (match v with 
	          | Raise(_,_,_)  -> (v, s1)
            | Bool true  		-> eval1 (e1,s1)
	          | Bool false 		-> eval1 (e2,s1)
	          | _ 				 		-> raise TypeMismatch)
             
	    | Var(ide0) -> raise InterpreterBug
      
	    | Letrec(f, var, t1, e1, t2, e2) ->  
	      let innersubst = subst(e1, (Letrec(f, var, t1, e1, t2, Var(f))), f) in
	      let outersubst = subst(e2, (Function(var, t1, innersubst)), f) in
	        eval1 (outersubst, s)
	    | Appl(e1, e2) -> 
	      let (f, s1) = eval1(e1, s) in
	      let (v, s2) = eval1(e2, s1) in
	        (match (f, v) with
            | (Raise(_,_,_) as xn, _) 	-> (xn, s2)
            | (_, (Raise(_,_,_) as xn))	-> (xn, s2)
            | (Function(var, t, e), vl) -> eval1 (subst(e, vl, var), s2) 
	          | (_, _) 										-> raise TypeMismatch)
            
	    | Ref(e) -> 
	      let (v, s1) = eval1 (e, s) in
          (match v with
            | Raise(_,_,_) -> (v, s1)
            | _         	 -> let c = Store.fresh() in (c, Store.modify(s1, c, v)))
	    | Set(e1, e2) -> 
          (match eval1 (e1, s) with 
            | (Raise(_,_,_) as xn, s1) -> (xn, s1) 
            | (Cell(n), s1)  					 -> 
              let (v, s2) = eval1(e2, s1) in (match v with
                | Raise(_,_,_)  -> (v, s2)
                | _             -> (v, Store.modify(s2, Cell(n), v)))
	          |  _ 								-> raise TypeMismatch)
	    | Get(e) -> 
	        (match eval1(e, s) with 
            | (Raise(_,_,_) as xn, s1) -> (xn, s1)
	          | (Cell(n), s1) 					 -> (Store.lookup(s1, Cell(n)), s1)
		        | _ 											 -> raise TypeMismatch)
          
	    | Record(body) -> evalRecord (body, s)
	    | Select(l, e) -> 
          (match eval1 (e, s) with
            | (Raise(_,_,_) as xn, s1) -> (xn, s1)  
	          | (Record(body), s1)       -> (lookupRecord (body,l), s1)
	          | _ 									     -> raise TypeMismatch)

      | Raise(n, t, e) -> 
          let (v, s1) = eval1 (e, s) in (match v with
            | Raise(_, _, _) -> (v, s1)
            | _              -> (Raise(n, t, v), s1))
      | Try(e1, exnid, var, t, e2) ->
          let (v, s1) = eval1 (e1, s) in (match v with
            | Raise(n, t, vl) when n = exnid -> eval1 (subst(e2, vl, var), s1)
            | _                              -> (v, s1))
        
)
else raise NotClosed;;
    

let eval interm = match eval1(interm, Store.empty) with 
  | (outvalue, outstate)  -> outvalue;;
