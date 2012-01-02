open Boolast;;

let rec pp e pad =
  match e with
    True -> "True"
  | False -> "False"
  | And(e1, e2) -> "(" ^ (pp e1 pad) ^ " And " ^ (pp e2 pad) ^ ")"
  | Or(e1, e2) -> "(" ^ (pp e1 pad) ^ " Or " ^ (pp e2 pad) ^ ")"
  | Implies(e1, e2) -> "(" ^ (pp e1 pad) ^ " Implies " ^ (pp e2 pad) ^ ")"
  | Not e -> "(Not " ^ (pp e pad) ^ ")"

let pretty_print e = pp e ""
