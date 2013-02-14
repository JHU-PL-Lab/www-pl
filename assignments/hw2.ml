(*
  600.426 - Programming Languages
  JHU Spring 2013
  Homework 2

  In this source file, you will find a number of comments containing the text
  "ANSWER".  Each of these comments indicates a portion of the source code you
  must fill in yourself.  You are welcome to include other functions for use in
  your answers.  Read the instructions for each problem and supply a segment of
  code which accomplishes the indicated task.  For your convenience, a number of
  test expressions are provided for each problem as well as a description of
  their expected values.

  In this assignment, you are permitted to complete the listed tasks using any
  of the OCaml modules/functions.  However you are still required to avoid the use of
  mutation unless explicitly specified in the question.
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
(* Section 1 : The Game of Types                                                                      *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  1. For the next several problems, you will be asked to produce an expression which
     has a given type.  It does not matter what expression you provide as long as it
     has that type; there may be numerous (or even infinite) answers for each
     question.  Your answer may *not* produce a compiler warning.  You are *not*
     permitted to use explicit type annotations (such as "fun x:'a -> x").

     [25 Points]
*) 

(* Give an expression which has the following type: int list ref *)
let exp1 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a -> 'b -> 'b *)
let exp2 = ();; (* ANSWER *)

(* Give an expression which has the following type: unit -> unit *)
let exp3 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a list -> ('a -> bool) -> 'a list *)
let exp4 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a list -> 'b list -> ('a -> 'b -> 'c) -> 'c list *)
let exp5 = ();; (* ANSWER *)

