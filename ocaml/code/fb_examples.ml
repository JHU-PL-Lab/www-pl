(* ************************************** *)
(* ****** Programming In Fb ************* *)
(* ************************************** *)

(*   
   This file contains a series of Fb example programs.  They are formatted
   as strings which can be parsed and evaluated using the debug utilities.

   To run these examples in your interpeter, type shell command

   $ dune utop ./Fb

   To use the reference interpreter, type

   $ ./reference/Fb/toplevel.exe

   Once you have oen of these utop's running, to make functions visible type

   open Debugutils;;
   open Fbdk.Ast;;

*)

(* Note this file does not perform the actual evaluations; 
   some example evaluations are in comments such as
   
   peu "3+2";;
   
   -- the peu function abreviates unparse (eval (parse "3+2"))) - parse, eval, and pretty print. 
   
   Also remember you can use parse, eval, and unparse 
   individually on these examples to understand the underlying OCaml 
   AST representations and to debug your code. 

   Lastly, if you want to easily "copy/paste" all these examples in this file
   into the top loop you can type

   #use "fb_examples.ml";;

   Assuming you launched utop in the directory where this file is.
   If you are in the wrong directory you can use the usual Linux/Mac
   directory path stuff to load the file.  Also utop has #cd and #pwd which 
   work like the Linux/Mac terminal commands.

*)

open Fbdk;;
open Debugutils;;

let ex1 = "If Not(1 = 2) Then 3 Else 4";;

let ex2 = "(Function x -> x + 1) 5" ;;

let ex3 = "(Function x -> Function y -> x + y) 4 5" ;;

let ex4 = "Let Rec fib x =
    If x = 1 Or x = 2 Then 1 Else fib (x - 1) + fib (x - 2)
    In fib 6" ;;

let ex5 = "(Function x -> x + 2)(3 + 2 + 5)" ;;

let ex6 = "(Function x -> Function x -> x) 3" ;;

let ex7 = "Function x -> Function y -> x + y + z";;

let ex8 =
 "Let Rec x1 x2 =
     If x2 = 1 Then
          (Function x3 -> x3 (x2 - 1)) (Function x4 -> x4)
     Else
          x1 (x2 - 1)
  In x1 100";;


let ex9 = "If 3 = 4 Then 5 Else 4 + 2" ;;

let ex10 = "(Function x -> If 3 = x Then 5 Else x + 2) 4 " ;;

let ex11 = "(Function x -> x x)(Function y -> y) " ;;

let ex12 = "(Function f -> Function x -> f(f(x)))
           (Function x -> x - 1) 4" ;;

let ex13 = "(Function x -> Function y -> x + y)
    ((Function x -> If 3 = x Then 5 Else x + 2) 4)
    ((Function f -> Function x -> f (f x))
            (Function x -> x - 1) 4 )" ;;

let ex14 = "Let Rec f x =
    If x = 1 Then 1 Else x + f (x - 1)
In f 3" ;;


let ex15 = "Let Rec f x =
    If x = 1 Then 1 Else x + f (x - 1)
  In f" ;;


let diverger = "(Function x -> x x)(Function x -> x x)" ;;

let combI = "Function x -> x";;
let combK = "Function x -> Function y -> x";;
let combS = "Function x -> Function y -> Function z -> (x z) (y z)";;
let combD = "Function x -> x x";;

(* ************************************************************ *)
(* ****** Simple Fb Macros Using String Concatenation ********* *)
(* ************************************************************ *)

(* 
   * Macros are simply functions on *code*
   * They are run (expanded) by a compiler preprocessor to produce the final code object which is then compiled
   * They run like how our Fb evaluator runs: **substitute**
   * In an actual macro system you can use the full language syntax; C:

   #define double(n) (n + n) /* Full C syntax on RHS of this C macro */

   Simple version for Fb: use string-functions-in-OCaml as the macro language
   No this is not ideal but it is very simple. 
 *)

let double n = "(" ^ n ^ ") + (" ^ n ^ ")"

double "2 + 4";; (* "(2 + 4) + (2 + 4)" *)

