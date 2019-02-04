(*

POPL Assignment 1
 
Name                  : 
List of Collaborators :

Please make a good faith effort at listing people you discussed any 
problems with here, as per the course academic integrity policy.  
TA/CA/Prof need not be listed.

Fill in the function definitions below replacing the 

  failwith "Not Implemented"

with your code.  Feel free to add "rec" to any function listed to make
it recursive. In some cases, you will find it helpful to define
auxillary functions, feel free to.  Other than replacing the failwiths
and adding recs, don't edit or remove anything else in the file -- the
autograder will not be happy!  Note you are NOT allowed to use the
"List.sort" etc library functions; this rule holds just for this HW.
You also cannot use mutation (arrays, := etc), which we have not even
covered yet.

Some tests are provided via OCaml's built-in assert function; they will
raise an exception on failure and return () on success.

*)

(* Problem 1 ************************************************************************ *)

(* Define a function contains taking an element and a list and returning true if the
   element is in the list, and false otherwise. *)


let contains elt l = failwith "Not Implemented";;

(* assert( contains 10 [1; 2; 10] = true )
   assert( contains 10 [1; 2] = false )
   assert( contains "bar" ["foo"; "bar"; "baz"] = true )

*)

(* Problem 2 ************************************************************************ *)

(* Define a function remove_elts taking a list of items as well as a list of items to 
   remove from the first list, and returning a list with all occurrences of the items 
   to be removed gone.

*)

let remove_elts l reml = failwith "Not Implemented";;

(* assert ( remove_elts [1; 2; 3; 4; 5] [2; 4] = [1; 3; 5] )
   assert ( remove_elts [2; 4; 3; 2; 5] [2; 4; 2] = [3; 5] )
   assert ( remove_elts ['a'; 'e'] ['c'] = ['a'; 'e'] )

*)

(* Problem 3 ************************************************************************ *)

(* Define a function circular_right_shift taking a list and rotating the elements
   so the last element becomes the first; the length of the list remains the same.  *)


let circular_right_shift l = failwith "Not Implemented";;

(* assert(circular_right_shift [1; 2; 10] = [10; 1; 2])
   assert(circular_right_shift ["aye"; "boo"; "sea"] = ["sea"; "aye"; "boo"])

*)


(* Problem 4 ************************************************************************ *)

(* Define a function circular_right_shift_n l n taking a list and a number n
   and circularly rotating to the right n times. *)

let circular_right_shift_n l n = failwith "Not Implemented";;

(* assert(circular_right_shift_n [1; 2; 10] 1 = [10; 1; 2])
   assert(circular_right_shift_n ["aye"; "boo"; "sea"] 2 = ["boo", "sea"; "aye"])
   assert(circular_right_shift_n ["aye"; "boo"; "sea"] 300 = ["aye", "boo"; "sea"])
   assert(let noop_list l = circular_right_shift_n l (List.length l) in (noop_list [1;3;2]) = [1;3;2])
*)

(* Problem 5 ************************************************************************ *)

(* Define a function twosum that takes a target integer and a list of integers,
   and returns a pair of the first two elements of the list that add up to the target.
   Since there may be no such pair the function needs to return something in that case;
   use the built-in 'a option type to return Some( a pair ) if so and None if none exists.
*)

let twosum target li = failwith "Not Implemented";;

(* assert(twosum 5 [3; 1; 2; 6] = Some(3, 2))
   assert(twosum 12 [3; 1; 2; 6] = None)
   assert(twosum 0 [-2; -1; 1; 2; 3] = Some(-2, 2)) (* this e.g. clarifies what "first pair" means *)
*)

(* Problem 6 ************************************************************************ *)
(*
  Let's get rich with Bitcoin :-)

  Say you have a list for which the ith element is the price of Bitcoin on day i.
  You're only permitted to buy 1 Bitcoin on one day and sell it on a later day.
  Define a function buysell that takes a list of non-negative integers,
  and returns the maximum amount of profit that can be made given the price list.

  Note that you need not buy anything, so if the profit is always negative don't buy!

*)

