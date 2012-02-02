(*
600.426 - Programming Languages
JHU Spring 2012
Homework 1

In this source file, you will find a number of comments containing the text
"ANSWER".  Each of these comments indicates a portion of the source code you
must fill in yourself.  Read the instructions for each problem and supply a
segment of code which accomplishes the indicated task.  For your convenience,
a number of test expressions are provided for each problem as well as a
description of their expected values.

Please also fill in the HEADER section right below this one.

Please note that you are NOT permitted to use any OCaml module functions (such
as List.length) to complete this assignment.  You are also not permitted to
make use of mutation (references, arrays, etc.). On the other hand you are encouraged
to write additional helper functions and reuse earlier functions in the file.
*)

(* -------------------------------------------------------------------------------------------------- *)
(* HEADER: PLEASE FILL THIS IN                                                                        *)
(* -------------------------------------------------------------------------------------------------- *)

(*
 
Name                  : 
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems with here, as per the
course academic integrity policy.  TA/CA/Prof need not be listed.
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 1 : Little Functions                                                                       *)
(* -------------------------------------------------------------------------------------------------- *)

(*
	1a. One way to represent a rational number (a fraction) is as a pair of integers (n, d) where n represents the numerator 
	   of the fraction and d, the denominator with d <> 0. 
		 
		 Write a function that adds two rational numbers together. The resulting fraction must be expressed in its most reduced
		 form with a normalized sign (i.e. The negative sign, if any, should appear only on the numerator)
		 E.g: 1/2 + 7/(-4) should return -5/4 and not (say) 10/(-8) or -15/12)
		  
		 [5 Points]
*)

let rec add_rational rat1 rat2 = () ;; (* ANSWER *)

(*
# add_rational (1, 2) (7, -4) ;;
- : int * int = (-5, 4)
# add_rational (-2, 3) (7, -2) ;;
- : int * int = (-25, 6)
# add_rational (-1, -2) (3, 4) ;;
- : int * int = (5, 4)
*)


(*
	1b.Concatenate a list of strings with a seperator between each. 
	   E.g. concat "_" ["foo" ; "bar"] returns the string "foo_bar". Note that there is no seperator 
     after the last element. 
		  
		 [5 Points]
*)

let rec concat_strings sep strlist = () ;; (* ANSWER *)

(*
# concat_strings "_" ["foo" ; "bar"] ;;
- : string = "foo_bar"
# concat_strings " " ["1"] ;;
- : string = "1"
# concat_strings " " [] ;;
- : string = ""
*)

(*
  1c. Functions can be composed with themselves, a process that can be repeated indefinitely.
      f o f is usually denoted as f^2 (^2, indicating superscript 2), f o f o f as f^3 and
      so forth.

      Write a function that takes a base function f and an integer n as parameters and produces
      the list [ f ; f^2 .. f^n ].

      [5 Points]
*)

let rec generate_compositions f n = () ;; (* ANSWER *)

(*
# let rec map_all fn_list start = match fn_list with [] -> [] | f::t -> (f start)::(map_all t start) ;;
# let fn_list = generate_compositions (fun x -> x + 1) 5 ;;
val fn_list : (int -> int) list = [<fun>; <fun>; <fun>; <fun>; <fun>]
# map_all fn_list 0 ;;
- : int list = [1; 2; 3; 4; 5]
# let fn_list = generate_compositions (fun x -> x / 3) 5 ;;
val fn_list : (int -> int) list = [<fun>; <fun>; <fun>; <fun>; <fun>]
# map_all fn_list 100 ;;
- : int list = [33; 11; 3; 1; 0]
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 2 : Slicing and dicing lists                                                               *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  2a.Write a function last_element that returns the last element of a list. Raise an exception if the list is empty. You
	   can use the function invalid_arg from Pervasives for this.
	   
		 [5 Points]
*)

let rec last_element lst = () ;; (* ANSWER *)

