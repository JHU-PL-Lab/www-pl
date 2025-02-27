(*

PoPL Assignment 5 part I
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

   Fb fails to provide any operations over integers more complex than addition 
   and subtraction.  Below, define the following 2-argument Fb functions: 
   less-than and multiplication.  
   
   (Hint: if you get stuck, try getting them working for positive numbers first 
    and then dealing with negatives.)  *)

let fb_lt = "(0 1)";;
let fb_mult = "(0 1)";;
   
(*
   assert(peu ("("^fb_lt^") 33 3") = "False");;
      --> 33 < 3 => False
   assert(peu ("("^fb_lt^") (-1) 3") = "True");;
      --> -1 < 3 => True
   assert(peu ("("^fb_mult^") 5 3") = "15");;
      --> 5 * 3 => 15
   assert(peu ("("^fb_mult^") (-3) 5") = "-15");;
      --> (-3) * 5 => (-15)
*)
      
(* Part 2 question 2.

   Fb is a simple language. But even it contains more constructs than strictly 
   necessary.
   For example, you don't even need integers! They can be encoded 
   by functions using what is called Church's encoding.
   (For more information, see http://en.wikipedia.org/wiki/Church_encoding)

   Essentially this encoding allows us to represent integers as 
   functions. 
   
      Here's some examples of the integer representation:

         0 --> Function f -> Function x -> x
         1 --> Function f -> Function x -> f x
         2 --> Function f -> Function x -> f (f x)

   Remember that all your answers should generate Fb programs as 
   strings.     

*)

(* In this first part, you can assume that we are dealing with only 
*non-negative* integers. *)

(* Write a Fb function to convert a church encoded int to an Fb native int.*)
let fb_unchurch = "(0 1)";;
   
(* Write a Fb function to convert an Fb native int to a church encoded int *)
let fb_church = "(0 1)";;
   
(*
let church2 = "Function f -> Function x -> f (f x)";;
assert ( peu ("("^fb_unchurch^")("^church2^")") = "2" );;
assert ( peu ("("^fb_church^" 4) (Function n -> n + n) 3") = "48" );;
*)

(* NOTE: It's important to keep in mind that for the following functions, you
   must implement these functions using CHURCH NUMERALS only--that is, if you 
   simply unchurch the numerals, perform operations on normal integers and 
   convert them back to their church forms, you will NOT receive full points!!
*)

(* Write a function to add two church encoded values *)
let fb_church_add = "(0 1)";;

(* Write a function to multiply two church encoded values *)
let fb_church_mult = "(0 1)";;

(*
let church2 = "(Function f -> Function x -> f (f x))";;
let church3 =  "(Function f -> Function x -> f (f (f x)))" ;;
assert ( peu ("("^fb_unchurch^") (("^fb_church_add^")"^church3^church2^")") = "5" );;
assert ( peu ("("^fb_unchurch^") (("^fb_church_mult^")"^church3^church2^")") = "6" );;
*)