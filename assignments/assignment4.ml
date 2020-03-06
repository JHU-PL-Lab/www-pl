(*

PoPL Assignment 4 part 2
Your Name : 
List of Collaborators :

   For this part, you will write some programs in Fb.  Your answers for
   this section must be in the form of OCaml strings which the parse
   function in debugscript/fb.ml will successfully turn into Fb ASTs.
   If you want a macro for repeated code, you are welcome to use OCaml
   to put strings together.  Here is an example from debugscript/fb_examples.ml:

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

(* Part 2 question 1.

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

assert(res ("("^fbLt^") 33 3") = "False");;
assert(res ("("^fbLt^") (0-1) 3") = "True");;
assert(res ("("^fbMult^") 5 3") = "15");;
assert(res ("("^fbMult^") (0-3) 5") = "-15");;
assert(res ("("^fbMod^") 33 3") = "0");;
assert(res ("("^fbMod^") 87 4") = "3");;

*)

(*  Part 2 question 2.


*)


(*

   Fb is a simple language. But even it contains more constructs than strictly necessary.
   For example, you don't even need integers! They can be encoded using just
   functions using what is called Church's encoding http://en.wikipedia.org/wiki/Church_encoding

   Essentially this encoding allows us to represent integers as functions. For example:

        0 --> Function f -> Function x -> x
        1 --> Function f -> Function x -> f x
        2 --> Function f -> Function x -> f (f x)

   We will write 4 functions that work with church numerals in this section. Remember that all
   your answers should generate Fb ASTs.

   You can assume that we are dealing with only non-negative integers in this question.

*)


(* Write a Fb function to convert a church encoded value to an Fb native integer.*)
let fbUnchurch = "(0 1)";;

(* Write a Fb function to convert an Fb native integer to a church encoded value *)
let fbChurch = "(0 1)";;

(*
let church2 = "Function f -> Function x -> f (f x)";;
assert ( res ("("^fbUnchurch^")("^church2^")") = "2" );;
assert ( res ("("^fbChurch^" 4) (Function n -> n + n) 3") = "48" );;
*)

(* Write a function to add two church encoded values *)
let fbChurchAdd = "(0 1)";;

(* Write a function to multiply two church encoded values *)
let fbChurchMult = "(0 1)";;

(*
let church2 = "(Function f -> Function x -> f (f x))";;
let church3 =  "(Function f -> Function x -> f (f (f x)))" ;;
assert ( res (fbUnchurch^"("^fbChurchAdd^church3^church2^")") = "5" );;
assert ( res (fbUnchurch^"("^fbChurchMult^church3^church2^")") = "6" );;
*)
