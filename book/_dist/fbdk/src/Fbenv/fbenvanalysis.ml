(*
 * Environment-based analysis, built by abstracting the interpreter.
 *)

open Fbast;;
open Fbinterp;;
open Fbenvinterp;; (* let us depend on the interpreter *)


(* abstract booleans with explicit undefined value *)
type abool = T | F | UBool

(* abstract ints (neg/zero/pos here) with explicit undefined value *)

type aint = N | Z | P |UInt

(* The abstract analogue of eexpr is aexpr. *)

type  aexpr =
  | AVar of ident | AFunction of ident *  aexpr | AAppl of int *  aexpr *  aexpr
  (*| ALet of ident *  aexpr *  aexpr - translate out for simplicity *) | ALetRec of ident * ident *  aexpr *  aexpr
  | APlus of  aexpr *  aexpr | AMinus of  aexpr *  aexpr | AEqual of  aexpr *  aexpr
  | AAnd of  aexpr *  aexpr| AOr of  aexpr *  aexpr | ANot of  aexpr
  | AIf of  aexpr *  aexpr *  aexpr | AInt of aint | ABool of abool
  | AClosure of  aexpr * (int list)

(* convert expr to aexpr *)
  
let to_abs_int i = if i = 0 then AInt(Z) else if i<0 then AInt(N) else AInt(P)
let to_abs_bool b = 
    match b with
    | true -> ABool(T)
    | false -> ABool(F)
    
(* Should alphatize in the following given how crossed wires issue can arise. *)    
let expr_to_aexpr e =
  let newnum = newnewnum() in
  let rec expr_to_aexpr_worker e =
   match e with
       Var(x) -> AVar(x)
     | Int(x) -> (to_abs_int x)
     | Bool(x) -> (to_abs_bool x)
     | Let(i, e1, e2) -> AAppl(newnum(),AFunction(i, expr_to_aexpr_worker e2), expr_to_aexpr_worker e1)
     | LetRec(i1, i2, e1, e2) -> failwith "unimplemented"
     | Function(i, e1) -> AFunction(i, expr_to_aexpr_worker e1)
     | Appl(e1, e2) -> AAppl(newnum(),expr_to_aexpr_worker e1, expr_to_aexpr_worker e2)
     | Plus(e1, e2) -> APlus(expr_to_aexpr_worker e1, expr_to_aexpr_worker e2)
     | Minus(e1, e2) -> AMinus(expr_to_aexpr_worker e1, expr_to_aexpr_worker e2)
     | Equal(e1, e2) -> AEqual(expr_to_aexpr_worker e1, expr_to_aexpr_worker e2)
     | And(e1, e2) -> AAnd(expr_to_aexpr_worker e1, expr_to_aexpr_worker e2)
     | Or(e1, e2) -> AOr(expr_to_aexpr_worker e1, expr_to_aexpr_worker e2)
     | Not(e1) -> ANot(expr_to_aexpr_worker e1)
     | If(e1, e2, e3) -> AIf(expr_to_aexpr_worker e1, expr_to_aexpr_worker e2, expr_to_aexpr_worker e3)
                           
  in expr_to_aexpr_worker e

(* Abstract operations *)

let aplus x y = match (x,y) with
    | (AInt(P),AInt(P)) -> AInt(P)
    | (AInt(N),AInt(N)) -> AInt(N)
    | (AInt(Z),AInt(P)) -> AInt(P)
    | (AInt(Z),AInt(N)) -> AInt(N)
    | (AInt(_),AInt(_)) -> AInt(UInt)
    | _ -> raise TypeMismatch

let aminus x y = match (x,y) with
    | (AInt(P),AInt(N)) -> AInt(P)
    | (AInt(N),AInt(P)) -> AInt(N)
    | (AInt(Z),AInt(P)) -> AInt(N)
    | (AInt(Z),AInt(N)) -> AInt(P)
    | (AInt(_),AInt(_)) -> AInt(UInt)
    | _ -> raise TypeMismatch

let aequal x y = match (x,y) with
     | (AInt(Z),AInt(Z)) -> ABool(T)
    | (AInt(P),AInt(N)) -> ABool(F)
    | (AInt(_),AInt(_)) -> ABool(UBool)
    | _ -> raise TypeMismatch

module IdentMapOrd =
       struct
         type t = aexpr IdentMap.t
         let compare = IdentMap.compare (IdentOrd.compare)
       end

module IdentMapSet = Set.Make(IdentMapOrd)

module AExprOrd =
       struct
         type t = aexpr
         let compare = Stdlib.compare
       end

module AExprSet = Set.Make(AExprOrd)

