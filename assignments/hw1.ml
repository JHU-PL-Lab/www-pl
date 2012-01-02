(*
600.426 - Programming Languages
JHU Spring 2011
Homework 1

In this source file, you will find a number of comments containing the text
"ANSWER".  Each of these comments indicates a portion of the source code you
must fill in yourself.  You are welcome to include other functions for use in
your answers.  Read the instructions for each problem and supply a segment of
code which accomplishes the indicated task.  For your convenience, a number of
test expressions are provided for each problem as well as a description of
their expected values.

Please note that you are NOT permitted to use any OCaml module functions (such
as List.length) to complete this assignment.  You are also not permitted to
make use of mutation (references, arrays, etc.).
*)


(* ****************************** Problem 1 ****************************** *)

(*
Problem 1a. (5 points)

Write a function which accepts a list of integers and returns another list such
that the value of each position in the new list is equal to the sum of all values
up to that position in the old list.
*)

let listsum lst = ();; (* ANSWER *)

(*
# listsum [1;1;1];;
- : int list = [1; 2; 3]
# listsum [1;2;3;4];;
- : int list = [1; 3; 6; 10]
# listsum [2;-1;5;0];;
- : int list = [2; 1; 6; 6]
# listsum [];;
- : int list = []
*)


(*
Problem 1b. (10 points)

One of the most powerful features of OCaml is the "higher-order function": the
ability to treat functions as first-class citizens (just like objects in Java
or pointers in C).  Functions can be passed as arguments and stored in
variables in the same way as other data.

Write a function which generalizes the previous concept by taking an
accumulator function and a starting accumulator value (rather than assuming
addition for accumulation).  For instance, the behavior of the function defined
in Problem 1a could be recreated by writing

	acclist lst 0 (fun x -> fun y -> x + y) 
*)

let acclist lst base f = ();; (* ANSWER *)

(*
# let prod x y = x * y;;
val prod : int -> int -> int = <fun>
# acclist [1;2;3;4] 1 prod;;
- : int list = [1; 2; 6; 24]
# acclist [2;4;6] 1 prod;;
- : int list = [2; 8; 48]
# acclist [true;false;true] true (&&);;
- : bool list = [true; false; false]
*)


(*
Problem 1c. (10 points)

Write a function which removes from a given list all duplicates it contains.
The first element is left in place while all remaining identical elements are
discarded.
*)

let listuniq lst = ();; (* ANSWER *)

(*
# listuniq [1;2;3;1;2;3];;
- : int list = [1; 2; 3]
# listuniq [1;2;1;3;1;4;1;5];;
- : int list = [1; 2; 3; 4; 5]
# listuniq [2;3;1;2;1;4;6;2;3;4];;
- : int list = [2; 3; 1; 4; 6]
# listuniq [];;
- : 'a list = []
*)


(* ****************************** Problem 2 ****************************** *)

(*
Problem 2a. (5 points)

OCaml provides a keyword "type" which allows you to define your own variant
data types.  For instance, the Java language allows any reference type to
contain the value null, effectively meaning "no reference here".  OCaml does
not allow this implicitly, but that behavior can be recovered with the
following data type:
*)

type 'a nullable = Null | NotNull of 'a;;

(*
Write a function which accepts a list as input and returns the number of null
elements in that list.
*)

let nullcount lst = ();; (* ANSWER *)

(*
# nullcount [];;
- : int = 0
# nullcount [NotNull(5);NotNull(3);NotNull(1)];;
- : int = 0
# nullcount [Null;NotNull(2);Null];;
- : int = 2
# nullcount [Null;NotNull([1;2;3])];;
- : int = 1
*)


(*
Problem 2b. (5 points)

Write a function which takes a list of nullable values and gives back a list of
non-nullable values; values in the original list which were null are skipped.
*)

let nullfilter lst = ();; (* ANSWER *)

(*
# nullfilter [];;
- : 'a list = []
# nullfilter [NotNull(5);NotNull(3);NotNull(1)];;
- : int list = [5; 3; 1]
# nullfilter [Null;NotNull(2);Null];;
- : int list = [2]
# nullfilter [Null;NotNull([1;2;3])];;
- : int list list = [[1; 2; 3]]
*)


(*
Problem 2c. (10 points)

Write a function which merges two sorted lists in order.  Assume that your
input lists are already sorted; the output list should likewise be sorted.
Your function must take a comparison function as an input which is responsible
for determining the order of elements in the list; that function must return
one of the values defined in the "comparison" data type.  (Note that a
variant whose constructors take no arguments is effectively just like an
enumeration in other languages, such as Java.)  That is, "cmp a b" returns
LessThan if a < b.
*)

type comparison = LessThan | EqualTo | GreaterThan;;
let merge lst1 lst2 cmp = ();; (* ANSWER *)

