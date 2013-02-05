(*
600.426 - Programming Languages
JHU Spring 2013
Homework 1

In this source file, you will find a number of comments containing the text
"ANSWER".  Each of these comments indicates a portion of the source code you
must fill in yourself.  Read the instructions for each problem and supply a
segment of code which accomplishes the indicated task.  For your convenience,
a number of test expressions are provided for each problem as well as a
description of their expected values.

Please also fill in the HEADER section right below this one.

Please note that you are NOT permitted to use any OCaml module functions (such
as List.length) to complete this assignment. You are also not permitted to make 
use of mutation (references, arrays, etc.). On the other hand you are encouraged 
to write additional helper functions and reuse earlier functions in the file.
*)


(* -------------------------------------------------------------------------------------------------- *)
(* HEADER: PLEASE FILL THIS IN                                                                        *)
(* -------------------------------------------------------------------------------------------------- *)

(*
 
Name                  :
List of team Members  : 
List of discussants   :

*)

(* -------------------------------------------------------------------------------------------------- *)
(* Warm up                                                                                            *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  1a. Functions can be composed with themselves and it is a process that can be repeated
      indefinitely. f o f is usuall denoted as f^2 (^2 indicates the superscript 2).
      
      Given a function and a count n, write a function to compute f^n
      
      [5 Points]
*)   
let rec composen f n = () ;; (* ANSWER *) 

(*
# let f = composen (fun x -> x * 2) 5 in f 2 ;; 
- : int = 64
# let f = composen (fun x -> x / 3) 5 in f 100 ;;
- : int = 0
*)

(* 
  1b. Write a function to take a positive integer as input and produce its corresponding binary string 
      as output. E.g. An input 123 should produce the string "1111011"
  
      [10 Points]
*)
let rec to_binary v = () ;; (* ANSWER *) 

(* -------------------------------------------------------------------------------------------------- *)
(* Lists and higher order functions                                                                   *)
(* -------------------------------------------------------------------------------------------------- *)

(* 
   2a. Write a function to take a count 'n' >= 0 and a value 'v' and produce a list of
       size n containing all v.  
 
       [6 Points]
*)
let rec replicate n v = () ;; (* ANSWER *) 

(*
# replicate 3 "Foo" ;;
- : string list = ["Foo"; "Foo"; "Foo"]
*)
  
(*
  2b. Write a function that filters a list based on a predicate (a function that returns a
      boolean).  The returned list should contain only those elements that satisfy the
      predicate (i.e. returns true when applied to the predicate)
  
      [7 Points]
*)
let rec filter fn lst = () ;; (* ANSWER *)  
 
(*
# filter (fun x -> x mod 2 = 0) [1;2;3;4;5;6;7] ;;
- : int list = [2; 4; 6]
# filter (fun x -> x < 0) [1;3;5] ;;
- : int list = []
*)

(*
  2c. Given a list of values, turn it in to a list of non-increasing values by deleting
      any values that are less than the previous. 
  
      It is possible to use the < operator for comparison since it is polymorphic. However we
      can generalize this a bit further by allowing the caller to supply a comparison function.
      The comparison function is expected to have the type (a -> comparison_result). See test
      cases below.
  
      [7 Points]
*)

type comparison_result = LT | EQ | GT ;;

let monotonize lst compare_fn = () ;; (* ANSWER *) 

(*
# let simple_compare x y = if (x < y) then LT else (if (x = y) then EQ else GT) ;;
# monotonize [1;2;3;1;2;4] simple_compare ;;
- : int list = [1; 2; 3; 4]
# monotonize [(1,2);(2,3);(2,2);(3,2);(4,3);(5,1)] (fun (a,b) -> fun (c,d) -> simple_compare (a+b) (c+d)) ;;
- : (int * int) list = [(1, 2); (2, 3); (3, 2); (4, 3)]
*)

(*
  2d. Given a list and a user supplied comparison function (of the type described above),
      write a function to remove duplicates from the list, retaining only the first occurrence
      of any element.
  
      [10 Points]
*)
let rec remove_duplicates compare_fn lst = () ;; (* ANSWER *) 
  
(*
# let simple_compare x y = if (x < y) then LT else (if (x = y) then EQ else GT) ;;
# remove_duplicates simple_compare [1;3;2;4;3;1;5]  ;;
- : int list = [1; 3; 2; 4; 5]
# remove_duplicates (fun (k1, _) -> fun (k2, _) -> simple_compare k1 k2)  [("foo",1);("bar",2);("foo",2);("moo",4)] ;;
- : (string * int) list = [("foo", 1); ("bar", 2); ("moo", 4)]  
*)

