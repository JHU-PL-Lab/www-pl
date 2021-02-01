(* simple_set.ml  
   Defines the module Simple_set which is a simple functional multiset data structure.
*)

(* This type declaration is the data structure storing the actual sets (just a list here) 
   Note how we call the type just "t", that is because the full name will be Simple_set.t 
   -- "simple set's type" is how you can read this *)

type 'a t = 'a list

let emptyset : 'a t = []

let add (x : 'a) (s : 'a t) = (x :: s)

let rec remove (x : 'a) (s: 'a t)  =
  match s with
  | [] -> failwith "item is not in set"
  | hd :: tl ->
    if  hd = x then tl
    else hd :: remove x tl

let rec contains (x: 'a) (s: 'a t) =
  match s with
  | [] -> false
  | hd :: tl ->
    if x = hd then true else contains x tl
