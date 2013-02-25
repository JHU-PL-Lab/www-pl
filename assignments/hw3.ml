(*
    600.426 - Programming Languages
    JHU Spring 2013
    Homework 3 Part 2 (35 points)

    Now that you have completed your Fb interpreter, you will need to write some
    programs in Fb.

    Note: We will be testing your Fb code with the canonical interpreter (binary) that was
    provided to you. So it is worth your while to test your code against that prior to submitting
    it.
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
(* Section 1 : Operational Semantics and Proofs                                                       *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  1a. The sequence operation (;) is defined as a macro in the book. But it is also possible to augment Fb
      with a new grammar construction 'e;e' with a similar behavior. Write out the operational semantics for
      this new operation.

      [4 Points]
*)

(* ANSWER *)

(*
  1b. In languages like C or Java, binary boolean operators are 'short circuiting' - i.e. For an expression
      like "file != null && file.length() > 0", the second expression is evaluated only if the first expression
      is true. Similarly for '||' operations, the second expression is evaluated only if the first expression
      evaluates to false.

      As Prof Scott mentioned in class, this is not true in the default Fb operational semantics.

      Modify the operational semantics of Fb such that 'And' and 'Or' operators perform short-circuiting.

      [6 Points]
*)

(* ANSWER *)

(*
  1c. For the expression: "(If (1+2) = 0 Then 0 Else (2+3)) + 5", show a proof tree that uses
      the operational semantics rules to demonstrate how it is evaluated. Your proof should
      follow the Fb operational semantics rules correctly and should not skip any steps.

      [5 Points]
*)

(* ANSWER *)

(*
  1d. Consider the expression: (Function f -> Function x -> f x) (Function z -> z + 1) 2. Show a proof
      tree that uses the operational semantics rules to demonstrate its evaluation. As before your proof
      should follow the Fb operational semantics rules correctly and not skip any steps.

      [5 Points]
*)


(* -------------------------------------------------------------------------------------------------- *)
(* Section 2 : (En)Coding in Fb                                                                      *)
(* -------------------------------------------------------------------------------------------------- *)

(*
    The answers for this section must be in the form of Fb ASTs. You may assume that
    "fbdktoploop.ml" has been loaded before this code is executed; thus, you may use
    the parse function to create your answer if you like. Alternately you can create
    ASTs directly.

    For instance, the two definitions of the identity function in Fb are equivalent. (See below)
    The second one directly declares the datastructure produced by the first expression.

    You may use whichever form you please; the parse form is somewhat more readable, but
    the AST form allows you to create and reuse subtrees by declaring OCaml variables.
*)

let fb_identity_parsed = parse "Function x -> x";;

let fb_identity_ast = Function(Ident("x"), Var(Ident("x")));;


(*
  2a. Fb is such a minimalisitc language that it does not even include a < operation.
      But it is possible to create one of your own.

      Hint: a) You can call upon your powers of recursion ;) b) We dont really care
      about efficiency.

      NOTE: For this question you are not allowed to use the Let Rec syntax even if you
      have implemented it in your interpreter. Any recursion that you use must entirely
      be in terms of Functions. Feel free to implement an Fb Y-combinator here.  For
      examples and hints, see the file "src/Fb/fbexamples.ml" in the FbDK project.

      [5 Points]
*)

let fblt = parse "" ;; (* ANSWER *)

(*
# ppeval (Appl(Appl(fble, Plus(Int 1, Int 1)), Int 3)) ;;
==> True
- : unit = ()
# ppeval (Appl(Appl(fble, Minus(Int 0, Int 1)), Minus(Int 0, Int 3))) ;;
==> False
- : unit = ()
*)


(*

  2b. Fb is a simple language. But even it contains more constructs than strictly necessary
      For example, you dont really need integer values at all! They can be encoded using just
      functions using what is called Church's encoding http://en.wikipedia.org/wiki/Church_encoding

      Essentially this encoding allows us to represent integers as functions. For example:

        0 --> Function f -> Function x -> x
        1 --> Function f -> Function x -> f x
        2 --> Function f -> Function x -> f (f x)

      We will write 4 functions that work with church numerals in this section. Remember that all
      your answers should generate Fb ASTs.

      You can assume that we are dealing with only non-negative integers in this question.

      [10 Points]
*)


(* Write a Fb function to convert a church encoded value to an Fb native integer.*)
let fbUnchurch = parse "" ;; (* ANSWER *)

(* Write a Fb function to convert an Fb native integer to a church encoded value *)
let fbChurch = parse "" ;; (* ANSWER *)

(*
# let church2 = parse "Function f -> Function x -> f (f x)";;
val church2 : Fbast.expr =
  Function (Ident "f",
   Function (Ident "x",
    Appl (Var (Ident "f"), Appl (Var (Ident "f"), Var (Ident "x")))))
# ppeval (Appl(fbUnchurch,church2));;
==> 2
- : unit = ()
# ppeval (Appl(fbUnchurch,Appl(fbChurch,Int(12))));;
==> 12
- : unit = ()
# ppeval (Appl(Appl(Appl(fbChurch,Int(4)),(parse "Function n -> n + n")),Int(3)));;
==> 48
- : unit = ()
*)

(* Write a function to add two church encoded values *)
let fbChurchAdd = parse "" ;; (* ANSWER *)

(* Write a function to multiply two church encoded values *)
let fbChurchAdd = parse "" ;; (* ANSWER *)

(*
# let church2 = parse "Function f -> Function x -> f (f x)" ;;
# let church3 = parse "Function f -> Function x -> f (f (f x))" ;;
# ppeval (Appl(fbUnchurch, (Appl(Appl(fbChurchAdd, church3), church2))));;
==> 5
- : unit = ()
# ppeval (Appl(fbUnchurch, (Appl(Appl(fbChurchMult, church3), church2))));;
==> 6
- : unit = ()
*)
