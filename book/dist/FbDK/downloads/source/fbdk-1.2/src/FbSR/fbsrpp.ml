open Fbsrast;;

let rec pp e pad =
  match e with
    Bool(true) -> "True"
  | Bool(false) -> "False"
  | Int(x) -> string_of_int x
  | Plus(e1, e2) -> 
      pp e1 pad ^ " + " ^ pp e2 pad
  | Minus(e1, e2) ->
      pp e1 pad ^ " - " ^ pp e2 pad
  | Equal(e1, e2) ->
      pp e1 pad ^ " = " ^ pp e2 pad
  | And(e1, e2) ->
      pp e1 pad ^ " And " ^ pp e2 pad
  | Or(e1, e2) ->
      pp e1 pad ^ " Or " ^ pp e2 pad
  | Not(e1) ->
      "Not " ^ pp e1 pad
  | Appl(e1, e2) ->
      "(" ^ pp e1 pad ^ ") (" ^ pp e2 pad ^ ")"
  | Var(Ident(x)) -> x
  | Function(Ident(i), x) ->
      let newpad = pad ^ "  " in
      "Function " ^ i ^ " ->\n" ^ newpad ^ pp x newpad 
  | If(e1, e2, e3) ->
      let newpad = pad ^ "  " in
      "If " ^ pp e1 pad ^ " Then\n" ^ newpad ^ pp e2 newpad ^ "\n" ^
      pad ^ "Else\n" ^ newpad ^ pp e3 newpad
  | Letrec(Ident(i1), Ident(i2), e1, e2) -> 
      let newpad = pad ^ "  " in
      "Let Rec " ^ i1 ^ " " ^ i2 ^ " =\n" ^ newpad ^ pp e1 newpad ^ "\n" ^
      pad ^ "In\n" ^ newpad ^ pp e2 newpad
  | Record body -> "{" ^ pp_record body pad^ "}"
  | Get e -> "!" ^ pp e pad
  | Set(e1, e2) -> pp e1 pad ^ " := " ^ pp e2 pad
  | Ref e -> "Ref " ^ pp e pad
  | Cell i -> "<CELL #" ^ string_of_int i ^ ">"
  | Select(Lab l, e) -> pp e pad ^ "." ^ l
  | Let(Ident i, e1, e2) -> 
      let newpad = pad ^ "  " in
      "Let " ^ i ^ " = " ^ pp e1 pad ^ " In\n" ^ newpad ^ pp e2 newpad 

and pp_record body pad =
  match body with
    [] -> ""
  | (Lab l, e)::rest ->
      l ^ "=" ^ pp e pad ^
      (if rest = [] then "" else "; ") ^
      pp_record rest pad

let pretty_print e = (pp e "") ^ "\n"