let rec buysell li = failwith "Not Implemented";;


(* assert(buysell [4;6;2;5;7] = 5)
   Buy on day 3 (at $2) and sell on day 5 (at $7), max profit = $7 - $2 = $5

   assert(buysell [3;2;1] = 0)
   In this case, no transaction is done to avoid losing money, max profit = 0.

   assert(buysell [7;5;4;1;2;0;1;2] = 2)
   Buy on day 6 (for free) and sell on day 8 (at $2), max profit = $2 - $0 = $2

   assert(buysell [] = 0)
   assert(buysell [2] = 0)
*)

(* Problem 7 ************************************************************************ *) 

(* Lets have fun with functions. Define a function to filter the elements in a list using
   a supplied predicate (a function returning either true or false) *)

let filter f lst = failwith "Not Implemented";;

(* 
  assert ( filter (fun x -> x = 0) [0;1;0;0;0;1] = [0;0;0;0] )
  assert ( filter (fun s -> String.get s 0 = 'S') ["Shiwei"; "Scott"; "Leandro"; "Andrew"; "Steve"; Yoshi] 
            = ["Shiwei"; "Scott"; "Steve"] )
  assert ( filter (fun _ -> false) ['n'; 'o'; 't'] = [] )
 *)

(* Problem 8 ************************************************************************ *) 

(* That wasn't enough fun.  For this question take a list of functions and a value and 
   compose the functions on the value so e.g. compose_funs [f,g,h] v = f(g(h v)).
*)

let compose_funs fs v = failwith "Not Implemented";;

(*
   assert(compose_funs [(fun y -> (y - 5) * 3); (fun x -> x - 4)] 10 = 3)
   assert(compose_funs [(fun y -> y^"!"); (fun y -> y^" ho"); (fun x -> x^" hi")] "hello" = "hello hi ho!")
*)

(* Problem 9 ************************************************************************ *)

(* Define a function fizzbuzz that takes n1 and n2 and generates a list of strings corresponding
   to the integers from n1 to n2 inclusive.
   Any number that's a multiple of 3 should be a "fizz"
   Any number that's a multiple of 5 should be a "buzz"
   Any number that's a multiple of 3 and 5 should be a "fizzbuzz"
   Note that you may either be counting up or down depending on whether n1 < n2 or vice-versa.
*)

let fizzbuzz n1 n2 = failwith "Not Implemented";;

(* assert(fizzbuzz 4 10 = [""; "buzz"; "fizz"; ""; ""; "fizz"; "buzz"])
   assert(fizzbuzz 17 12 = [""; ""; "fizzbuzz"; ""; ""; "fizz"])
   assert(fizzbuzz (-29) (-31) = [""; "fizzbuzz"; ""])
   assert(fizzbuzz (-2) 3 = [""; ""; "fizzbuzz"; ""; ""; "fizz"])
*)


(* Problem 8 ************************************************************************ *)

(* Define a function that computes the cartesian_product of two sets.
   We use lists to express sets; you can assume the input lists contain no duplicates, 
   i.e. they are sets and not multisets.
 *)

let rec cartesian_product lst1 lst2 = failwith "Not Implemented";;

(* 
  assert (cartesian_product [] [] = [])
  assert (cartesian_product ['A'] [] = [])
  assert (cartesian_product [] [1] = [])
  assert (cartesian_product ['A'] [1] = [('A', 1)])
  assert (cartesian_product ['A'; 'Z'] [1; 127] = [('A', 1); ('A', 127); ('Z', 1); ('Z', 127)])
  assert (cartesian_product ['A'; 'Z'] [1; 127; 89757] = 
      [('A', 1); ('A', 127); ('Z', 1); ('Z', 127); ('A', 89757); ('Z', 89757);])
*)

