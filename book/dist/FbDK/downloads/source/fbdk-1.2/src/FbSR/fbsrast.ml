type label = Lab of string
    
type ident = Ident of string
    
type expr = 
  Var of ident | Function of ident * expr | Appl of expr * expr |
  Letrec of ident * ident * expr * expr | Plus of expr * expr | 
  Minus of expr * expr | Equal of expr * expr | 
  And of expr * expr | Or of expr * expr | Not of expr | 
  If of expr * expr * expr | Int of int | Bool of bool |
  Ref of expr | Set of expr * expr | Get of expr | Cell of int | 
  Record of (label * expr) list | Select of  label * expr | 
  Let of ident * expr * expr
