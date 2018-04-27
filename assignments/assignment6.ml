(* Template for assignment 6 

   Your submitted file should ONLY define two strings.  
   
   The commented-out code is what you can un-comment to test, 
   just re-comment before submitting.  *)

let boom = "0 1";; (* Replace with boom's behavior *)
let boomboom = "0 1";; (* Replace with boomboom's behavior *)

(* The following test code is designed to run in OCaml with AFbV interpreter loaded: *)

(* #cd "..inter-path-to-fbdk-here../fbdk/");; *)
(* #use "debugscript/afbv.ml";; *)

(* Uncomment the following to see the actor messages and/or actor states as it steps.
   Note we recently changed the FbDK so you will need to download the latest version for these options to work *)
(* Afbvoptions.show_messages := true;; *)
(* Afbvoptions.show_states := true;; *)

(* If you are using the updated standalone interpreter to test your programs, these are command-line flags which achieve the same effect:

   ocamlrun afbv.byte --show-messages --show-states *)

(* 
let expr = "
    Let boom = ("^boom^") In
    Let boomboom = ("^boomboom^") In
    Let boom1 = Create(boom, 2) In
    Let boom2 = Create(boom, 2) In
    Let boomboom = Create(boomboom, (boom1,boom2)) In
    (boomboom <- `boomboom 0)";;
 *)
  
(* should print Synched! 2 times and then print PFFFFFFFT! :

rep expr ;; *)  

(* Keep this test expr and rep line commented out as well in your final submission. *)

(* Note we will be testing your boom and boomboom behaviors to make sure they fully conform to the spec. *)  

(* Note AfbV additionally includes syntax for pairs and lists, e.g. 

# Fst(Snd(3,(4,5)));;
==> 4

We are using the pair syntax in the constructor invocation above.

*)
