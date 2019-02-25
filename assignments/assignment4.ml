(*

PoPL Assignment 4 part 2
Your Name : 
List of Collaborators :

   For this part, you will write some programs in Fb.  Your answers for
   this section must be in the form of OCaml strings which the parse
   function in debugscript/fb.ml will successfully turn into Fb ASTs.
   If you want a macro for repeated code, you are wecome to use OCaml
   to put strings together.  Here is an example.

 *)

let pair c1 c2  = "((Fun lft -> Fun rgt -> Fun x -> x lft rgt) ("^c1^") ("^c2^"))";;
let left c =  "(("^c^") (Fun x -> Fun y -> x))";;
let right c =  "(("^c^") (Fun x -> Fun y -> y))";;

let project_my_pair = left (pair "34" "45");;

(* 

Here is a test of the above; it assumes you input the debugscript file previously:
# #use "debugscript/fb.ml";; (* launch ocaml from fbdk directory for this to work *)
...
# res project_my_pair 
- : string = "34"

*)

(*
Do realize this is a VERY primitive macro system, you will want to put () around
any definition you make or when appended the parse order could change.

For questions in this section you are not allowed to use the Let Rec syntax even
if you have implemented it in your interpreter. Any recursion that you use must
entirely be in terms of Functions. Feel free to implement an Fb Y-combinator
here.  For examples and hints, see the file "fbdk/debugscript/fb_examples.ml".

Remember to test your code against the standard Fb binaries (and not just your own 
implementation of Fb) to ensure that your functions work correctly.

*)

(* Part 3 question 1. [10 points]

   Fb fails to provide any operations over integers more complex
   than addition and subtraction.  Below, define the following
   2-argument Fb functions: less-than, multiplication, and mod, the
   modulus operator.  (Hint: if you get stuck, try getting them
   working for positive numbers first and then dealing with
   negatives.)  *)

let fbLt = "(0 1)";;
let fbMult = "(0 1)";;
let fbMod = "(0 1)";;
  
(*

#  assert(res ("("^fbLt^") 33 3") = "False");;
#  assert(res ("("^fbLt^") (0-1) 3") = "True");;
#  assert(res ("("^fbMult^") 5 3") = "15");;
#  assert(res ("("^fbMult^") (0-3) 5") = "-15");;
#  assert(res ("("^fbMod^") 33 3") = "0");;
#  assert(res ("("^fbMod^") 87 4") = "3");;

*)

(*  Part 2 question 2.


We can even encode fairly complex data structures in Fb. For
this question we will consider the encoding of a simple functional dictionary /
map. For simplicity we will assume that they keys and values for this data
structure are Ints.
      
The dictionary data structure is defined by the four functions below.
      
Hint: This is simpler than it looks. For the simplest answer, you do not even
require the Y-combinator.

*)

(* Write a Fb function that takes a single dummy argument as input and returns a
new empty dictionary *)
let fbDictEmpty = "(0 1)" ;;

(* Write an Fb function that takes a dictionary, a key and a value and returns a
  new dictionary with the key mapped to the specified value.  *)
let fbDictAdd = "(0 1)" ;;

(* Write an Fb function that takes a dictionary and key as input and returns the
  value mapped to the key if any.  Since there are no exceptions
  in Fb just execute program (0 1) if the key is missing, this will raise an interpreter
  exception which we will declare as "good enough".
*)

let fbDictGet = "(0 1)" ;;

(* Write an Fb function that takes a dictionary and a key as input and returns a
   new dictionary such that the key is no longer mapped. Since there are no exceptions
   in Fb just execute program (0 1) if the key is missing.  *)

let fbDictRemove = "(0 1)" ;;

(*
Here are some test examples.  Recall function res parses, evals, and un-parses.

# let empty = res "("^fbDictEmpty^") 0";;
# let dict_a = res "("^fbDictAdd^")("^empty^") 1 11";;
# let dict_b = res "("^fbDictAdd^")("^dict_a^") 2 22";;
# assert(res ("("^fbDictGet^")("^dict_b^") 2") = "22");;
# res "("^fbDictGet^")("^dict_b^") 10" ;;
Exception: ...
# let dictCreate keyList valList = List.fold_left2 (
    fun r -> fun k -> fun v -> "("^fbDictAdd^")("^r^")("^k^")("^v^")"
  ) empty keyList valList ;;
# let dict_c = rec (dictCreate ["4"; "3"; "2"; "1"; "0"] ["404"; "303"; "202"; "101"; "0"] ) ;;
# assert(res ("("^fbDictGet^")("^dict_c^") 3") = "303") ;;

*)



