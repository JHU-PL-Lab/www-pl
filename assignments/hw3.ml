(*
	600.426 - Programming Languages
	JHU Spring 2012
	Homework 3 Part 2 (35 points)
	
	Now that you have completed your Fb interpreter, you will need to write some
	programs in Fb.  (If you have not completed the interpreter but wish to complete
	this portion of the homework, you may use the binary distribution provided on
	the course website.)  
*)

(* -------------------------------------------------------------------------------------------------- *)
(* HEADER: PLEASE FILL THIS IN                                                                        *)
(* -------------------------------------------------------------------------------------------------- *)

(*

Name                  :
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems with here, as per the
course academic integrity policy. TA/CA/Prof need not be listed.
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 1 : Operational Semantics and Proofs                                                       *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  1a. The Freeze and Thaw operations are defined as macros in the book. But it is equally
      feasible to augment Fb with new operations "Freeze e" and "Thaw e" with a similar behavior.
      Assuming we add these 2 operations to Fb, write out the direct operational semantics for both.

      [4 Points]
*)

(* ANSWER for Freeze e *)

(* ANSWER for Thaw e *)


(*
  1b. Consider a 3-way switch operation - Threeway e e1 e2 e3. If e evaluates to a -1 then
      e1 gets evaluated. If e evaluates to 0 then e2 is evaluated and if e evaluates +1,
      e3 is evaluated.

      (Note that this  is similar to the If-Then-Else operation. For example if e evaluates
      to -1, *only* e1 is evaluated, not e2 or e3)

      Assuming that we add this new operation to Fb, write out its operational semantics.

      [2 Points]
*)

(* ANSWER *)

(*
  1c. Let us augment Fb with a new construct Let x = e in e' similar to the one in OCaml.

      Write out the operational semantics for this new construct.

      [2 Points]
*)

(* ANSWER *)

(*
  1d.For the expression: "3 + (If 3 = (2+1) Then 1 - 2 Else 2)", show a proof tree that uses
     the operational semantics rules to demonstrate how it is evaluated. Your proof should
     follow the Fb operational semantics rules correctly and should not skip any steps.

      [5 Points]
*)

(* ANSWER *)

(*
  1e. Similar to the question above, use the operational semantics you defined in 1c along
      with the standard rules for Fb to prove that the expression:
      "Let f = (Function x -> x + 1) In (Let g = (Function y -> y - 1) In g (f 1))"
      evaluates to 1. Don't skip any steps.

      [7 Points]
*)

(* ANSWER *)


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
  2a. Write an Fb function to compute the absolute value of an integer.
  
      Hint: If Fb supported a < operator, this would be trivial. But you can
      make one if you want it. (The language won't be Turing-complete otherwise)
      Remember that a) You can call upon your powers of recursion ;) b) Nobody
      said anything about efficiency. 
      
      [5 Points]
*)

let fbabs = parse "" ;; (* ANSWER *)

(*
# ppeval (Appl(fbabs, Int 3)) ;;
==> 3
- : unit = ()
# ppeval (Appl(fbabs, Minus(Int 0, Int 3))) ;;
==> 3
- : unit = ()
# ppeval (Appl(fbabs, Int 0)) ;;
==> 0
- : unit = ()
*)


(*
  2b. In spite of its simplicity, Fb can encode complex data structures. The book
      has several examples of this. (And it is a good idea to review them before
      attempting this assignment) 
  
      In this question we will encode (and decode) a simple binary tree in Fb and 
      use it for some calculations.
	
      You should supply the code to make the following encoding "work" and return 33.
      The encoding used here assumes that a tree node consists of 3 parts - a value, a left
      subtree and a right subtree. If a subtree is empty, we use the value 0 to indicate that.
      The full encoding/decoding system consists of 4 functions -
        * A function to encode the tree as described above (and seen below)
        * A function to get the value stored at a tree node
        * Functions to get the left and right subtrees  

      You have to supply the code for these 4 functions.
      
      [4 Points]
*)

let fbtree = parse "
(Function encode_tree -> Function get_data -> Function get_lchild -> Function get_rchild ->
  ( Function encoded_tree -> 
      get_data encoded_tree - 
      (get_data (get_lchild encoded_tree)) + 
      (get_data (get_rchild encoded_tree)) + 
      (get_data (get_lchild (get_rchild encoded_tree))) +  
      (get_data (get_rchild (get_rchild encoded_tree)))
  ) 
 (encode_tree 10 
    (encode_tree 5 0 0)
    (encode_tree 2 
      (encode_tree 1 0 0) 
      (encode_tree 25 0 0) 
    ) 
  ) 
)
(* ANSWER PART 1 - Supply the Fb function to encode a tree *)
(* ANSWER PART 2 - Supply the Fb function to get the data from a tree *)
(* ANSWER PART 3 - Supply the Fb function to get the left child from a tree *)
(* ANSWER PART 4 - Supply the Fb function to get the right child from a tree *)
"
;;

ppeval fbtree  ;;
(*
#   ==> 33
- : unit = ()
*)


(*
  2c. Create a version of the above example to recursively sum up all nodes
      of a binary tree. The sum function must be general and applicable to other trees
      encoded in a similar form. To make it more "interesting", write the recursive
      function *without* the use of Let Rec.
      
      You *are* allowed to tweak the encoding and corresponding functions to make this work. 
      Make as minimal changes to the encoding as you can.
      
      [6 Points]
*)

let fbtree_modified = parse "
(Function encode_tree -> Function get_data -> Function get_lchild -> Function get_rchild -> 
  (
    Let Rec sum encoded_tree = (* ANSWER PART - Supply a Fb function to recursively sum up values of all nodes in the tree *)
  )
  (encode_tree 10 True True
    (encode_tree 5 False False 0 0)
    (encode_tree 2 True True 
      (encode_tree 1 False False 0 0) 
      (encode_tree 25 False False 0 0) 
    ) 
   ) 
)
(* ANSWER PART - Supply the Fb function to encode a tree *)
(* ANSWER PART - Supply the Fb function to get the data from a tree *)
(* ANSWER PART - Supply the Fb function to get the left child from a tree *)
(* ANSWER PART - Supply the Fb function to get the right child from a tree *)
"
;;

ppeval fbtree_modified ;;
(*
==> 43
- : unit = ()
*)