(*
# last_element [3 ; 4 ; 5] ;;
- : int = 5
# last_element ['a' ; 'b';  'c'] ;;
- : char = 'c'
# last_element [(4,2) ; (3,1) ; (2, 3)] ;;
- : int * int = (2, 3)  
*)

(*
  2b.Write a function to reverse the first 'n' elements of a list. If n is larger that the number of elements in the
	   list, the entire list should be reversed. You can assume that n >= 0
		
	   [5 Points]
*)

let rec reverse_n n lst = () ;; (* ANSWER *)
	
(*
# reverse_n 3 [1 ; 2; 3; 4; 5; 6] ;;
- : int list = [3; 2; 1; 4; 5; 6]
# reverse_n 3 [1 ; 2; 3;] ;;
- : int list = [3; 2; 1]
# reverse_n 3 [1 ; 2; 3;4] ;;
- : int list = [3; 2; 1; 4]
# reverse_n 3 [1 ; 2; ] ;;
- : int list = [2; 1]
*)

(*
  2c.Write a function to interleave two lists and produce a single list. If one of the lists 
     is larger than the other, the "extra" elements go to the end of the resulting list 
		
	   [5 Points]
*)

let rec interleave lst1 lst2 = () ;; (* ANSWER *)

(*
# interleave [1;2;3] [0xa;0xb;0xc;0xd;0xe;0xf] ;;
- : int list = [1; 10; 2; 11; 3; 12; 13; 14; 15]
# interleave [0xa;0xb;0xc;0xd;0xe;0xf] [1;2;3];;
- : int list = [10; 1; 11; 2; 12; 3; 13; 14; 15]
# interleave ['a';'b';'c'] ['1';'2';'3'];;
- : char list = ['a'; '1'; 'b'; '2'; 'c'; '3']
# interleave ['a';'b';'c'] [];;
- : char list = ['a'; 'b'; 'c']
*)

(*
  2d. Many programming languages support the idea of a list comprehension - a mechanism
      to construct new lists from existing lists. The syntax is usually based on
      the mathematical set builder notation.

      For example the python expression lst = [ x*x for x in range(10) if x % 2 = 0 ]
      creates a list whose values are squares of even integers between 0 and 10 (exclusive).

      This construct is very functional in nature; so let us define a function - list_comprehension
      to help us with this. It takes 3 parameters - a source list of values (source), a predicate to
      filter values (pred) and a computation function (compute) to create a new value. The output is
      the list of values produced by the compute function for those source values that satisfy the
      predicate. The order of the items in the output list is based on the order in the source list.

      E.g. list_comprehension [0;1;2;3;4;5;6;7;8;9] (fun x -> (x mod 2) = 0) (fun x -> x * x) produces
      the list [0, 4, 16, 36, 64] similar to the python expression above

      [5 Points]
*)

let rec list_comprehension source pred compute =  () ;; (* ANSWER *)

(*
# let rec range n = match n with 1 -> [0] | x -> (range (n-1)) @ [x-1] ;;
val range : int -> int list = <fun>
# list_comprehension (range 101) (fun x -> (x mod 5) = 0) (fun x -> x / 5) ;;
- : int list =
[0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20]
*)

(*
  2e.Given two lists and a binary function 'f', combine the two in to a single list by "merging"
	   values at corresponding locations using f. In other words if lst_1 = [a0 ; a1 .. an] and lst_2 = [b0 ; b1 .. bn],
		 write a function that generates the list [ (f a0 b0) ; (f a1 b1) ; ... (f an bn) ]. 
		
		 If the input lists are not of the same size, raise an exception. As before you can use the "invalid_args" function 
		 from Pervasives for this. 
		
	   [5 Points]
*)

let rec combine_with f lst1 lst2 = () ;; (* ANSWER *)

