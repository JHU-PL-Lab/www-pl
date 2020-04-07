(* Template for assignment 7 Question 2

   Your submitted file should ONLY define one string, set_beh.
   
   The commented-out code is what you can un-comment to test, 
   just re-comment before submitting.  *)

let set_beh = "0 1";; (* Replace with your set actor's behavior *)

let set_beh = "Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let setbeh = Fun me ->  Fun data -> y (Fun this -> Fun msg ->
     Match msg With
       `add(p) -> (Snd(p) <- 0); (this)
     | `delete(p) -> (Snd(p) <- 0); (this)
     | `isempty(a) -> (a <- True); (this) ) In
   Let set_test = 
      Fun me -> Fun data -> Fun m1 ->
        Let aset = Create(setbeh, 0) In
           ( aset <- `add(22,me) );
           Fun m2 -> 
              (aset <- `add(2,me));
              Fun m3 ->  
                 (aset <- `delete(2,me));
                 Fun m4 -> 
                    (aset <- `isempty(me));
                    Fun m5 -> If m5 Then Print \"Correct\" Else Print \"Wrong\"
    In
    Let set_test_actor = Create(set_test, 0) In
    (set_test_actor <- 0)";;

(* The test code is designed to run in OCaml with the AFbV interpreter loaded.
   Loading AFbV inside OCaml with the debugscript file is similar to Fb etc: *)

(* step 0: launch utop or ocaml from fbdk/ directory *)
(* #use "debugscript/afbv.ml";; *)
(* NOTE: you will first want to edit the above file to use our supplied binaries 
   - replace #directory lines in that file with
   #directory "binaries/libraries";; *)

(* Uncomment the following to see the actor messages and/or actor states as it steps. *)
(* Afbvoptions.show_messages := true;; *)
(* Afbvoptions.show_states := true;; *)

(* OK here is a simple set test. Make sure you understand what this test is doing, like
   the examples in lecture it is setting a new behavior for each subsequent message receipt.
*)

(* 
let set_test = "
    Let setbeh = ("^set_beh^") In
    Let set_test = 
      Fun me -> Fun data -> Fun m1 ->
        Let aset = Create(setbeh, 0) In
           ( aset <- `add(22,me) );
           Fun m2 -> 
              (aset <- `add(2,me));
              Fun m3 ->  
                 (aset <- `delete(2,me));
                 Fun m4 -> 
                    (aset <- `isempty(me));
                    Fun m5 -> If m5 Then Print \"Wrong\" Else Print \"Correct\"

    Let set_test_actor = Create(set_test, 0) In
    (set_test_actor <- 0)";;
 *)
  
(* The above test should print Correct:

rep set_test ;; *)  

(* Note we will be testing your set behavior beyond this simple test. *)  

(* Note AfbV additionally includes syntax for pairs, e.g. 

# Fst(Snd(3,(4,5)));;
==> 4

We are using the pair syntax in some of the messages above.  AFbV also includes basic list syntax, e.g. 

Head (Tail (4 :: [5]));;
==> 5

and for empty list check, equality in fact works:

[] = [4;3];;
==> False

Unfortunately the Match pattern matching is too stupid to be aware of pairs and lists so you need to be manually using Head, Tail, = [], Fst, and Snd.

*)

(* Programming in AFbV is a bit painful due to the poor error messages, etc.  We suggest you
first get the basic messaging structure working but don't actually do the set operations; just return True for all the messages for example.  Once that is working you can fill in the set details.  Also you might want to look at the ping-pong example in the examples file to see more examples of message-response behavior.  *)