(* 
   * Why didn't we just write n ^"+" ^ n above?? We need parens around all
   macro parameters like the n to not change the parse order.
   * Yes, this is a hackish notion of macros
   * But it is very simple so we will use it.
   * Notice also that macros do not do any evaluation -- 2+4 not 6 in the above.
*)

(* Macros can be used in code-strings by appending them in *)

let quad = "Fun z -> (" ^ double "z" ^ ") + (" ^ double "z" ^ ")";;
  
  (* this returns "Fun z -> ((z) + (z)) + ((z) + (z))" *)

(* Example of a BAD macro *)
let apply_bad f x = f^" "^x;; (* sort of looks right here ... *)
let apply_eg = apply_bad "Fun x ->x" "0";; (* oops! this is "Fun x ->x 0" *)
let apply_fixed f x = "("^f^")("^x^")";;
let apply_eg_fixed = apply_fixed "Fun x ->x" "0";; (* "(Fun x ->x)(0)" *)

(* Using macros to encode features in Fb

   Encoding Pairs in Fb 

   First lets hack some by hand, then write a general macro. *)

(* Fact: the following odd thing behaves a lot like OCaml's "(3,2)" *)

let pair_eg = "Fun d -> d 3 2";;

(* Proof: we can "get left side out" (and similarly for right) *)

let getleft = "Let p = ("^pair_eg^") In p (Fun x -> Fun y -> x)"

(* Macro which makes an eager pair (pair of values). *)
let pr c1 c2  = (* c1 and c2 are strings - think macro parameters *)
  "(Let lft = ("^c1^") In Let rgt = ("^c2^") In
      Function x -> x lft rgt)";;

let pc = pr "34+3" "45";;  (* construct a string representing the Fb program for this pair *)

(* Macros for extracting contents of pairs *)
let left c =  "Let c = "^c^" In c (Function x -> Function y -> x)";;
let right c =  "("^c^") (Function x -> Function y -> y)";;
let use_pr = left pc;;

(* peu use_pr;; *)

(* A use of pairs: an Fb function which takes a pair, adds up components 
   High level idea is Fun p -> left p + right p, add ^'s and ()'s  
   Since pair encoding is via macros you need to escape to OCaml to use them *)

let pair_add = "Fun p -> ("^ left "p" ^ ") + (" ^ right "p" ^ ")";;
let use_pair_add =  "(" ^ pair_add ^ ")(" ^ pc ^ ")";;

(* Encoding Lists.  

   See the book section 2.3.4 for a discussion of why this works. *)

(* First lets just make lists as pairs of (head,tail), 
   which has a bug *)

let cons e1 e2 = pr e1 e2;; (* use the above pair macro in cons (::) macro *)
let emptylist = pr "0" "0";; (* make something up here *)
let head e = left e;;
let tail e = right e;;

let eglist = cons "0" (cons "4" (cons "2" emptylist));; (* [0;4;2] encoded *)
let eghd = head eglist;;
 
(* peu eghd;; *)

let egtl = tail eglist;;

(* peu egtl;; *)

let eghdtl = head (tail eglist);;

(* peu eghdtl;; *)

(* All good so far, but can't test for empty list!
   Seems like "tl l = 0" would work but if l is not empty it would get stuck. *)

(* Solution: tag each element with a flag of emptylist or not *)
(* Makes lists triples of (tag,head,tail) - lets make triple macros *)

