(* Template for assignment 6 

   Your submitted file should ONLY define these two strings.  
   The commented-out code is what you can un-comment to test,  just re-comment before submitting.  *)

(* The following code is designed to run in OCaml with AFbV interpreter loaded *)
(* #cd "........./FbDK/src/AFbV");; *)
(* #use "fbdktoploop.ml";; *)

(* uncomment the following to see the actor system as it steps *)
(* Afbvoptions.set_debug(true);; *)

let tick = "0 1";; (* Replace with tick's behavior *)
let sumtick = "0 1";; (* Replace with sumtick's behavior *)

(* test of the above 
let expr = "
    Let tick = ("^tick^") In
    Let sumtick = ("^sumtick^") In
    Let tick1 = Create(tick, 0) In
    Let tick2 = Create(tick, 0) In
    Let sumtick1 = Create(sumtick, (tick1,tick2)) In
    Let sumtick2 = Create(sumtick, (tick1,tick2)) In
    (sumtick1 <- `sumtick 0);
    (sumtick2 <- `sumtick 0);  (sumtick2 <- `sumtick 0)";;
 *)
  
(* should print three different sums, one for each sumtick call above:

rep expr ;; *)  

(* Note beyond this test we will be individually testing your tick and sumtick behaviors 
   to make sure they conform to spec. *)  