(*
# combine_with (+) [1; 2; 3] [4 ; 5; 6] ;;
- : int list = [5; 7; 9]
# combine_with (fun x -> fun y -> x *. (float_of_int y)) [1.1; 2.2; 3.4] [2 ; 4; 6] ;;
- : float list = [2.2; 8.8; 20.4]
# combine_with ( fun x -> fun y -> (string_of_int x) ^ "-" ^ (string_of_int y) ) [0xa] [0xc] ;;
- : string list = ["10-12"]
*)

(*
  2f.The cartesion product of two sets S1 and S2 is the set of all pairs such that the first element of each belongs to S1
	   and the second element belongs to S2. 
		
		 We don't have a data structure for sets (yet). So we will use lists instead. Accordingly we define the cartesion product of two 
		 lists lst_1 = [a0 ; a1 .. an] and lst_2 = [b0 ; b1 .. bn] as the list [(a0, b0); (a0, b1) .. (a1, b0); (a1, b1) .. (an, bn)]
	
		 We can generalize the notion by accepting a binary function 'f' as input (similar to combine_with). The generalized cartesion
		 product is then the list [(f a0 b0); (f a0 b1) .. (f a1 b0); (f a1 b1) .. (f an bn)] 
		
		 Write a function that computes the generalized cartesion product of two lists 
	 	
	   [10 Points]
*)

let rec generalized_cartesion_product f lst1 lst2 = () ;; (* ANSWER *)
	
(*
# generalized_cartesion_product (fun x -> fun y -> (x, y)) [1; 2 ;3] [4 ; 5] ;;
- : (int * int) list = [(1, 4); (1, 5); (2, 4); (2, 5); (3, 4); (3, 5)]
# generalized_cartesion_product (fun x -> fun y -> x ^ (string_of_int y)) ["a"; "b"] [1 ; 2 ; 3];;
- : string list = ["a1"; "a2"; "a3"; "b1"; "b2"; "b3"]
# generalized_cartesion_product (fun x -> fun y -> x ^ (string_of_int y)) ["a"; "b"] [] ;;
- : string list = []
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 3 : Polynomials and some symbolic algebra                                                  *)
(* -------------------------------------------------------------------------------------------------- *)

(*
   3a. A direct, if not exceptionally elegant, way to represent simple univariate polynomials is as a list of pairs where each
       pair (c, d) represents the coefficient and the degree of a term respectively. For example the polynomial 5x^3 + 2x + 1
       is represented by the list [ (5, 3) ; (2, 1) ; (1, 0) ] or any permutation thereof. (There are no ordering
       guarantees on the list; so the polynomial [ (1, 0) ; (2, 1) ; (5, 3) ] is equivalent to the above. On the other
       hand two terms with the same degree cannot occur in the polynomial. i.e. Pairs in the list must all have
       distict second elements - [ (1, 0) ; (2, 1) ; (3, 3) ; (2, 3) ] ) is NOT a valid polynomial)

       Write a function to add two polynomials.

       For this question and the next assume that the coefficients and degree are both of the integer type.

       [10 Points]
*)

let rec add_polynomials poly_1 poly_2 = () ;; (* ANSWER *)

(*
# add_polynomials [ (5, 3) ; (2, 1) ; (1, 0) ] [ (5, 2) ; (2, 3) ; (5, 0) ]
- : (int * int) list = [(7, 3); (2, 1); (6, 0); (5, 2)]
# add_polynomials [(3, 4) ; (-2, 2) ; (3, 0)] [(2, 3) ; (1, 2) ; (-2, 0)] ;;
- : (int * int) list = [(3, 4); (-1, 2); (1, 0); (2, 3)]
*)

(*
   3b. Write a function to do polynomial multiplication.
	
	     [10 Points]
*)

let rec multiply_polynomials poly_1 poly_2 = () ;; (* ANSWER *)  
           