(* Give an expression which has the following type: (int -> 'a -> 'b) -> 'a list -> 'b list *)
let exp6 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a list -> ('a -> bool) -> 'a list * 'a list *)
let exp7 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a -> 'b option *)
let exp8 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a -> 'b *)
let exp9 = ();; (* ANSWER *)

type ('a, 'b) foobar = Foo of 'a | Bar of 'b ;;

(* 
  Give an expression which has the following type: 
  ('a * 'b) list -> ('a -> 'b -> bool) -> ('a, 'b) foobar list 
*)
let exp10 = ();; (* ANSWER *)


(* -------------------------------------------------------------------------------------------------- *)
(* Section 2 : An ode to being lazy                                                                     *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  OCaml is an eager language. So you cannot create infinite lists/sequences directly. However you can
  encode them fairly easily in the language.

  For the purpose of this exercise we will encode (potentially) infinite lists using the following type. 
*)
type 'a sequence = Nil | Sequence of 'a * (unit -> 'a sequence);;

(* As a hint, here how you would write a an infinite sequence of zeroes *)
let rec zeroes = Sequence(0, function () -> zeroes);;

(* And a finite sequence 1, 2 *)
let one_and_two = Sequence(1, fun () -> Sequence(2, fun () -> Nil)) ;;


(*
  2a. Write a function to convert a sequence to a list. Of course if you try to evaluate this on an infinite
      sequence, it will not finish. But we will assume sanity on the caller's part and ignore that issue

      [5 Points]
*)
let rec list_of_sequence s = () ;; (* ANSWER *)

(*
# list_of_sequence one_and_two ;;
- : int list = [1; 2]
*)

(* 
  2b. While it is nice to have these infinite sequences, it is often useful to "cut" them to a fixed size. Write
      a function that cuts off a sequence after a fixed number of values. The return value is a finite sequence
      of the same type. 

      (Treat the given count 'n' as the maximum number of elements allowed in the output sequence. So if the input 
      is a finite sequence and its length is less than the specified count, the output sequence can have less than
      'n' values)

      [5 Points]
*)
let rec cut_sequence n s =  () ;; (* ANSWER *)

(*
# list_of_sequence (cut_sequence 5 zeroes) ;;
- : int list = [0; 0; 0; 0; 0]
*) 


(*
  2c. You can also encode finite sequences directly using the above type. For this question encode the sequence
      corresponding to an arithmetic progression given an initial value, the end value (inclusive) and the common
      difference (the step size of the sequence)

      [5 Points]
*)
let rec ap initv endv diff =  () ;; (* ANSWER *)

(*
# list_of_sequence (ap 1 12 3) ;;
- : int list = [1; 4; 7; 10]
# list_of_sequence (ap 0 10 2)  ;;
- : int list = [0; 2; 4; 6; 8; 10]
*) 

(*
  2d. Now write an infinite sequence of fibonacci numbers that start at 0. i.e. The sequence 0, 1, 1, 2, 3 ..

      [5 Points]
*) 
let fib =  () ;; (* ANSWER *)
(*
# list_of_sequence (cut_sequence 10 fib) ;;
- : int list = [0; 1; 1; 2; 3; 5; 8; 13; 21; 34]
*)

(*
  2e. Write a map function (analogous to List.map) which takes a function and a sequence 
      as input and returns a new sequence where the values have been mapped using the input
      function.

      [5 Points]    
*)
let rec map_sequence fn s =  () ;; (* ANSWER *)

(*
# list_of_sequence(map_sequence (fun x -> x * 2) (ap 0 10 2)) ;;
- : int list = [0; 4; 8; 12; 16; 20]
# list_of_sequence(map_sequence Char.chr (ap 65 90 1)) ;;
- : char list =
['A'; 'B'; 'C'; 'D'; 'E'; 'F'; 'G'; 'H'; 'I'; 'J'; 'K'; 'L'; 'M'; 'N'; 'O';
 'P'; 'Q'; 'R'; 'S'; 'T'; 'U'; 'V'; 'W'; 'X'; 'Y'; 'Z']
*)

(*
  2f. Write a filter function (analogous to List.filter) which takes a predicate and a sequence 
      as input and returns a new sequence of elements from the input sequence that satisfies the
      predicate

      Note that if the input is an infinite sequence and the predicate is never satisfied by any
      element in the sequence, this function may not terminate. You can ignore this issue.

      [5 Points]    
*)
let rec filter_sequence fn s =  () ;; (* ANSWER *)

(*
# list_of_sequence(filter_sequence (fun x -> x mod 3 = 0) (ap 0 12 2)) ;;
- : int list = [0; 6; 12]
# list_of_sequence(cut_sequence 5 (filter_sequence (fun x -> x mod 5 = 0) fib)) ;;
- : int list = [0; 5; 55; 610; 6765]
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 3 : Making Modules                                                                         *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  3a. Create a simple double ended queue (deque) class that has the following methods:
      * empty : unit -> 'a deque                - The method returns a *new* empty deque instance
      * push_back : 'a -> 'a deque-> 'a deque   - Add a new value to the end of the deque
      * pop_back : 'a deque-> 'a deque          - Remove a value from the end of the deque. If deque is empty throw an exception 
                                                  (using invalid_arg)  
      * push_front : 'a -> 'a deque-> 'a deque  - Add a new value to the front of the deque
      * pop_front : 'a deque-> 'a deque         - Remove a value from the start of the queue. If deque is empty throw an exception 
                                                  (using invalid_arg)
      * front : 'a deque -> 'a option           - Return the value at the front of the deque if there is one.
      * back: 'a deque -> 'a option             - Return the value at the back end of the deque if there is one.
      * is_empty : 'a deque -> bool             - Returns true if the deque is empty, otherwise false
    
      In the section below, fill out the signature and the implementation details. You must explicitly leave any
      types in the signature abstract. (This is good practice in the software engineering sense. By not explicitly
      binding the types on the interface, you allow different implementations to choose types best suited
      for their goals)
    
      NOTE: When you query the type of your functions in the top loop, it might return the fully qualified type signatures.
      E.g: empty : unit -> 'a GDeque.queue instead of just unit -> 'a queue. This is fine. 

      [10 Points]
*)


module type GDEQUE =
  sig
    (* ANSWER *)
  end
;;

module GDeque : GDEQUE =
  struct
    (* ANSWER *)
  end
;;
 
(* 
# let q1 = GDeque.empty () ;;
val q1 : '_a GDeque.deque = <abstr>
# GDeque.is_empty q ;; 
- : bool = true
# let q2 = GDeque.push_back 1 q ;; 
val q2 : int GDeque.deque = <abstr>
# GDeque.front q2 ;;
- : int option = Some 1
# GDeque.back q2 ;;
- : int option = Some 1
# let q3 = GDeque.push_front 2 q2 ;;
val q3 : int GDeque.deque = <abstr>
# let q4 = GDeque.pop_back q3 ;;
val q4 : int GDeque.deque = <abstr>
# GDeque.back q4 ;;
- : int option = Some 2
# let q5 = GDeque.pop_back q4 ;;
val q5 : int GDeque.deque = <abstr>
# GDeque.back q5 ;;
- : int option = None
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 4 : Symbolic Computations                                                                  *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  Natural numbers, defined inductively using Peano axioms (http://en.wikipedia.org/wiki/Peano_axioms) can
  be represented in OCaml using the type below. i.e. A number is either Zero or the successor of another 
  number.   
*) 
type number = Zero | Succ of number ;;

(* 4a. Write a function to convert a number to an OCaml integer value [4 Points] *)
let rec int_of_number n =  () ;; (* ANSWER *)

(* 
# int_of_number Zero ;; 
- : int = 0
# int_of_number (Succ(Succ(Succ(Zero)))) ;;
- : int = 3
*)

(* 4b. Write a function to convert a an OCaml integer to a number [4 Points] *)
let rec number_of_int v =  () ;; (* ANSWER *)

(*
# number_of_int 3 ;;
- : number = Succ (Succ (Succ Zero))
# int_of_number (number_of_int 25) ;;
- : int = 25
*)

(* 
  4c. Write a function to add two numbers. You are NOT allowed to convert them to ocaml integers, add
      them and convert it back
      
      [5 Points]
*)
let rec add_numbers n1 n2 =   () ;; (* ANSWER *)
(*
# int_of_number (add_numbers (number_of_int 3) (number_of_int 8)) ;;
- : int = 11  
*)

(* 
  4d. Write a function to compare two numbers. It should return LT if the first value is
      less than the second, EQ if they are equal and GT otherwise. 
  
      You are NOT allowed to convert them to ocaml integers and compare them
      
      [5 Points]
*)

type compare_results = LT | EQ | GT ;;

let rec compare_numbers n1 n2 =  () ;; (* ANSWER *)
       
(*
# compare_numbers (number_of_int 12) (number_of_int 11) ;;
- : compare_results = GT
# compare_numbers (number_of_int 10) (number_of_int 10) ;;
- : compare_results = EQ
*)


(* 
  4e. Write a function to compuate the factorial of a given positive number. You are NOT allowed to convert 
      them to ocaml integers, perform the computation and convert it back.
      
      Note: For many implementations, you are likely to run in to stack overflow issues for fairly moderate 
      values of n (like 10). Make sure it works on the smaller values (in the range of 1-8 or so) however. 
      
      [7 Points]
*)
let rec factorial_number n =   () ;; (* ANSWER *)


(*
# int_of_number (factorial_number (number_of_int 5)) ;;
- : int = 120
# int_of_number (factorial_number (number_of_int 8)) ;;
- : int = 40320
*)


(* -------------------------------------------------------------------------------------------------- *)
(* Section 5 : Mutable State and Memoization                                                          *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  5. Cache: Pure functions (those without side effects) always produces the same value
     when invoked with the same parameter. So instead of recomputing values each time,
     it is possible to cache the results to achieve some speedup.
     
     The general idea is to store the previous arguments the function was called
     on and its results. On a subsequent call if the same argument is passed, 
     the function is not invoked - instead, the result in the cache is immediately 
     returned.  
    
     Note: you will need to use mutable state in some form to implement the cache.
  
     [10 Points]
*)

(*
  Given any function f as an argument, create a function that returns a
  data structure consisting of f and its cache
*)  
let new_cached_fun f = () (* ANSWER *)

(*
  Write a function that takes the above function-cache data structure,
  applies an argument to it (using the cache if possible) and returns
  the result 
*)
let apply_fun_with_cache cached_fn x = () (* ANSWER *)

(*
  The following function makes a cached version for f that looks
  identical to f; users can't see that values are being cached 
*)

let make_cached_fun f = 
  let cf = new_cached_fun f in 
    function x -> apply_fun_with_cache cf x
;;


(*
let f x = x + 1;;
let cache_for_f = new_cached_fun f;;
apply_fun_with_cache cache_for_f 1;;
cache_for_f;;
apply_fun_with_cache cache_for_f 1;;
cache_for_f;;
apply_fun_with_cache cache_for_f 2;;
cache_for_f;;
apply_fun_with_cache cache_for_f 5;;
cache_for_f;;
let cf = make_cached_fun f;;
cf 4;;
cf 4;;


# val f : int -> int = <fun>
# val cache_for_f : ... 
# - : int = 2
# - : ...
# - : int = 2
# - : ...
# - : int = 3
# - : ...
# - : int = 6
# - : ...
# val cf : int -> int = <fun>
# - : int = 5
# - : int = 5
*)
