(* PL'2002 
   FbSR Intepreter 
*)

open Fbsrast;;

(* Insert your code here *)
exception TypeMismatch;;
exception Doh;;
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
    | LetRec(i1, i2, x, y) -> 
        isClosed2 x (i1::i2::ilist) &&
        isClosed2 y (i1::ilist)
    | Function(i, x) -> isClosed2 x (i::ilist)
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
    | Let(i, x, y) -> isClosed2 x ilist && isClosed2 y (i::ilist)	           
  in isClosed2 term []

          
let rec recordSubst(body,sub,id) = (match body with [] -> []
      | ((l,t1)::xs) -> (l,subst(t1,sub,id))::recordSubst(xs,sub,id))

and subst(exp0,sub,ide0) = 
  match exp0 with
    Function(i,exp1) -> if i = ide0 then Function(i,exp1) 
    else Function(i,subst(exp1,sub,ide0))
  | LetRec(iname, i, exp1, exp2) -> 
      if iname = ide0 then
        LetRec(iname, i, exp1, exp2)
      else if i = ide0 then
        LetRec(iname, i, exp1, subst(exp2, sub, ide0))
      else
        LetRec(iname, i, subst(exp1, sub, ide0), subst(exp2, sub, ide0))
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
  | Let(i,t1,t2) -> if i = ide0 then Let(i,subst(t1, sub, ide0),t2) else
    Let(i,subst(t1,sub,ide0),subst(t2,sub,ide0))
      
let rec lookupRecord (record,Lab l) = match record with
  [] -> raise CellNotFound 
| (Lab l1,v)::xs -> if l1 = l then v else
  lookupRecord(xs,Lab l)
    
let rec evalRecord(l,s) = (match l with
  [] -> (Record([]),s)
| ((Lab lab,t1)::xs) -> 
    let (x1,s1) = eval1(t1,s) in
    (match evalRecord(xs,s1) with 
      (Record(x2),s2) -> ((Record((Lab lab,x1)::x2)),s2)
    | _ -> raise TypeMismatch))
    
    
and
    
    
eval1(exp,s) = if isClosed(exp) then
  (match exp with 
    Bool true -> (Bool true,s)
  | Bool false -> (Bool false,s)
  | Not(exp0) -> 
      let (x1,s1) = eval1(exp0,s) in 
      (match x1 with
        Bool true -> (Bool false,s1)
      | Bool false -> (Bool true,s1)
      | _ -> raise TypeMismatch)
  | And(exp0,exp1) -> 
      let (x1,s1) = eval1(exp0,s) in
      let (x2,s2) = eval1(exp1,s1) in 
      (match (x1,x2) with
        (Bool true,Bool true) -> (Bool true,s2)
      | (_,Bool false) -> (Bool false,s2)
      | (Bool false,_) -> (Bool false,s2)
      | _ -> raise TypeMismatch)
  | Or(exp0,exp1) -> 
      let (x1,s1) = eval1(exp0,s) in
      let (x2,s2) = eval1(exp1,s1) in 
      (match (x1,x2) with
        (Bool false,Bool false) -> (Bool false,s2)
      | (_,Bool true) -> (Bool true,s2)
      | (Bool true,_) -> (Bool true,s2)
      | _ -> raise TypeMismatch)
  | Int x -> (Int x,s)
  | Plus(exp0,exp1) -> 
      (match eval1(exp0,s) with (Int x1,s1) -> 
        (match eval1(exp1,s1) with (Int x2,s2) -> (Int (x1 + x2),s2)
        | _ -> raise TypeMismatch)
      | _ -> raise TypeMismatch)
  | Minus(exp0,exp1) -> 
      (match eval1(exp0,s) with (Int x1,s1) -> 
        (match eval1(exp1,s1) with (Int x2,s2) -> (Int (x1 - x2),s2)
        | _ -> raise TypeMismatch)
      | _ -> raise TypeMismatch)
  | Equal(exp0,exp1) -> 
      let (x1,s1) = eval1(exp0,s) in
      let (x2,s2) = eval1(exp1,s1) in 
      (match (x1,x2) with
        (Int x,Int y) -> (if (x = y) then (Bool true,s2) else (Bool false,s2))
      | _ -> raise TypeMismatch)
  | If(exp0,exp1,exp2) ->
      let (x1,s1) = eval1(exp0,s) in
      (match x1 with 
        (Bool true) -> (eval1(exp1,s1))
      |       (Bool false) -> (eval1(exp2,s1))
      | _ -> raise TypeMismatch)
  | Var(ide0) -> raise Doh
  | Function(ide0,exp0) -> (Function(ide0,exp0),s)
  | LetRec(iname, ide0, exp1, exp2) ->  
      let innersubst = 
        subst(exp1, (LetRec(iname, ide0, exp1, Var(iname))), iname) in
      let outersubst = 
        subst(exp2, (Function(ide0, innersubst)), iname) in
      eval1 (outersubst,s)
  | Appl(exp0,exp1) -> 
      let (x1,s1) = eval1(exp0,s) in
      let (x2,s2) = eval1(exp1,s1) in
      (match (x1,x2) with
        (Function(ide0,exp2),v) -> eval1(subst(exp2,v,ide0),s2)
      | (_,_) -> raise TypeMismatch)
  | Cell(n) -> (Cell(n),s)
  | Ref(t1) -> 
      let (v,s1) = eval1(t1,s) in
      let c = Store.fresh() in
      (c,Store.modify(s1,c,v))
  | Set(t1,t2) -> 
      (match eval1(t1,s) with (Cell(n),s1) ->
        let (x2,s2) = eval1(t2,s1) in
        (x2,Store.modify(s2,Cell(n),x2))
      |       _ -> raise TypeMismatch)
  | Get(t1) -> 
      (match eval1(t1,s) with (Cell(n),s1) -> (Store.lookup(s1,Cell(n)),s1)
      |       _ -> raise TypeMismatch)
  | Record(body) -> (evalRecord(body,s))
  | Select(l,t) -> 
      (match eval1(t,s) with 
        (Record(body),s1) -> (lookupRecord(body,l),s1)
      |       _ -> raise TypeMismatch)
  | Let(i,t1,t2) -> 
      let (x1,s1) = eval1(t1,s) in
      eval1(subst(t2,x1,i),s1))
else raise NotClosed;;
    

let eval interm = match eval1(interm, Store.empty) with 
  | (outvalue, outstate)  -> outvalue;;