let triple a b c = pr (pr a b) c;; (* triples in terms of pairs *)
let tfirst t = left (left t);;
let tsecond t = right (left t);;
let tthird t = (right t);;
let cons (e1, e2) = triple "False" e1 e2;; (* tag False means its not emptylist *)
let emptylist = triple "True" "0" "0";; (* tag True --> empty list!  0's are filler *)
let head e = tsecond e;;
let tail e = tthird e;;
let isempty e = tfirst e;; (* Pull out the tag: True -> empty list, False -> not *)

let eglist = cons("0",cons("4",cons("2",emptylist)));;
let eghd = head eglist;;

(* peu eghd;; *)

let egtl = tail eglist;;

(* peu egtl;; *)

let eghdtl = head (tail eglist);;

(* peu eghdtl;; *)

(* Now for a real program: length of a list *)

let length =
 "Let Rec len l =
      If "^isempty "l"^"
      Then 0
      Else
          1 + len ("^tail "l"^")
   In len";;

let eglength = "Let len = "^length^" In len ("^eglist^")";;

(* peu eglength;; *)

(* Freeze and thaw macros: stop and start evaluation explicitly. *)

let freeze e = "(Fun x -> ("^e^"))";; (* the Fun blocks the evaluator from e *)
let thaw e = "(("^e^") 0)";; (* the 0 here is arbitrary *)

(* Using Freeze and Thaw *)

let lazy_num = freeze "5+2+10922";;
(* peu lazy_num (* notice no arithmetic evaluation is taking place *) *)
let lazy_double = "(Fun nl -> "^thaw "nl"^" + "^thaw "nl"^")";;
let using_lazy = "Let f = "^lazy_double^" In f "^lazy_num;;

(* peu using_lazy;; *)

(* Freeze above has a bug if x occurs free in expression e. *)

let bad_freeze_use = "Let x = 5 In ("^freeze "1 + x"^")"
let thaw_bad = thaw bad_freeze_use;; (* should be 6 but returns 1 *)

(* fix hack *)
let freeze e = "(Fun x_9282733 -> ("^e^"))";; (* a hack; really should find a var not in e *)
(* This issue is called a _hygiene condition_ and real-world macro systems need to address this *)

(* Let is built-in but it is also easy to define as a macro: it is just a function call.
*)

let fblet x e1 e2 = "(Fun "^x^" -> "^e2^")("^e1^")";;
let let_ex = fblet "z" (* = *) "2+3" (* In *) "z + z";; (* Let z = 2 + 3 In z + z *)

(* peu let_ex;; *)

(* ************************************* *)
(* *** Y Combinator ******************** *)
(* ************************************* *)

(* Recursion in Fb a la Python explicit chaining of self as an argument *)

let summate0 = "(Fun self -> Fun arg ->
    If arg = 0 Then 0 Else arg + self self (arg - 1))";;

let summate0test = (summate0 ^ summate0 ^ "5");;

(* The above works but lets 
  1) get rid of explicit self parameter in recursive calls and     
  2) get rid of the need to do the final line with one function    
     -- lets make one master combinator to do all this. *)

(* So, our goal is to make a function ycomb such that:

ycomb (Fun self -> Fun arg ->
    If arg = 0 Then 0 Else arg + self (arg - 1)) 5

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
(* peu test1;; *)

let test2 = newbump^"4";;
(* peu test2;; *)

(* Warm-up for a particular refactoring neeed to make ycomb: 

  Suppose we want x+x in multiple places in some code, 
  but want the programmer to just write xpx, and rig 
  a harness to pass in x+x in place of x. 

  This will be more clear from the example below. *)

(* Suppose programmer writes this: *)
let code = "(Fun xpx -> Fun y -> If y = 1 Then xpx Else xpx + 1)";; 

 (* And we want to convert to this: *)
let goalcode =
   "(Fun x -> Fun y -> If y = 1 Then x+x Else x + x + 1)";;

(* Here is a converter that will do it: its just a function
   taking original code as argument *)
let cvrt = "(Fun code -> Fun x -> Fun y -> code (x + x) y)";;

(* Test to show it works *)

(* First lets run the goal *)
let run0 = goalcode^"5 2";;
(* peu run0;; *)

(* Lets show the converted code has the same value *)

let convertedcode = "("^cvrt^")("^code^")";;
let run = convertedcode^" 5 2";;
(* peu run;; *)

(* We can see how we are doing code surgery if we just apply code argument: *)

(* peu convertedcode;; (* shows how we plugged in the x+x; this returns
Fun x -> Fun y -> ((Fun xpx -> Fun y -> If y = 1 Then xpx
                    Else xpx + 1) (x + x)) (y) *) *)

(* Note in the above is not identical to goalcode, but its equivalent
   -- the evaluator stopped by Fun x before it could plug in x+x. *)

(* Now back to Y above.. lets do the same trick, but
   instead of replacing xpx with x+x lets replace
   rec with self self to get something like summate0. *)

(* Here is the code we would like to write *)
let code = "(Fun rec -> Fun arg -> 
               If arg = 0 Then 0 Else arg + rec (arg - 1))"

