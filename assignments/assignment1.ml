(*

POPL Assignment 1
 
Name                  : 
List of Collaborators :

Please make a good faith effort at listing people you discussed any 
problems with here, as per the course academic integrity policy.  
CAs/Prof need not be listed!

Fill in the function definitions below replacing the 

  failwith "Not Implemented"

with your code.  Feel free to add "rec" to any function listed to make
it recursive. In some cases, you will find it helpful to define
auxillary functions, feel free to.  Other than replacing the failwiths
and adding recs, don't edit or remove anything else in the file -- the
autograder will not be happy!!  Note you are NOT allowed to use the
"List.sort" etc library functions; this rule holds just for this HW
(The Autograder will not catch this but we manually look for such).
You also cannot use mutation (arrays, := etc), which we have not even
covered yet.

Some tests are provided below via OCaml's built-in assert function; they will
raise an exception on failure and return () on success.

*)

(* Problem 1 ************************************************************************ *)
(*
   Write a function split that takes a parameter n and a list and
   returns a pair of lists where the first element consists of the first n
   values from the source list and the second element is the remainder of that
   list.  If n is greater than the length of the list, the first list should
   contain the entire source list and the second list should be empty.
   n >= 0 should hold; invoke the built-in invalid_arg to exit if not.
*)

let split n l = failwith "Not Implemented";;

(* assert( split 3 [1;2;3;4;5;6;7;8;9] = ([1; 2; 3], [4; 5; 6; 7; 8; 9]))
   assert( split 3 [1;2] = ([1;2], []) )
*)

(* Problem 2 ************************************************************************ *)

(*
   Define a function interleave which take two lists and interleaves their elements,
   starting with the left list first.  See the test cases to be clear on the cases 
   where the lengths differ -- it just fills in with the tail of the longer list.
*)

let interleave l1 l2 = failwith "Not Implemented";;

(* assert ( interleave [1; 3; 5] [2; 4] = [1; 2; 3; 4; 5] )
   assert ( interleave [1; 3; 5] [2; 4; 6] = [1; 2; 3; 4; 5; 6] )
   assert ( interleave [1; 3; 5] [2; 4; 6; 7] = [1; 2; 3; 4; 5; 6; 7] )
   assert ( interleave ["a"; "c"; "e"; "f"] ["b"; "d"] = ["a"; "b"; "c"; "d"; "e"; "f"] )
*)

(* Problem 3 ************************************************************************ *)

(* Define a function circular_left_shift taking a list and rotating the elements
   so the first element becomes the last; the length of the list remains the same.  *)


let circular_left_shift l = failwith "Not Implemented";;

(* assert(circular_left_shift [1; 2; 10] = [2; 10; 1])
   assert(circular_left_shift ["aye"; "boo"; "sea"] = ["boo"; "sea"; "aye"])
*)


(* Problem 4 ************************************************************************ *)

(* Define a function circular_left_shift_n l n taking a list and a number n
   and circularly rotating to the left n times. *)

let circular_left_shift_n l n = failwith "Not Implemented";;

(* assert( circular_left_shift_n [1; 2; 10] 1 = [2; 10; 1])
   assert( circular_left_shift_n ["aye"; "boo"; "sea"] 2 = ["sea"; "aye"; "boo"] )
   assert( circular_left_shift_n ["aye"; "boo"; "sea"] 300 = ["aye"; "boo"; "sea"] )
   assert( let noop_list l = circular_left_shift_n l (List.length l) in (noop_list [1;3;2]) = [1;3;2] )
*)

(* Problem 5 ************************************************************************ *)

(* Define a function extract_inverses that takes a list of functions
   from integers to integers, and returns a pair of the first two functions f and
   g on the list such that g(f 0) = 0, i.e. they are inverses at 0.
   Since there may be no such pair the function needs to return something in that case;
   use the built-in 'a option type to return Some( a pair ) if so and None if none exists.
*)

let extract_inverses l = failwith "Not Implemented";;

(* let is_inv p = match p with None -> false | Some(f,g) -> g (f 0) = 0
   assert( is_inv(extract_inverses [(fun x -> x)]) )
   assert( is_inv(extract_inverses [(fun x -> x + 1); (fun x -> x + 2); (fun x -> x - 1)]) )
   assert( extract_inverses [(fun x -> x + 1); (fun x -> x + 2)] = None )
   assert( is_inv(extract_inverses [(fun x -> x + 1); (fun x -> x); (fun x -> x - 1)]) )
   Note that in this last case (fun x -> x) is in inverse of itself, but it is not the first 
   function in the list so extract_inverses should not return it; the test harness
   here is too simple to catch that case however.  "First" means any one is first, not both.
*)

