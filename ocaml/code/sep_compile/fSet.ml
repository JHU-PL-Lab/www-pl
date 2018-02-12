exception NotFound (* any top-level definable can be included in a module *)

type 'a set = 'a list (* sets are just lists but make a new type to keep them distinct *)

let emptyset : 'a set = []

let rec add x (s: 'a set) = ((x :: s) : ('a set)) (* observe this is a FUNCTIONAL set - RETURN new *)

let rec remove x (s: 'a set) =
  match s with
  | [] -> raise NotFound
  | hd :: tl ->
    if hd = x then (tl: 'a set)
    else hd :: remove x tl

let rec contains x (s: 'a set) =
  match s with
  | [] -> false
  | hd :: tl ->
    if x = hd then true else contains x tl
