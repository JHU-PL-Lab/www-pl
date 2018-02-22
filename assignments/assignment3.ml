(*

PoPL Assignment 3 part 3 
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
# rep project_my_pair 
==> 34
- : unit = ()


Do realize this is a very primitive macro system, you will want to put () around
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
   2-argument Fb functions: less-than, multiplication, and max, the
   largest of two integers.  (Hint: if you get stuck, try getting them
   working for positive numbers first and then dealing with
   negatives.)  *)

let fbLt = "(0 1)";;
let fbMult = "(0 1)";;
let fbMax = "(0 1)";;
  
(*
#  rep ("("^fbLt^") 33 3");;
==> False
- : unit = ()
#  rep ("("^fbLt^") 0 3");;
==> True
- : unit = ()
#  rep ("("^fbLt^") 3 3");;
==> False
- : unit = ()
#  rep ("("^fbMult^") 3 5");;
==> 15
- : unit = ()
#  rep ("("^fbMult^") 0 2");;
==> 0
- : unit = ()
# rep ("("^fbMult^") (0-3) 5");;
==> -15
- : unit = ()
# rep ("("^fbMult^") 12 7");;
==> 84
- : unit = ()
#  rep ("("^fbMax^") 12 4");;
==> 12
- : unit = ()
#  rep ("("^fbMax^") 7 3");;
==> 7
- : unit = ()
*)

(*  Part 3 question 2. [10 points]

    In spite of its simplicity, Fb can encode complex data structures. The book
    has several examples of this, lists in particular. (It is a good idea to 
    review the list encoding before attempting this question) 
  
    In this question we will encode (and decode) a simple binary tree in Fb and 
    use it for some calculations.
	
    Each tree node consists of 3 parts - a value, a left subtree and a right
    subtree. Or, a tree node can be empty.  In other words, in OCaml it would 
    be similar to the tree type we covered in lecture: 

    type 'a btree = Leaf | Node of 'a * 'a btree * 'a btree;;

*)

(* Pick something to represent an empty tree *)

let fbMttree = "(0 1)";;

(* Make a function here which takes a value, a left tree, and a right tree, and makes the binary tree. *)

let fbMakeNode = "(0 1)";;

(* It is important to have a function to test whether a tree is empty - it should return True if it is empty and False otherwise.  Your empty tree and node maker need to be designed with this in mind! *)

let fbIsempty = "(0 1)";;

(* Lets make a simple tree for testing.
# let node1 = "("^fbMakeNode^") 4 ("^fbMttree^") ("^fbMttree^")";;
# let node2 = "("^fbMakeNode^") 1 ("^fbMttree^") ("^fbMttree^")";;
# let node3 = "("^fbMakeNode^") 3 ("^node1^") ("^node2^")";;

# rep ("("^fbIsempty^") ("^fbMttree^")");;
==> True
- : unit = ()
# rep ("("^fbIsempty^") ("^node3^")");;
==> False
- : unit = ()

*)

(* Now we need accessors to get left and right subtrees; they should only be called on non-empty trees, feel free to do bizarre things if passed an empty tree. *)

let fbGetleft = "(0 1)";;
let fbGetright = "(0 1)";;

(*
# rep ("("^fbGetleft^") ("^node2^")");;
==> (your chosen empty tree value)
- : unit = ()
# rep ("("^fbGetright^") ("^node3^")");;
==> (your representation of the node2 tree above)
- : unit = ()
*)

(*
   Given your tree encoding, write an Fb program to recursively sum up the values 
   in the nodes of a binary tree.
*)

let fbTreesum = "(0 1)";;

(* 

# rep ("("^fbTreesum^") ("^node3^")");;
==> 8
- : unit = ()
*)