(* Problem 6 ************************************************************************ *)
(*
 
  Define a function extract_mins which takes a list and extracts all the instances of 
  the smallest element in a separate list; the result is then a pair of lists, the first
  list being all the smallest elements (a list of the same thing repeated), and the
  second being the same as the original list with all these smallest elements missing.
  Empty lists have no elements so they have no smallest elements..
*)

let extract_mins l = failwith "Not Implemented";;

(* 
  assert ( extract_mins [5;2;4;1;9] = ([1], [5; 2; 4; 9]) )
  assert ( extract_mins [0;1;0;0;0;1] = ([0; 0; 0; 0], [1; 1]) )
 *)

(* Problem 7 ************************************************************************ *) 

(* Selection sort is a simple but slow sorting method which you may have seen before..
   just keep extracting the smallest element(s) and moving them to the front.
   For this question write a selection_sort function which could repeatedly invoke 
   extract_mins from the previous question to sort the list. *)

let selection_sort f lst = failwith "Not Implemented";;

(* 
  assert ( selection_sort [5;2;4;1;9] = [1; 2; 4; 5; 9] )
  assert ( selection_sort [0;1;0;0;0;1] = [0; 0; 0; 0; 1; 1] )

  Note that even if these tests succeed you may lose points as you are required to
  implement a selection sort, not mergesort or use built-in List.sort.
 *)



(* Problem 8 ************************************************************************ *)
(* 

One way to represent a vector is as a list. Given two vectors 

      v1 = [a0; a1; .. an] and v2 = [b0; b1; .. bn],

      the scalar product v1 . v2  is defined as  a0 * b0 + a1 * b1 + ... + an * bn.
			
In a language like OCaml without overloaded operators, directly writing the
expression with arithemetic operators forces us to fix a type for the vector
coordinates. For example if we used operators ( * ) and ( + ), the vector
coordinates can only be of type int. To use vectors with floating point
coordinates we will have to write a new function. The way to generalize this (as
usual) is to hide the base operations behind functions. The above expression has
two basic operations - multiplication of two values and addition of a list of
values. We define two parameters creatively named prod_fn and sum_fn where
prod_fn is a binary function and sum_fn is a function over lists.

Given the two functions and two vectors (represented as lists), write a function
to compute the scalar product. If the vector dimensions differ, raise an
exception using the OCaml built-in invalid_arg.
			
*)

let scalar_product prod_fn sum_fn v1 v2 = failwith "Not Implemented";;

(* 
  let rec sum_int lst = match lst with [] -> 0 | h::t -> h + (sum_int t) in
    assert ( scalar_product ( * ) sum_int [1 ; 2 ;3 ] [4 ; 5 ; 6] = 32 )
  let rec sum_float lst = match lst with [] -> 0.0 | h::t -> h +. (sum_float t) in
    assert ( scalar_product ( *. ) sum_float [1.0 ; 2.0 ;3.0 ] [4.0;5.0;6.0] = 32. )
  assert ( scalar_product ( ^ ) (String.concat ", ") ["a"; "b"; "c"] ["1" ; "2" ; "3"] = "a1, b2, c3" )
*)

(* Problem 9 ************************************************************************ *)

(* 

Similar to the Vector representation , a matrix can be represented as a
list of lists with each list representing a row of the matrix. (Clearly each of
these lists must have the same length).

Define a function to multiply two matrices. The calculation involved is very similar to
the case with vectors. So to maintain generality we once again hide the multiplication and
addition operations behind the two functions (prod_fn and sum_fn).
 
If the two matrices cannot be multiplied (due to dimension mismatches), raise an exception 
(using the built-in invalid_arg function).
			
*)

let matrix_mult prod_fn sum_fn matrix_1 matrix_2 = failwith "Not Implemented" ;;
  
(* 
  let rec sum_int lst = match lst with [] -> 0 | h::t -> h + (sum_int t)
  assert ( matrix_mult ( * ) sum_int [ [1;2] ] [ [3] ; [4] ] = [[11]] )
  let m1 = [ [14;9;3] ; [2;11;15] ; [0;12;17] ; [5;2;3] ] in
  let m2 = [ [12;25] ; [9;10] ; [8;5] ] in
    assert ( matrix_mult ( * ) sum_int m1 m2 = [[273; 455]; [243; 235]; [244; 205]; [102; 160]] )
*)


