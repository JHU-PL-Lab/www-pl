(* ************************************** *)
(* ****** Programming In Fb ************* *)
(* ************************************** *)

(* First we give some Fb examples from the book.  

   Requires debugscript/fb.ml loaded into top loop to run them. *)

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

(* ************************************* *)
(* ****** Macros *********************** *)
(* ************************************* *)

(* Pairs.   First lets hack some by hand, then do the general macro. *)

let pair32 = "(Fun d -> d 3 2)";;
let pr(c1, c2)  =
  "(Let lft = ("^c1^") In Let rgt = ("^c2^") In
      Function x -> x lft rgt)";;

(* WARNING: in order to avoid parsing precedence problems, 
   make sure when writing macros to (1) enclose the whole macro you
   are defining in (...) and (2) for each parameter, put
   "("^param^")" parens around it.  If you don't do these 
   things the parse precedence can change, creating difficult bugs.  *)

let left c =  "("^c^") (Function x -> Function y -> x)";;
let right c =  "("^c^") (Function x -> Function y -> y)";;

let pc = pr("34+3","45");;  (* construct a string representing the Fb program for this pair *)

let preg = left pc;;

rep preg;;

(* Lists.  See the book section 2.3.4 for a discussion of why this
   works. *)

(* First lets just make lists as pairs of (head,tail), 
   which has a bug *)

let cons (e1, e2) = pr(e1,e2);;
let emptylist = pr("0","0");;
let head e = left e;;
let tail e = right e;;

let eglist = cons("0",cons("4",cons("2",emptylist)));;
let eghd = head eglist;;

rep eghd;;

let egtl = tail eglist;;

rep egtl;;

let eghdtl = head (tail eglist);;

rep eghdtl;;

(* All good so far, but can't test for empty list!  Think about it. *)

(* Solution: tag each element with a flag of emptylist or not *)

let cons (e1, e2) = pr(pr("False",e1),e2);; (* tag False means its not emptylist *)
let emptylist = pr(pr("True","0"),"0");; (* tag True --> empty list!  0's are junk filler *)
let head e = right (left e);; (* need to remove tag on elt via right *)
let tail e = right e;;
let isempty e = (left (left e));; (* Pull out the tag: True -> empty list, False -> not *)

let eglist = cons("0",cons("4",cons("2",emptylist)));;
let eghd = head eglist;;

rep eghd;;

let egtl = tail eglist;;

rep egtl;;

let eghdtl = head (tail eglist);;

rep eghdtl;;

(* Now for a real program: length of a list *)

let length =
 "(Let Rec len l =
      If "^isempty "l"^"
      Then 0
      Else
          1 + len ("^tail "l"^")
   In len)";;

let eglength = length^eglist;;

rep eglength;;

(* Freeze and thaw macros *)

let freeze e = "(Fun x -> "^e^")";; (* glitch here -- x can't be free in e *)
let freeze e = "(Fun x_uniq_9282733 -> "^e^")";; (* somewhat better; best would be to inspect e *)
let thaw e = "("^e^" 0)";;

(* Using Freeze and Thaw *)

let lazy_num = freeze "5+2+10922";;
let lazy_double = "(Fun ln -> "^thaw "ln"^" + "^thaw "ln"^")";;
let using_lazy = lazy_double^lazy_num;;

rep using_lazy;;

(* Let is built-in but it is also easy to define as a macro: its just a function call.
*)

let fblet (x,e1,e2) = "(Fun "^x^" -> "^e2^")("^e1^")";;
let let_ex = fblet("z","2+3","z + z");; (* Let z = 2 + 3 In z + z *)

rep let_ex;;

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


(* *********************************************************** *)
(* Another version of Y derivation, based on whats in the book *)
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

rep summate_bod_test;;

(* Yes, it worked!  Now lets compose these two steps to build recursive function in one go. *)

(* First (incorrect) pass: use Let syntax which is not in Fb *)

let wrong_combY =
  "(Function body ->
      Let this_to_thisthis = (Function this -> Function arg -> body (this this) arg)
      In this_to_thisthis this_to_thisthis
   ";;

(* Above has parse error, no Let in Fb grammar -- need to use our let macro *)

let combY =  "(Function body ->
      "^fblet("this_to_thisthis","(Function this -> Function arg -> body (this this) arg)","this_to_thisthis this_to_thisthis")^")"

(* Here is the let macro expanded FYI *)

let combY = "(Function body ->
    (Function this_to_thisthis -> this_to_thisthis this_to_thisthis)
      (Function this -> Function arg -> body (this this) arg))";;

let summate = combY^"(Function this -> Function arg ->
    If arg = 0 Then 0 Else arg + this (arg - 1))";;

rep (summate ^ "8");;

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

rep fCall;;  (* look ma, no Let Rec! *)

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

rep fCall'';;
