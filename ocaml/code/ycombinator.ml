(* Feature encoding examples in the FbDK. *)

(* We are also showing here how you can use strings to build up Fb programs in OCaml *)
(* Make sure to put "(...)" parens around these strings or the parser may not do what you want! *)
(* fbexamples.ml file in Fb/ directory gives an alternate approach: compose AST's in OCaml, not strings *)

(* Note to use this file you first need to load the fbdktoploop.ml file into the top loop. *)

(* #cd "/Users/scott/pl/ocaml/code/FbDK/src/Fb";;
   #use "fbdktoploop.ml";;  *)

let res s = let r = Fbpp.pp (eval (parse s)) "" in (print_string r; r);;  (* rep but as a string value *)

(* Pair encoding *)

let pr (e1,e2) = "(Fun lft -> Fun rgt -> Fun x -> x lft rgt)(" ^ e1 ^")("^ e2 ^ ")";;

let preg = pr("4+3","5");;

rep preg;;

let fst p = p ^ "(Fun x -> Fun y -> x)";;
let snd p = p ^ "(Fun x -> Fun y -> y)";;

rep (fst preg);;

(* Freeze and thaw *)

let freeze e = "(Fun unusedvar -> ("^e^"))";;

let thaw e = "("^e^") 99";;

let freezeeg = freeze "3+4";;

rep (freeze "3+4");;

rep (thaw (freeze "3+4"));;

(* Recursion in Fb without Let Rec *)

(* First, lets build and attempt to run Russell's paradox *)

let paraDox = "(Fun x -> Not (x x))(Fun x -> Not (x x))";;

(* evaluating the above will loop forever *)

(* rep paraDox;; *)

(* The above was in effect computing Not(Not(Not(.. ))) - making arbitrary COPIES of code! *)

(* OK lets now try to do useful recursion - replace Not with something taking frozen paradox as argument *)

let summer =  "(Fun froFs -> Fun n -> If n = 0 Then 0 Else n + froFs 99 (n - 1))";; (* 99 is thawing *)

let makeFro = "(Fun x ->  (Fun d -> "^ summer ^"(x x)))(Fun x -> (Fun d -> "^ summer ^"(x x)))";;

rep makeFro;; (* apply one copy to the other *)

rep (makeFro^" 99");; (* apply one copy to the other and thaw - now ready for a number *)

rep (makeFro^" 99 5");; (* Wow! recursion!! *)

(* Now, it turns out we can optimize by swapping summing with freezing *)

let makeFro2 = "(Fun x -> "^ summer ^" (Fun d -> x x))(Fun x -> "^ summer ^" (Fun d -> x x))";;

rep makeFro2;; (* apply one copy to the other -- gets to point ready to summate a number, with two copies inside *)

rep (makeFro2^" 99");; (* don't need to pre-thaw like above *)

(* Now lets optimize again: get rid of that annoying "99" thaw needed in summer above *)

let summ' =  "(Fun fs -> Fun n -> If n = 0 Then 0 Else n + fs (n - 1))";; (* thaw removed *)

(* dummy argument d now turned into actual Fun argument n - pass it on *)
(* Intuition: added "Fun d ->" to stop computation; use "Fun n ->" instead *)

let makeFs = "(Fun x -> "^ summ' ^" (Fun n -> (x x) n)) (Fun x -> "^ summ' ^" (Fun n -> (x x) n))"

rep makeFs;;

rep (makeFs^" 5");;

(* Lastly we just pull efF' out as an Fb function parameter, not a fixed constant *)

let yY = "(Fun f ->
            (Fun x -> f (Fun n -> (x x) n))(Fun x -> f (Fun n -> (x x) n)))";;

(* This Y combinator lets us build a recursive function from something like efF's above. *)

rep (yY^" "^ summ');; (* identical result to evaluating makeFs above *)

rep (yY^" "^ summ' ^" 5");;

(* Try another recursive function *)

let summ'' =  "(Fun this -> Fun n -> If n = 0 Then 0 Else n + n + this (n - 1))";;

rep (yY^" "^ summ'' ^" 5");; (* Y works here as well *)

(* ********************************************************************** *)
(* Some new examples showing run time behavior *)

(* A diverging program but with "Fun d ->" dummy to stop execution in the middle *)
  
let stoppeddiverge = "(Fun s -> Fun d -> s s)(Fun s -> Fun d -> s s)";;

let r1 = res stoppeddiverge;;
  
let r2 = res ("("^r1^") 999");; (* re-start computation *)

let r1 = res ("("^r1^") 999");; (* can run this line arbitrarily many times *)
  
(* Lets incrementally apply things to trace Y now *)

(* First make a version of Y with lots of unique variables in it *)
  
let yY = "(Fun f ->
          (Fun x -> f (Fun a -> (x x) a))(Fun y -> f (Fun b -> (y y) b)))";;

let ysumm = res (yY^" "^ summ'');;

  (* take the output of the above and apply 2 to it *)

rep ("("^ysumm^") 2") ;;
  

(* Now lets do it in slo-mo: add an extra argument but don't pass it on recursion
   -- hack to stop execution after each recursion but to let us re-start it. *)

let yY = "(Fun f ->
          (Fun x -> f (Fun a -> (x x) a))(Fun y -> f (Fun b -> (y y) b)))";;

let slonosumm =  "(Fun this -> Fun n -> Fun stopper -> If n = 0 Then 0 Else this (n - 1))";;
  
let withfun = res (yY^slonosumm);;
    
let applynumandunstop = res ("("^withfun^") 2 999");;
  
let unstoptheabove = res ("("^applynumandunstop^") 999");;

let unstoptheabove' = res ("("^unstoptheabove^") 999");;