(* here is the replacer -- replace rec with self self in above
   for f here we will pass in "code" above *)

let repl = "(Fun f -> Fun self -> Fun x -> f (self self) x)";;

(* Do the replacer -- should make something like summate0 *)
let summate0again = "("^repl^code^")";;
let go = summate0again^summate0again^"(5)";;
(* peu go;; (* verify it works *) *)

(* Now lets put this together to make a single ycomb to do it all.
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
(* peu goy0;; *)

(* Notice we can simplify ycomb0:
   inline variable code for repl's parameter f in ycomb0  
   to get ycomb that is in the book, the Y we need *)

let ycomb = "(Fun code -> Let repl = Fun self -> Fun x -> code (self self) x In repl repl)";;

(* Again lets verify this works *)
let goy = ycomb^code^" 5";;
(* peu goy;; *)


(* *********************************************************** *)
(* Another version of Y derivation, based on whats in the book *)
(* This is not covered in lecture, its "color commentary"      *)
(* *********************************************************** *)

(* Step one: lets write the function like we want to: *)

let summate_bod =
  "(Fun this -> Fun arg ->
      If arg = 0 Then 0 Else arg + this (arg - 1))";;

(* Step two: make a fancy *combinator* to turn summate_bod into summate0-like thing *)

let this_to_thisthis =
  "(Fun bod ->
      Fun this -> Fun arg -> bod (this this) arg)";;

let summate_bod_to_summate0 = "("^this_to_thisthis ^ summate_bod^")";;

(* Now lets test to verify this refactoring worked. *)

let summate_bod_test = (summate_bod_to_summate0 ^ summate_bod_to_summate0 ^ "93");;

(* peu summate_bod_test;; *)

(* Yes, it worked!  Now lets compose these two steps to build recursive function in one go. *)

let combY =
  "(Function body ->
      Let this_to_thisthis = (Function this -> Function arg -> body (this this) arg)
      In this_to_thisthis this_to_thisthis)
   ";;

let summate = combY^"(Function this -> Function arg ->
    If arg = 0 Then 0 Else arg + this (arg - 1))";;

(* peu (summate ^ "8");; *)

(* Recursion via self passing -- "Encoding Recursion by Passing Self" in the book *)
(* This is another way Y can be built, it may help you understand it better *)

(* First, the paradox *)

let paradox = "(Function x -> Not(x x))(Function x -> Not(x x))" ;;

(* Next, freeze the "x x" so it doesn't chain forever
   and repace Not with a macro parameter -- something we can plug in *)

let makeFroFs cF = "(Function x -> ("^cF^")(Function _ -> x x)) (Function x -> ("^cF^")(Function _ -> x x))";;

(* Observe cF is getting a parameter which is a frozen version of the cF generator *)

(* A concrete functional we can plug in to do recursion *)
let fF = "(Function froFs -> Function n ->
If n = 0 Then 0 Else n + froFs 33 (n - 1))";;

let fCall = "("^(makeFroFs fF)^") 5";;

(* peu fCall;; *)  (* look ma, no Let Rec! *)

(* The hard stuff is done, now we just clean things up *)

(* replace dummy parameter _ with actual argument: pun *)

let makeFs cF = "(Function x -> ("^cF^")(Function n -> (x x) n)) (Function x -> ("^cF^")(Function n -> (x x) n))"

let fF' = "(Function fs -> Function n ->
If n = 0 Then 0 Else n + fs (n - 1))";;

let fCall' = "("^(makeFs fF')^") 5";;

(* replace macro with a function call - embed the macro in PL *)

let yY = "(Function cF -> (Function x -> cF (Function n -> (x x) n)) (Function x -> cF (Function n -> (x x) n)))"

let yEg = yY^fF';;

let fCall'' = "("^yEg^") 5";;

(* peu fCall'';; *)