(* -------------------------------------------------------------------------------------- *)
(* Quick Sort                                                                             *)
(* -------------------------------------------------------------------------------------- *)

(*
  3a. First write a partition function that takes a list and a pivot value and returns a triple of lists. 
	    The first list should contain all values less than the pivot, the second list contains 
	    values equal to the pivot and the third list contains values greater than the pivot. 
  
      As before we also allow the user to supply a comparison function.
  
      [10 Points]
*)

let rec partition compare_fn lst pivot = () ;; (* ANSWER *) 


(*
  3b. Now write a function to sort a given list using the quicksort algorithm. You take a
      comparison function and a list of data as input.

      [10 Points]
*)
let rec quicksort compare_fn lst = () ;; (* ANSWER *) 

(*
# let simple_compare x y = if (x < y) then LT else (if (x = y) then EQ else GT) ;;
# quicksort simple_compare [3;5;2;9;7;6;4;1]  ;;
- : int list = [1; 2; 3; 4; 5; 6; 7; 9]
# quicksort (fun (a,b) -> fun (c,d) -> simple_compare (a+b) (c+d)) [(1,4);(2,1);(3,4);(5,1);(6,2)] ;;
- : (int * int) list = [(2, 1); (1, 4); (5, 1); (3, 4); (6, 2)]
*)

(* -------------------------------------------------------------------------------------- *)
(* Dictionaries                                                                           *)
(* -------------------------------------------------------------------------------------- *)

(*
  4. An easy, if inefficient, way to create maps/dictionaries is to store the data as
     (key-value) pairs in a list. We can then write code to manipulate the list as a
     dictionary. For the following questions we will consider this dictionary represention.
*)

(*
  4a. Given a dictionary, a key and a default value, write a function to fetch the value
      corresponding to the key in the dictionary. If there is no mapping for the key, return
      the default value instead

      [7 Points]
*)
let rec fetch_value dict key default = () ;; (* ANSWER *) 

(*
# fetch_value [("foo", 1);("bar", 2);("moo", 4)] "moo" 0 ;;
- : int = 4
# fetch_value [(1, "one");(2, "two");(3, "three")] 4 "zero";;
- : string = "zero"
*)
  
(*
  4b. Given a dictionary, a key and a value, write a function to insert the key-value
      mapping in to the dictionary. If another value is currently mapped to the key, it should
      be replaced with the new mapping.  The function should return the new dictionary.

      [9 Points]
*)
let rec insert_key_value dict key value = () ;; (* ANSWER *) 

(*
# let d1 = insert_key_value [] "foo" 1 ;;
val d1 : (string * int) list = [("foo", 1)]
# let d2 = insert_key_value d1 "bar" 2 ;;
val d2 : (string * int) list = [("foo", 1); ("bar", 2)]
# let d3 = insert_key_value d2 "bar" 3 ;;
val d3 : (string * int) list = [("foo", 1); ("bar", 3)]
*)

(*
  4c. Given a dictionary and a key, write a function to delete the mapping corresponding
      to the key (if one exists) and return the modified dictionary. If there is no mapping,
      the dictionary does not change and is returned as is.

      [9 Points]
*)
let rec delete_key dict key = () ;; (* ANSWER *) 

(*
# delete_key [("foo", 1);("bar", 2);("moo", 4)] "bar" ;;
- : (string * int) list = [("foo", 1); ("moo", 4)]
*)


(*
  4d. Given a 'membership' function that can map a data element to a list of groups (ids)
      that it belongs to, write a function that accepts a list of data elements and produces a
      dictionary. Each key in the dictionary is a group id and the corresponding value is the
      list of data elements that belong to that group.
  
      [10 Points]
*)  
let rec group_by membership_fn lst = () ;; (* ANSWER *) 
    
(*
let f n = match n with x when x mod 15 = 0 -> ["15";"3";"5"] | x when x mod 3 = 0 -> ["3"] | x when x mod 5 = 0 -> ["5"] | x -> ["Def"] ;;
val f : int -> string list = <fun>
group_by f [1;3;5;9;10;12;15;27;30] ;;
# group_by f [1;3;5;9;10;12;15;27;30] ;;
- : (string * int list) list = [("Def", [1]); ("3", [3; 9; 12; 15; 27; 30]); ("5", [5; 10; 15; 30]);("15", [15; 30])]
*)