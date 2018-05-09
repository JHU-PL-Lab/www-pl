(* Recursion in Fb a la Python explicit chaining of self as an argument *)

let summate0 = "(Fun self -> Fun arg ->
    If arg = 0 Then 0 Else arg + self self (arg - 1))";;

let summate0test = (summate0 ^ summate0 ^ "5");;

(* The above works but lets 
  1) get rid of explicit self parameter in recursive calls and     
  2) get rid of the need to do the final line with one function    
     -- lets make one master combinator to do all this. *)

(* So, our goal is to make a function ycomb such that:

ycomb (Fun this -> Fun arg ->
    If arg = 0 Then 0 Else arg + this this (arg - 1)) 5

    computes to 15.

*)


(* Background: refactorings in Fb code 
   and using them to make a Y-combinator *)

(* Very simple refactoring to start with, consider: *)

let bump = "(Fun x -> If x = 0 Then 1 Else 0)";;

(* Suppose we wanted to convert this to code where the    
   equivalence relation was a parameter, not just "="
      -- makes for more general code *)

let bumpgeneral = "(Fun eq -> Fun x -> If eq x 0 Then 1 Else 0)";;

(* Now feed in a concrete function for equivalence *)

let newbump = bumpgeneral^"(Fun n1 -> Fun n2 -> n1 = (n2 + 0))";;

(* The following two tests should give the same result *)

let test1 = bump^"4";;
rep test1;;

let test2 = newbump^"4";;
rep test2;;

(* Warm-up for a particular refactoring neeed to make ycomb: 

  Suppose we want x+x in multiple places in some code, 
  but want the programmer to just write xpx, and rig 
  a harness to pass in x+x in place of x. 

  This will be more clear from the example: *)

(* programmer writes this: *)
let code = "(Fun xpx -> Fun y -> If y = 1 Then xpx Else xpx + 1)";; 

 (* want to convert to this: *)
let goalcode =
   "(Fun x -> Fun y -> If y = 1 Then x+x Else x + x + 1)";;

(* Here is a converter that will do it: its just a function
   taking original code as argument *)
let cvrt = "(Fun code -> Fun x -> Fun y -> code (x + x) y)";;

(* Test to show it works *)

(* First lets run the goal *)
let run0 = goalcode^"5 2";;
rep run0;;

(* Lets show the converted code has the same value *)

let convertedcode = "("^cvrt^")("^code^")";;
let run = convertedcode^" 5 2";;
rep run;;



(* Now back to Y above.. lets do the same trick, but
   instead of replacing xpx with x+x lets replace
   rec with self self to get something like summate0. *)

(* Here is the code we would like to write *)
let code = "(Fun rec -> Fun arg -> 
               If arg = 0 Then 0 Else arg + rec (arg - 1))"

(* here is the replacer -- replace rec with self self in above *)
let repl = "(Fun f -> Fun self -> Fun x -> f (self self) x)";;

(* Do the replacer -- should make something like summate0 *)
let summate0again = "("^repl^code^")";;
let go = summate0again^summate0again^"(5)";;

(* Now lets put this together to make a single ycomb to do all
   ycomb0 just packages what we did above into a function:
   feed it code as an argument, run repl on it, and self-apply.
*)

let ycomb0 =
  "(Fun code -> 
      Let repl = (Fun f -> Fun self -> 
                            Fun x -> f (self self) x) 
      In
        (repl code)(repl code))";;

(* Lets verify it works *)
let goy0 = ycomb0^code^" 5";;
rep goy0;;

(* Notice we can simplify ycomb0:
   inline variable code for repl's parameter f in ycomb0  
   to get ycomb that is in the book, our Y we need *)

let ycomb = "(Fun code -> Let repl = Fun self -> Fun x -> code (self self) x In repl repl)";;

(* Again lets verify this works *)
let goy = ycomb^code^" 5";;
rep goy;;