(*
# let intcmp x y =
	if x < y then LessThan else
		if x > y then GreaterThan else EqualTo;;
    val intcmp : 'a -> 'a -> comparison = <fun>
# let rintcmp x y = intcmp y x;;
val rintcmp : 'a -> 'a -> comparison = <fun>
# merge [1;3] [2;4] intcmp;;
- : int list = [1; 2; 3; 4]
# merge [1;6;7] [2;3;3;5;6] intcmp;;
- : int list = [1; 2; 3; 3; 5; 6; 6; 7]
# merge [] [2;3] intcmp;;
- : int list = [2; 3]
# merge [5;4;0] [3;1;-1] rintcmp;;
- : int list = [5; 4; 3; 1; 0; -1]
*)


(*
Problem 2d. (10 points)

Write a function which will split an input list in half.  The result should be
a tuple of two lists; half of the elements should be in the first list and half
should be in the second list.  It does not matter which elements go to which
list as long as each list is about the same size.  (For an input of a list of
odd length, you are permitted to have one list be one element larger than the
other list.)
*)

let splitlist lst = ();; (* ANSWER *)

(*
# splitlist [1;2;3;4;5;6];;
- : int list * int list = ([1; 3; 5], [2; 4; 6])
# splitlist [1;2;7;8;9];;
- : int list * int list = ([1; 7; 9], [2; 8])
# splitlist [true;true;false;true];;
- : bool list * bool list = ([true; false], [true; true])
# splitlist [];;
- : 'a list * 'a list = ([], [])
*)


(*
Problem 2e. (10 points)

Using the merge and splitlist functions you defined in the previous two
problems, write a function which performs a merge sort.
*)

let mergesort lst cmp = ();; (* ANSWER *)

(*
# mergesort [4;1;3;2;9;4;5] intcmp;;
- : int list = [1; 2; 3; 4; 4; 5; 9]
# mergesort [2;6;4;9;5;2;0] intcmp;;
- : int list = [0; 2; 2; 4; 5; 6; 9]
# mergesort [5] intcmp;;
- : int list = [5]
# mergesort [] intcmp;;
- : 'a list = []
*)


(* ****************************** Problem 3 ****************************** *)

(*
Problem 3a. (5 points)

Consider the following polymorphic definition of a binary tree:
*)

type 'a node = Empty | Node of 'a * 'a node * 'a node;;

(*
Here, we are using the Empty constructor to represent a child node which does
not exist.  For instance, the tree

     0
    / \
   3   5

might be created using the expression

	Node(
		0,
		Node(3, Empty, Empty),
		Node(5, Empty, Empty))

Create an expression for the following tree using the above node type:

     4
    / \
   2   5
  / \   \
 1   0   2
    /
   3
*)

let mytree = ();; (* ANSWER *)


(*
Problem 3b. (5 points)

Write a function which will accept an int node and will sum all of the values
in the nodes in that tree.  Empty nodes should be counted as zeroes.
*)

let sumtree tree = ();; (* ANSWER *)

(*
# sumtree (Empty);;
- : int = 0
# sumtree (Node(
		2,
		Empty,
		Node(
			3,
			Node(4,Empty,Empty),
			Node(0,Empty,Empty))));;
            - : int = 9
# sumtree mytree;;
- : int = 17
*)


(*
Problem 3c. (10 points)

Now write a function which takes a tree, a base value, and an accumulator
function.  Your new function should perform an in-order traversal of the tree
(left subtree, node value, right subtree).  At each step in the traversal, it
should apply the accumulator function to the current accumulator value (which
is initially equal to the base value) and the value at the current node, using
the result as the new accumulator value.  That is,

	walktree mytree 0 max

should produce the maximum value for mytree (or 0 if the maximum value is
negative).  On the other hand, using a base value of 0 and an accumulator of
(fun x -> fun y -> x + y) should give you the same behavior as the sumtree
function in Problem 3b.
*)

let walktree tree base accf = ();; (* ANSWER *)

(*
# walktree mytree 0 max;;
- : int = 5
# walktree mytree 0 (fun x -> fun y -> x + y);;
- : int = 17
# walktree Empty 700 (fun x -> fun y -> 0);;
- : int = 700
# walktree mytree 0 (fun x -> fun y -> x - y);;
- : int = -17
*)


(*
Problem 3d. (5 points)

Next, write a function which will compute the average of all nodes in a tree
containing integer values.  The average should be returned as a floating point
value and should not round the average.  This function *must* make use of the
walktree function above.
*)

let treeavg tree = ();; (* ANSWER *)

(*
# treeavg (Node(5,Empty,Empty));;
- : float = 5.
# treeavg mytree;;
- : float = 2.42857142857142838
# treeavg Empty;;
- : float = nan
*)


(*
Problem 3e. (10 points)

Write a function which will find the minimal value in any tree.  You *must* use
the walktree function above.  The trick here is that this minimal operation
must work for *any* tree with *any* notion of comparison.  Your function should
take a tree and a comparison function as an argument and return some value
indicating the minimum value according to that comparison function.  As a
result, you will not be able to use a "magic" minimum value (such as 0 in the
example in Problem 3c).  Hint: you may use any supporting declarations you like.
*)

let treemin tree cmp = ();; (* ANSWER *)