let ainit_s = (IntListMap.add [] (IdentMapSet.singleton (IdentMap.empty)) (IntListMap.empty))

(* nondeterministic lookup of an ident in the store; returns AExprSet of possible values *)

(* old version not dealing with crossed wires case. *)
let alookup_old ident c s =
  let envts = IntListMap.find c s in
   IdentMapSet.fold (fun envt valset -> AExprSet.add (IdentMap.find (ident) envt) valset ) envts AExprSet.empty

(* New lookup which deals with crossed wires case hopefully. If variable doesn't exist in mapping it means the wrong
   closure was grabbed, and this means we are provably in a case that will not exist in an actual run - skip over it *)
let alookup ident c s =
  let envts = IntListMap.find c s in
   IdentMapSet.fold (fun envt valset -> 
     try let value = (IdentMap.find (ident) envt) in
       (AExprSet.add value valset)
     with Not_found -> valset) envts AExprSet.empty

(* Result state sets *)

module AExprStateOrd =
       struct
         type t = aexpr * IdentMapSet.t IntListMap.t
         let compare = fun (x1,x2) (y1,y2) -> 
            let lefts = Stdlib.compare x1 y1 in
              if lefts = 0 then IntListMap.compare (fun x -> fun y -> IntListOrd.compare x y) x2 y2 else lefts
       end

module AExprStateSet = Set.Make (AExprStateOrd)

(* configuration sets - for cycle detection *)

module ConfigOrd =
       struct
         type t = aexpr * int list * IdentMapSet.t IntListMap.t
         let compare = fun (ae1,l1,map1) (ae2,l2,map2) -> 
            let lefts = Stdlib.compare (ae1,l1) (ae2,l2) in
              if lefts = 0 then IntListMap.compare (fun x -> fun y -> IntListOrd.compare x y) map1 map2 else lefts
       end

module ConfigSet = Set.Make (ConfigOrd)

let k = ref 1 (* allow k to be changed *)

let rec trimto lis k = 
  match lis with 
  | [] -> []
  | h::t -> if k=0 then [] else h :: trimto t (k-1)

let consk elt lis = trimto (elt::lis) (!k)

(* All binops are alike, extract the common code to a function *)

let binopper aevaler e1 e2 c s nv op = 
       let configs1 = aevaler e1 c s nv in
         AExprStateSet.fold 
            (fun (v1,s1) results1 -> 
              let configs2 = aevaler e2 c s1 nv in 
              let configset1 = AExprStateSet.fold 
                (fun (v2,s2) results2 ->
                   let me = op v1 v2 s1 s2 in
                      AExprStateSet.union me results1
                ) configs2 AExprStateSet.empty in
                AExprStateSet.union configset1 results1
            ) configs1 AExprStateSet.empty

let extend_IntListMap c envts s =
  if IntListMap.mem c s then 
  let curset = (IntListMap.find c s) in
    IntListMap.add c (IdentMapSet.union envts curset) s
  else IntListMap.add c envts s

(* Main abstract executor.  Takes expression, context, store, visited-configs set, returns set of results. *)

