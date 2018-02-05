(*

POPL Assignment 1
 
Name                  : 
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems with here, as per the
course academic integrity policy.  TA/CA/Prof need not be listed.

Fill in the function definitions below replacing the 

  failwith "Not Implemented"

with your code.  Feel free to add "rec" to any function listed to make
it recursive. In some cases, you will find it helpful to define
auxillary functions, feel free to.  Other than replacing the failwiths
and adding recs, don't edit or remove anything else in the file -- the
autograder will not be happy!  Note you are NOT allowed to use the
"List.sort" etc library functions; this rule holds just for this HW.
You also cannot use mutation (arrays, := etc), which we have not even
covered yet.

 *)

(* Problem 1 ************************************************************************ *)

(* Define a function contains taking an element and a list and returning true if the
   element is in the list, and false otherwise. *)


let contains elt l = failwith "Not Implemented";;

(* contains 10 [1; 2; 10] => true
   contains 10 [1; 2] => false
   contains "bar" ["foo"; "bar"; "baz"] => true

*)


(* Problem 2 ************************************************************************ *)

(* Define a function fromto taking two integers and generating a list of integers from the first 
   number to the 2nd. *)


let fromto n1 n2 = failwith "Not Implemented";;

(* fromto 4 10 => [4; 5; 6; 7; 8; 9; 10]
   fromto 3 (-1) => [3; 2; 1; 0; -1] *)


(* Problem 3 ************************************************************************ *)

(* Define a function remove_dups taking a list and returning a list with all duplicate 
   items in the list removed.  More precisely, retain the first such element in the list
   and remove any duplicate elements after that.

*)

let remove_dups l = failwith "Not Implemented";;

(* remove_dups [1; 2; 3; 4; 5] => [1; 2; 3; 4; 5]
   remove_dups [2; 4; 3; 2; 4] => [2; 4; 3]
   remove_dups ['a'; 'e'; 'e'] => ['a'; 'e']
*)


(* Problem 4 ************************************************************************ *)

(* Define a function remove_elts taking a list of items as well as a list of items to 
   remove from the first list, and returning a list with all occurrences of the items 
   to be removed gone.

*)

let remove_elts l reml = failwith "Not Implemented";;

(* remove_elts [1; 2; 3; 4; 5] [2; 4] => [1; 3; 5]
   remove_elts [2; 4; 3; 2; 5] [2; 4; 2] => [3; 5]
   remove_elts ['a'; 'e'] ['c'] => ['a'; 'e']

*)


(* Problem 5 ************************************************************************ *)

(* Some lists may contain many repeated elements in sequence, and a more efficient way to 
   represent such a list is to compress the repeaters.

   For this question write a function compress_list which performs this compression by 
   making a list of pairs of elements and the count of the number in sequence.  The examples 
   below should make this clear.
*)

let compress_list l = failwith "Not Implemented";;

(* compress_list [1;1;1;2;2;3] => [(1,3); (2,2); (3,1)]
   compress_list ["a";"a";"a";"a";"a";"a";"aa"] => [("a",6); ("aa",1)]
   compress_list [1;2;3]=> [(1,1); (2,1); (3,1)]
*)

(* Problem 6 ************************************************************************ *)

(* Now write the inverse of compress_list, decompress_list. *)

let decompress_list l = failwith "Not Implemented";;

(* decompress_list [(1,3); (2,2); (3,1)] => [1; 1; 1; 2; 2; 3]
   decompress_list [("a",6); ("aa",1)] => ["a"; "a"; "a"; "a"; "a"; "a"; "aa"]
   decompress_list [(1,1); (2,1); (3,1)] => [1; 2; 3]
*)


(* Problem 7 ************************************************************************ *)

(* Define a function that returns the largest element in a list.

*)

let listmax l = failwith "Not Implemented";;

(* listmax [] => Exception: Failure "empty list"
   listmax [1] => 1
   listmax ['a';'c';'e'] => 'e'
   listmax [2; 23; max_int] => 4611686018427387903
*)


(* Problem 8 ************************************************************************ *)

(* Define a function to return the second largest element of a list. Distinct 
   elements should only count once even if they are repeated in the list.  
   return failwith "list too short" for list input that is too short.

*)

let list2ndmax l = failwith "Not Implemented";;

(* list2ndmax [] => Exception: Failure "list too short"
   list2ndmax [1; 2; 3] => 2
   list2ndmax [1; 2; 2] => 1
   list2ndmax [2; 23; 233] => 23
*)


(* Problem 9 ************************************************************************ *)

(* Write a function listkmax returning the k-th largest element in a list.
   As in the previous question, elements can repeat but count only once *)


let listkmax k l = failwith "Not Implemented";;


(* 
  listkmax (-1) [1] => Exception: Failure "k must be bigger than 0"
  listkmax 1 [1] => 1
  listkmax 3 [3; 1; 6; 1; 6] => 1
  listkmax 2 [min_int; max_int; 0; 0; 0] => 0
  listkmax 5 [] => Exception: Failure "list too short"
  listkmax 5 [1; 2; 3] => Exception: Failure "list too short".
 *)

(* Problem 10 ************************************************************************ *)

(* Write a function split to split a list down the middle.

*)

let split l = failwith "Not Implemented";;

(*

  split [1;2;3;4] => ([1;2], [3;4])
  split [1;2;3] => Exception: Failure "list has an odd number of elements"

*)


(* Problem 11 ************************************************************************ *)

(* Write a function perfect_shuffle which splits a list in two and performs a perfect 
   shuffle on the two sublists.  A perfect shuffle produces a list starting with the first
   element of the first list, then the 1st element of 2nd list, then 2nd elt of 1st, 
   2nd of 2nd, etc.
   
*)

let perfect_shuffle l = failwith "Not Implemented";;

(* perfect_shuffle [1;2;3;4] => [1;3;2;4]  (* split into [1; 2] and [3; 4] and shuffle *)
   perfect_shuffle [1;2;3] => Exception: Failure "deck has an odd number of cards"

*)


(* Problem 12 ************************************************************************ *)

(* Write a function perfect_shuffles_needed: given positive integer n, make a deck of 
   n distinct "cards" and calculate how many perfect shuffles it takes to get back to the 
   original deck.  Please do the actual shuffling, giving a constructive proof of the 
   result.  You won't get any points if you short-cut it.
*)

let perfect_shuffles_needed n = failwith "Not Implemented";;

(*
   perfect_shuffles_needed 4 => 2
*) 


(* Problem 13 ************************************************************************ *)

(* Now implement imperfect_shuffle: its like a perfect shuffle but start with the 2nd pile *)

let imperfect_shuffle l = failwith "Not Implemented";;

(* imperfect_shuffle [1;2;3;4] => [3;1;4;2] 
     (* split into ([3;4] , [1;2]) and then perfect shuffle *)
*)

(* Problem 14 ************************************************************************ *)

(* imperfect_shuffles_needed: now, how many imperfect shuffles are needed to get back to 
   the original deck? *)

let imperfect_shuffles_needed n = failwith "Not Implemented";;


(* Problem 15 ************************************************************************ *) 

(* Lets have fun with lists of functions.  Write a function mega_map which takes a 
   list of functions and another list of integers the same length, and return a list 
   which applies the first function to the first element, second function to second 
   element, etc
*)


let mega_map f l = failwith "Not Implemented";;

(*
   mega_map [(fun y -> (y - 5) * 3); (fun x -> x - 4)] [10; 11] => [15; 7]
   mega_map [(fun y -> (y - 5) * 3); (fun x -> x - 4)] [10] => 
          Exception: Failure "list lengths don't match"
*)

