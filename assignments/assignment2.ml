(*

PoPL Assignment 2

Name                  :
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems
with here, as per the course academic integrity policy. CA/Prof need not be
listed.

Fill in the function definitions below replacing the

  failwith "Not Implemented";; 

with your code. In some cases, you may find it helpful to define auxillary
functions, feel free to. Other than replacing the failwiths and adding rec's,
don't edit or remove anything else in the file -- the autograder will not be
happy! You cannot use any mutation (arrays, :=, or any mutable data structure)
on this homework unless explicitly allowed. You can use core library functions
such as List.map that are not mutating. Note that the Queue, Stack, and Hashtbl
modules are mutating so you are not allowed to use them. *)

(* Problem 1 *****************************************************************)
(*
Reverse engineer the following types. Fill in the functions below so that the
output types match. You can write any function, as long as its type is the
same as the one specified in the comment. Feel free to add "rec" as always.
*)
let f1 = failwith "Not Implemented" ;;
(* val f1 : 'a -> 'b -> 'c -> 'd -> unit = <fun> *)

let f2 = failwith "Not Implemented" ;;
(* val f2 : 'a list -> 'a = <fun> *)

let f3 = failwith "Not Implemented" ;;
(* val f3 : 'a list -> 'b = <fun> *)

let f4 = failwith "Not Implemented" ;;
(* val f4 : string -> 'a = <fun> *)

let f5 = failwith "Not Implemented" ;;
(* val f5 : 'a -> 'b -> ('a * 'b) list = <fun> *)

type 'a boogie = YouMustFillInATypeHere
type 'a woogie = FillInToo

let f6 = failwith "Not Implemented" ;;
(* val f6: 'a boogie -> 'b woogie -> 'b woogie = <fun> *)

type 'a frec = FillInThree

let f7 = failwith "Not Implemented";;
(* val f7 : ('a -> 'b) -> 'a -> 'b frec = <fun> *)

let f8 = failwith "Not Implemented";;
(* val f8 : ('a -> 'b -> int -> 'c) -> 'a -> ('a -> 'b) -> 'c = <fun> *)


(* Problem 2 *****************************************************************)
(* 
In this problems, you are more or less working with SIS. You will be working
with courses, course rosters, and waitlists. Each course is stored as a record
with the following type signature: 
*)

type course_code = (* e.g EN 601.426 is EN(601,426) *)
 | EN of int * int 
 | AS of int * int 

type course_record = { course_num : course_code; limit : int; signups : string list }

(*
Here is a description of each record field:

course_num: a course number, an element of type course_code

limit: An integer denoting the enrollment limit, ie. the max amount of people
who can enroll in the course.

signups: A list of student names. The first n students in the list (where n is
the enrollment limit) are counted as being enrolled in the course. Everyone
else in the list are counted as being on the course's waitlist.

Here's an example of a course entry

{ course_num = EN(601,426); limit = 2; signups = ["Kelvin Qian"; "Devin Hill"; "John Doe"] }

Here, Kelvin and Devin are enrolled in this course, while John is (alas) on the
waitlist since there's only two spots.

These records can then stored in a list to form a list of courses.
*)

(*
2a. Complete the functions return_enrollment and return_waitlist.

Given the course list and a course number, return_enrollment should return a
list of students enrolled in the course. Given the same arguments, the
return_waitlist function should return that course's waitlist.

For both functions, if a course cannot be found, raise a Not_found exception
(it is built into OCaml, no need to define).
*)

let return_enrollment class_list course_num = failwith "Not Implemented";;

let return_waitlist class_list course_num = failwith "Not Implemented";;

(* Tests:

let l1 = [{ course_num = EN(601,426); limit = 3; signups = ["Kelvin Qian"; "Devin Hill"; "Fionn Connolly"] }];;
let l2 = [{ course_num = EN(601,626); limit = 2; signups = ["Yunmo Chen"; "Chang Liu"; "Shiwei Weng"; "Leandro Facchinetti"] }];;
let lst = l1 @ l2;;

assert( return_enrollment lst (EN(601,426)) = ["Kelvin Qian"; "Devin Hill"; "Fionn Connolly"] );;
assert( return_waitlist lst (EN(601,426)) = [] );;

assert( return_enrollment lst (EN(601,626)) = ["Yunmo Chen"; "Chang Liu"] );;
assert( return_waitlist lst (EN(601,626)) = ["Shiwei Weng"; "Leandro Facchinetti"] );;

assert( try (return_enrollment lst (AS(000,101))) with Not_found -> true );;
assert( try (return_waitlist lst (AS(000,101))) with Not_found -> true );;
*)

(*
2b. Write a function check_enrollment that, given a course list, a course number,
and a student, returns the student's status with regards to that course.
Use the following type for the status:
*)

type status = 
    | Enrolled 
    | Waitlist of int * int 
    | NotRegistered 
    | CourseNotFound

(*
If the student is enrolled in the course, check_enrollment should return
        Enrolled

If the student is #X of Y total students the waitlist, check_enrollment should return
        Waitlist(X,Y)

where X is the student's position on the waitlist and Y is the waitlist length.

If the student is neither enrolled nor on the waitlist, check_enrollment should return 
        NotRegistered

If a course cannot be found, check_enrollment should return
        CourseNotFound
*)

let check_enrollment class_list course_num student = failwith "Not Implemented";;

(* Tests:

let l1 = [{ course_num = EN(601,426); limit = 3; signups = ["Kelvin Qian"; "Devin Hill"; "Fionn Connolly"] }];;
let l2 = [{ course_num = EN(601,626); limit = 2; signups = ["Yunmo Chen"; "Chang Liu"; "Shiwei Weng"; "Leandro Facchinetti"] }];;
let lst = l1 @ l2;;

assert( check_enrollment lst (EN(601,426)) "Fionn Connolly" = Enrolled );;
assert( check_enrollment lst (EN(601,626)) "Chang Liu" = Enrolled );;
assert( check_enrollment lst (EN(601,626)) "Shiwei Weng" = Waitlist(1,2) );;

assert( check_enrollment lst (EN(601,426)) "Yunmo Chen" = NotRegistered );;
assert( check_enrollment lst (AS(000,101)) "Kelvin Qian" = CourseNotFound );;
*)

(* Problem 3 *****************************************************************)
(*
In class, we have seen the Fibonacci function as an example of a recursive
function. See the implementation as the function fib in the lecture notes.

We want to count the number of times fib is called. For example, for fib 0 or
fib 1, fib is called exactly once, but for fib 2 it is called three times
(the original call, then the calls fib (2 - 1) and fib (2 - 2)).
*)

(*
3a. Use a ref variable to implement a counter that counts the number of times
the function count_fib_mut is called. count_fib_mut should return the same
result as fib (ie. fib 2 = count_fib_mut 2 = 2), but should mutate the counter
so that it counts the correct number of function counts.
*)

let counter = ref 0;;
let rec count_fib_mut n = failwith "Not_implemented";;

(* Test:
let res = count_fib_mut 2;;
assert( res = 2 );;
assert( !counter = 3 );;
*)

(*
3b. Implement the function count_fib_immut that does the same thing as the
function count_fib_mut, but does not use mutability. (We will check this!)
count_fib_immut takes in an extra variable count, which will keep track of
the current count of function calls, and will return a int * int tuple, where
the first int is the Fibonacci sum (ie. the return value of fib) and the second
is the count of function calls.
*)

let rec count_fib_immut n count = failwith "Not_implemented";;

(* Test:
let res_tup = count_fib_immut 2 0;;
assert( res_tup = (2,3) );;
*)

(* Problem 4 *****************************************************************)

(*
In this problem we ultimately want to write a simple arithmetic calculator.
For this question will not supply tests for you; be sure to test your code well.
*)

(*
Here is a data type which can be used to describe arithmetic expressions such
as "2 + 3" or "4 * 2 * 7" or even "2 * (8 - 3 * 9)". Division is excluded so we
can work just with integers.

Note that the data type below is a tree, something like the binary tree data
type we used during lecture.
*)

type expr =
  | Integer of int
  | Negate of expr
  | Plus of expr * expr
  | Minus of expr * expr
  | Times of expr * expr
;;

(*
Here are some example expressions to show how arithmetic expressions look
*)

(*
This variable contains the arithmetic expression "9". This is just about as
simple as an arithmetic expression can get!
*)

let nine = Integer(9);;

(*
This variable contains the arithmetic expression "3 + 3". Observe how the
plus comes first and the numbers are its children; this indicates that we
want to add the two children together.
*)

let three_plus_three = Plus(Integer(3), Integer(3));;

(*
This variable contains the arithmetic expression "-3 + (2 * 6)". The
parentheses aren't necessary in this text due to the way mathematical notation
works, but we have to pick a shape for our tree and the parentheses help to
emphasize that. This expression says that we want to add the expression "-3" to
the expression "2 * 6", so that's what we'll build.
*)

let negated_three_plus_two_times_six = Plus(Negate(Integer(3)), Times(Integer(2), Integer(6)));;

(*
This variable contains a more complex arithmetic expression: "(4 * (2 + 8)) - 3". 
Again, the outermost partentheses aren't necessary in mathematical convention
but the innermost parentheses are. We don't need parentheses in our tree
because the grouping that parentheses describe is handled instead by the
parent-child relationship between nodes.
*)

let four_times_quantity_two_plus_eight_close_quantity_minus_three =
  Minus(
    Times(
      Integer(4),
      Plus(
        Integer(2),
        Integer(8))),
    Integer(3))
;;

(*
This variable contains the arithmetic expression "((4 * 2) + 8) - 3", which
is equivalent to "4 * 2 + 8 - 3" by convention. Note that both this expression
and the previous expression performed those operations (e.g. you can add
parentheses to the string "4 * 2 + 8 - 3" to get either one) but the grouping
of the operations is reflected by the shape of the tree.
*)

let four_times_two_plus_eight_minus_three =
  Minus(
    Plus(
      Times(
        Integer(4),
        Integer(2)),
      Integer(8)),
    Integer(3))
;;

(*
Let us warm up by writing some relatively simple functions on expression trees.
*)

(*
4a. Write a function called "uses_times" which determines whether a given
expression contains a multiplication operation.
*)

let rec uses_times (e : expr) : bool = failwith "Not Implemented";;

(*
4b. Write a function called "get_all_integers" which produces a list of the
unique integers that an expression contains (no duplicates in list please) 
Remember you can use library functions on this HW - make life easier with them.
*)

let rec get_all_integers (e : expr) : int list = failwith "Not Implemented";;

(*
4c. Write a recursive function which will transform an expression
into a string. (This process is sometimes called "pretty-printing".) Be
careful to handle parentheses correctly! You are permitted to add parentheses
to the string at every level of the expression but for fun try to minimize the
number of parentheses that your function generates!
*)

let rec pretty_print (e : expr) : string = failwith "Not Implemented";;

(*
4d. Write a recursive function to evaluate arithmetic expressions to integers.
Use the insights of the BOOL evaluator we covered in lecture and is in the book;
it is very similar in spirit.
*)

let rec eval (e : expr) : int = failwith "Not Implemented";;

(* Problem 5 *****************************************************************)
(* 
Port your arithmetic evaluator in Problem 4 to a module: make a file arith.ml
which is a standalone module implementation of the expr type, and the eval
function defined above (just copy your final code into that file, you are
submitting two versions of the same question answer).

We will test it by compiling and #load-ing your arith.ml into the top loop and
invoking it using OCaml module syntax:

#load "arith.cmo";; (* we will compile your arith.ml to make this file *)
#open Arith;; (* make type expr and eval function available at top level *)
eval Minus(
    Times(
      Integer(4),
      Plus(
        Integer(2),
        Integer(8))),
    Integer(3));;

You should test your module that way as well just to be sure it is working
correctly.

Reference: recall that at the end of lecture.ml we reviewed how to do file-based
compilation. Here is a remark from that file that bears repeating:

   See http://pl.cs.jhu.edu/pl/ocaml/code/sep.zip for the example we cover in lecture.
   We will follow http://pl.cs.jhu.edu/pl/ocaml/code/sep_compile/readme.txt in particular.
   See the ocaml manual Chapter 8 for the full documentation
*)
