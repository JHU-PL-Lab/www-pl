(*

PoPL Assignment 4B Question 2
 
Your Name             : 

 *)

(* 2a. *)

(* See the HW for the details - fill in your FbVPL point class code below. *)

let pointClass = "(0 1)";;

(* Here is an example of exactly how your code should run - don't edit the below.
   Notice how we are also using the pairs of FbVPL to pass in the initial point coords. *)
  
let pointExample1 = "Let p = ("^pointClass^")(2,3) In p p (`magnitude(0))";; (* should return 13 *)
let pointExample2 = "Let p = ("^pointClass^")(2,3) In p p (`iszero(0))";; (* should return False *)


  
(* 2b. *)

let send (ob,msg) = "0 1"  (* replace with macro *)

(* Here is a test that should work exactly as written below with no editing *)
                      
let messengerTest = "Let p = ("^pointClass^")(1,2) In ("^send("p","`iszero(0)")^")";; (* False *)
  
  
