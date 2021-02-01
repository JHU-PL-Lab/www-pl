(* simple_set.ml  
   Defines the module Simple_set which is a simple functional set data structure.
*)

(* This type declaration is the data structure storing the actual sets (just a list here) 
   Note how we call the type just "t", that is because the full name will be Simple_set.t 
   -- "simple set's type" is how you can read this *)
open Core

type 'a t = 'a list

let emptyset : 'a t = []

let add (x : 'a) (s : 'a t) = (x :: s)

let rec remove (x : 'a) (s: 'a t) (equal : 'a -> 'a -> bool) =
  match s with
  | [] -> failwith "item is not in set"
  | hd :: tl ->
    if equal hd x then tl
    else hd :: remove x tl equal

let rec contains (x: 'a) (s: 'a t) (equal : 'a -> 'a -> bool) =
  match s with
  | [] -> false
  | hd :: tl ->
    if equal x hd then true else contains x tl equal