let rec aevaler e c s visited = 
if ConfigSet.mem (e,c,s) visited then AExprStateSet.empty else
let nv = ConfigSet.add (e,c,s) visited in
match e with
  | AVar(Ident(x)) -> 
    let values = alookup (Ident x) c s in  
      AExprSet.fold (fun v set -> AExprStateSet.add (v,s) set) values AExprStateSet.empty
  | ABool(x) -> AExprStateSet.singleton  (ABool(x),s)
  | AInt(x) -> AExprStateSet.singleton  (AInt(x),s)
  | AFunction(x, e1) -> AExprStateSet.singleton  (AClosure (AFunction(x, e1),c),s)
  | ALetRec(i1, i2, e1, e2) -> failwith "unimplemented"
  | AAnd(e1, e2) -> 
      binopper aevaler e1 e2 c s nv
       (fun v1 v2 s1 s2 -> 
           match (v1,v2) with
          |  (ABool(T), ABool(T)) -> AExprStateSet.singleton (ABool(T),s2)
          |  (ABool(_), ABool(F)) -> AExprStateSet.singleton (ABool(F),s2)
          |  (ABool(F), ABool(_)) -> AExprStateSet.singleton (ABool(F),s2)
          |  (ABool(_), ABool(_)) -> AExprStateSet.singleton (ABool(UBool),s2)
          | _ -> raise TypeMismatch)  
  | AOr(e1, e2) -> 
      binopper aevaler e1 e2 c s nv 
       (fun v1 v2 s1 s2 -> 
           match (v1,v2) with
          |  (ABool(F), ABool(F)) -> AExprStateSet.singleton (ABool(F),s2)
          |  (ABool(_), ABool(T)) -> AExprStateSet.singleton (ABool(T),s2)
          |  (ABool(T), ABool(_)) -> AExprStateSet.singleton (ABool(T),s2)
          |  (ABool(_), ABool(_)) -> AExprStateSet.singleton (ABool(UBool),s2)
          | _ -> raise TypeMismatch)
  | ANot(e1) ->
     let configs1 = aevaler e1 c s nv in
       AExprStateSet.fold 
          (fun (v1,s1) results1 -> 
                let me = (match v1 with
                    | ABool(T) -> AExprStateSet.singleton (ABool(F),s)
                    | ABool(F) -> AExprStateSet.singleton (ABool(T),s)
                    | ABool(UBool) -> AExprStateSet.singleton (ABool(UBool),s)
                    | _ -> raise TypeMismatch) in
                      AExprStateSet.union me results1
                ) configs1 AExprStateSet.empty
  | APlus(e1, e2) ->
     binopper aevaler e1 e2 c s nv 
         (fun v1 v2 s1 s2 -> 
             match (v1,v2) with
        |  (AInt(x), AInt(y)) -> AExprStateSet.singleton  (aplus (AInt(x)) (AInt(y)),s)
        | _ -> raise TypeMismatch)        
  | AMinus(e1, e2) ->
     binopper aevaler e1 e2 c s nv 
         (fun v1 v2 s1 s2 -> 
             match (v1,v2) with
        |  (AInt(x), AInt(y)) -> AExprStateSet.singleton  (aminus (AInt(x)) (AInt(y)),s)
        | _ -> raise TypeMismatch)       
  | AEqual(e1, e2) ->
     binopper aevaler e1 e2 c s nv 
         (fun v1 v2 s1 s2 -> 
             match (v1,v2) with
        |  (AInt(x), AInt(y)) -> AExprStateSet.singleton  (aequal (AInt(x)) (AInt(y)),s)
        | _ -> raise TypeMismatch)    
 | AIf(p, e1, e2) ->
        let configs1 = aevaler p c s nv in
            AExprStateSet.fold 
            (fun (v1,s1) results1 -> 
                let configs = 
                (match v1 with
                | ABool(T) -> aevaler e1 c s1 nv
                | ABool(F) -> aevaler e2 c s1 nv
                | ABool(UBool) -> AExprStateSet.union (aevaler e1 c s1 nv) (aevaler e2 c s1 nv)
                | _ -> raise TypeMismatch)
                in
                AExprStateSet.union configs results1
            ) configs1 AExprStateSet.empty   
  | AAppl(l,e1, e2) ->
           let configs1 = aevaler e1 c s nv in
        AExprStateSet.fold 
            (fun (v1,s1) results1 -> 
              let configs2 = aevaler e2 c s1 nv in 
              let configset1 = AExprStateSet.fold 
                (fun (v2,s2) results2 ->
                    match (v1,v2) with
                         (AClosure (AFunction(x, e'),c1), v2) ->
                        let funenvts = IntListMap.find c1 s2 in
                        let newenvts = IdentMapSet.map (fun im -> IdentMap.add x v2 im) funenvts in 
                        let newstore = extend_IntListMap (consk l c) newenvts s2 in
                        AExprStateSet.union (aevaler e' (consk l c) newstore nv) results2
                    | _ -> raise TypeMismatch
                ) configs2 AExprStateSet.empty in 
                AExprStateSet.union configset1 results1
            ) configs1 AExprStateSet.empty
  | _ -> raise TypeMismatch

(* The following evaluates Fb expr's ("source code") *)

let aeval e =
  if not (closedp e []) then
    raise NotClosed
  else aevaler (expr_to_aexpr e) [] ainit_s ConfigSet.empty

(* 

Some convenience functions to display results and also to parse string input.

To see full data structures if too much is ...'d: 

#print_length 100000;;
#print_depth 100000;;

*)

let amapdump s = 
  List.map 
    (fun (c,value) -> (c, List.map 
                          (fun im -> IdentMap.bindings im) (IdentMapSet.elements value))) 
    (IntListMap.bindings s)

let configdump configs = List.map (fun (v,s) -> (v,amapdump s))  (AExprStateSet.elements configs)

let results configs = List.map (fun (v,s) -> v) (AExprStateSet.elements configs)

let parse s =
    let lexbuf = Lexing.from_string (s^";;") in
  	Fbparser.main Fblexer.token lexbuf

let ae s = results (aeval (parse s))

let aedump s = configdump (aeval (parse s))

(*
For debugging can use Dum, marginally useful tho
utop -require dum
# Dum.to_stdout (123, "abc", Not_found, [`A; `B 'x']);;

*)