open Boolast;;

exception Bug;;

let rec eval exp = 
  match exp with 
    True -> True
  | False -> False

  | Not(exp0) -> (match eval exp0 with
      True -> False
    | False -> True
    | _ -> raise Bug)

  | And(exp0,exp1) -> (match (eval exp0, eval exp1) with
      (True,True) -> True
    | (_,False) -> False
    | (False,_) -> False
    | _ -> raise Bug)
 
  | Or(exp0,exp1) -> (match (eval exp0, eval exp1) with
      (False,False) -> False
    | (_,True) -> True
    | (True,_) -> True
    | _ -> raise Bug)

  | Implies(exp0,exp1) -> (match (eval exp0, eval exp1) with
      (False,_) -> True
    | (True,True) -> True
    | (True,False) -> False
    | _ -> raise Bug)
