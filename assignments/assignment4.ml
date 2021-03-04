(*

PoPL Assignment 4 part 2
Your Name : 
List of Collaborators :

   For this part, you will write some programs in Fb.  Your answers for
   this section must be in the form of OCaml strings which parse
   to Fb ASTs.  If you want a macro for repeated code, you are welcome to use OCaml
   to put strings together as we did in the `fb_examples.ml` file.
   You are also welcome to copy-paste any code from that file into here.

   Remember to test your Fb code below against the reference Fb binaries (not just 
   your own implementation of Fb which could in theory be buggy) to ensure that your 
   functions work correctly.

*)

(* Part 2 question 1.

   Fb fails to provide any operations over integers more complex
   than addition and subtraction.  Below, define the following
   2-argument Fb functions: less-than, multiplication, and 
   integer division.  (Hint: try getting them working for positive 
   numbers first and then deal with negatives.)  *)

let lt = "(0 1)";;
let mult = "(0 1)";;
let div = "(0 1)";;
  
(* Some informal tests

assert(peu ("("^lt^") 33 3") = "False");;
assert(peu ("("^lt^") (-1) 3") = "True");;
assert(peu ("("^mult^") 5 3") = "15");;
assert(peu ("("^mult^") (-3) 5") = "-15");;
assert(peu ("("^div^") 33 3") = "11");;
assert(peu ("("^div^") 87 4") = "21");;

*)

(*  Part 2 question 2.

  For this question we will consider the encoding of a simple dictionary/map 
  data type. For simplicity we will assume that they keys and values for this 
  data structure are Ints.

  Note: in OCaml there is an informal type called an `assoc` which is just a list
  of (key,value) pairs and which serves as a simple dictionary.  For example,
  `List.assoc 3 [(3,22);(4,87)];;` returns 22 and 
  `List.remove_assoc 4 [(3,22);(4,87)]` returns `[(3,22)]`. 
  You can just Fb-ize this idea, and you are welcome to use the pair and 
  list encodings defined in the `fb_examples.ml` file to do so.

*)

(* Write a Fb function that takes a single dummy argument as input and returns a 
   new empty dictionary *)
let empty_dict = "(0 1)";;

(* 
  Write an Fb function that takes a dictionary, a key and a value and returns
  a new dictionary with the key mapped to the specified value.
*)
let add_dict = "(0 1)";;

(*  
  Write an Fb function that takes a dictionary and key as input and returns
  the value mapped to the key if any.  Fb does not provide a direct way to 
  report errors, so in case the dictionary does not contain the key, your 
  function should invoke a run-time type error such as our favorite, "(0 1)". 
*)  
let get_dict = "(0 1)";;

(* Write an Fb function that takes a dictionary and a key as input and returns 
   a new dictionary such that the key is no longer mapped. You are allowed to 
   assume that this function is only called with keys known to be present 
   in the dictionary.
*)  
let remove_dict = "(0 1)";;

(* Some informal tests *)
let empty = "("^ empty_dict ^ ") 0";;
let test_dict = 
  "Let da = ("^ add_dict ^")("^ empty ^") 1 11 
   In ("^ add_dict ^") da 2 12";;
let get_test = "("^ get_dict ^")("^ test_dict ^") 1" ;; 
(* assert (peu get_test = "11");; *)
let get_test_nonexistent = "("^ get_dict ^")("^ test_dict ^") 99" ;; 
(* raises exception *)
let removed_dict = "("^ remove_dict ^")("^ test_dict ^") 1";;
let get_test_removed = "("^ get_dict ^")("^ removed_dict ^") 1" ;; 
(* also should exception *)
let get_test_not_removed = "("^ get_dict ^")("^ removed_dict ^") 2" ;; 
(* assert (peu get_test_not_removed = "12");; *)