(*
# multiply_polynomials [(3, 4) ; (-2, 2) ; (3, 0)] [(2, 3) ; (1, 2) ; (-2, 0)] ;;
- : (int * int) list = [(6, 7); (-4, 5); (6, 3); (-6, 0); (3, 6); (-8, 4); (7, 2)]
# multiply_polynomials [(1, 2) ; (-2, 1) ; (1, 0)] [(1, 0); (-1, 0)] ;;
- : (int * int) list = [(1, 3); (-3, 2); (3, 1); (-1, 0)]
*)        

(* -------------------------------------------------------------------------------------------------- *)
(* Section 4 : Vectors and Matrices                                                                   *)
(* -------------------------------------------------------------------------------------------------- *)

(* 
  4a. One way to represent a vector is as a list. Given two vectors v1 = [a0; a1; .. an] and v2 = [b0; b1; .. bn],
	  the scalar product v1 . v2 = a0 * b0 + a1 * b1 + ... + an * bn.
			
      In a language like OCaml without overloaded operators, directly writing the expression with arithemetic operators
      forces us to fix a type for the vector coordinates. For example if we used operators ( * ) and ( + ), the vector coordinates
      can only be of type int. To use vectors with floating point coordinates we will have to write a new function. The way
      to generalize this (as usual) is to hide the base operations behind functions. The above expression has two basic operations -
      multiplication of two values and addition of a list of values. We define two parameters creatively named prod_fn and sum_fn 
      where prod_fn is a binary function and sum_fn is a function over lists. 

      Given the two functions and two vectors (represented as lists), write a function to compute the scalar product. If the vector
      dimensions differ, raise an exception using invalid_arg.
			
      [10 Points]
*)

let rec generalized_scalar_product prod_fn sum_fn v1 v2 = () ;; (* ANSWER *)

(*
let rec sum_int lst = match lst with [] -> 0 | h::t -> h + (sum_int t);;
# generalized_scalar_product ( * ) sum_int [1 ; 2 ;3 ] [4 ; 5 ; 6] ;;
- : int = 32
let rec sum_float lst = match lst with [] -> 0.0 | h::t -> h +. (sum_float t);;
generalized_scalar_product ( *. ) sum_float [1.0 ; 2.0 ;3.0 ] [4.0;5.0;6.0] ;;
- : float = 32
# generalized_scalar_product ( ^ ) (concat_strings ", ") ["a"; "b"; "c"] ["1" ; "2" ; "3"] ;;
- : string = "a1, b2, c3"
*)

(* 
  4b. Similar to the Vector representation above, a Matrix can be represented as a list of lists with each list
      representing a row of the matrix. (Clearly each of these lists must have the same length)
			
      Define a function that transposes a matrix represented this way.
			
      [10 Points]
*)

let rec transpose_matrix matrix = () ;; (* ANSWER *)
  
(* 
  4c. Define a function to multiply two matrices. The calculation involved is very similar to
      the case with vectors. So to maintain generality we once again hide the multiplication and
      addition operations behind the two functions (prod_fn and sum_fn).
 
      If the two matrices cannot be multiplied (due to dimension mismatches), raise an exception 
      (using invalid_args)
			
			[10 Points]
*)

let rec generalized_matrix_multiplication prod_fn sum_fn matrix_1 matrix_2 = () ;; (* ANSWER *)
  
(*
# let rec sum_int lst = match lst with [] -> 0 | h::t -> h + (sum_int t);;
# let m1 = [ [1;2] ] ;;
# let m2 = [ [3] ; [4] ] ;;
# generalized_matrix_multiplication ( * ) sum_int m1 m2 ;;
- : int list list = [[11]]
(* Multiplication example taken from wikipedia *)
# let m1 = [ [14;9;3] ; [2;11;15] ; [0;12;17] ; [5;2;3] ] ;;
# let m2 = [ [12;25] ; [9;10] ; [8;5] ] ;;
# generalized_matrix_multiplication ( * ) sum_int m1 m2 ;;
- : int list list = [[273; 455]; [243; 235]; [244; 205]; [102; 160]]
*)

