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
   2-argument Fb functions: greater-than-or-equal-to, multiplication, 
   and integer division.  
   (Hint: if you get stuck, try getting them
   working for positive numbers first and then dealing with
   negatives.)  *)

let fb_geq = "(0 1)";;
let fb_mult = "(0 1)";;
let fb_div = "(0 1)";;
   
(*
   assert(peu ("("^fb_geq^") 33 3") = "True");;
      --> 33 >= 3 => True
   assert(peu ("("^fb_geq^") (-1) 3") = "False");;
      --> -1 >= 3 => False
   assert(peu ("("^fb_mult^") 5 3") = "15");;
      --> 5 * 3 => 15
   assert(peu ("("^fb_mult^") (-3) 5") = "-15");;
      --> (-3) * 5 => (-15)
   assert(peu ("("^fb_div^") 33 3") = "11");;
      --> 33 / 3 => 11
   assert(peu ("("^fb_div^") 87 4") = "21");;
      --> 87 / 4 => 21
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

(* So far our encoding only deals with positive integers. However, we can 
   introduce negative integers to the system by making our encodings just a bit
   more complex.
   
   In order to achieve this, we need to first define pairs in this system.
   The pair is represented as a higher-order function that takes a function 
   argument that represents "operation to be performed on the componenets".
   And when given an argument, it will apply the function to pair's components.
   This is how we encoded pairs in lecture,
   
   For simplicity's sake, we've provided the definition for the pair constructor
   for you.

*)

let fb_church_pair = "Function x -> Function y -> Function f -> f x y"

(* Write a function to get the first component of the pair *)
let fb_church_fst = "(0 1)";;

(* Write a function to get the second component of the pair *)
let fb_church_snd = "(0 1)";;

(*
let church2 = "(Function f -> Function x -> f (f x))";;
let church3 =  "(Function f -> Function x -> f (f (f x)))" ;;
assert ( peu ("("^fb_unchurch^") ("^"("^fb_church_fst^") ("^"("^fb_church_pair^")"^church3^church2^")"^")") = "3" );;
*)

(* Now, we can redefine signed integers as a pair of integers, where the actual
   value is the difference between the two integers in the pair. *)

let fb_church_signed = "(0 1)"

let fb_unchurch_signed = "(0 1)"

(*
assert ( peu @@ "("^fb_unchurch_signed^") (("^fb_church_signed^") 1)" = "1" );;
assert ( peu @@ "("^fb_unchurch_signed^") (("^fb_church_signed^") (-3))" = "-3" );;
*)

(* Redefine the plus function using this new representation *)

let fb_church_add_signed = "(0 1)"

(*
let church2 = "((" ^ fb_church_signed ^ ") 2)";;
let churchn3 = "((" ^ fb_church_signed ^ ") (-3))";;
assert (peu @@ "("^ fb_unchurch_signed ^")" ^ "((" ^ fb_church_add_signed ^ ") " ^ church2 ^ churchn3 ^")" = "-1" );;
*)
