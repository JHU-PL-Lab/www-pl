(*

PoPL Assignment 4B Question 2
 
Your Name : 
Your Collaborators if any : 

 *)

(* 2a. *)

(* See the HW for the details - fill in your FbReL point and color point classes code below. *)

let pointClass = "(0 1)";;

(* Here is an example of exactly how your code should run - don't edit the below.
   Notice how you need to pass in the initial values of the point, this is like the lecture
   version and not in the book. *)
  
let pointExample1 = "Let p = ("^pointClass^") 2 3 In p.magnitude p {}";;
(* should return 5 - just add up the x/y in this simplified version *)
let pointExample2 = "Let p = ("^pointClass^") 2 3 In p.iszero p {}";; (* should return False *)

(* Now for Color Points *)

let colorPointClass = "(0 1)";;

(* And here are some examples of how your color point should run.  *)
  
let colorPointExample1 =
  "Let cp = ("^colorPointClass^") 2 3 {r=3;g=5;b=3} In cp.brightness cp {}";;
(* should return 11 -- this over-simplified brightness just adds the r/g/b *)

let colorPointExample1 =
  "Let cp = ("^colorPointClass^") 2 3 {r=3;g=5;b=3} In cp.magnitude cp {}";;
(* should return 16 - just add brightness to magnitude but make sure your actual
 code invokes super for previous magnitude, like in the lecture/book.
 We will check your actual code, don't rely only on our tests passing *)

let colorPointExample2 =
  "Let cp = ("^colorPointClass^") 2 3 {r=3;g=5;b=3} In cp.iszero cp {}";;
(* should return False *)

(* 2b. *)

(* Consider the following FbV program:

Let var_zero = `zero(3) In 
Let var_one = `one(4) In 
Let matcher = Fun v -> Match v With `zero(x) -> x - 1 | `one(x) -> x + 1 In
Let do_match = Fun va -> Fun ma -> ma va In do_match var_one matcher

which should return 5.  We made the matcher a function and isolated a function to do the match
to line up with how you will encode this example.

For this question, write out FbRe versions of each of the lines above.
*)

let encoded_var_zero = "(0 1)"  (* replace with manual encoding of `zero(3) in FbRe *)
let encoded_var_one = "(0 1)"  (* replace with manual encoding of `one(4) in FbRe *)

let encoded_matcher = "Fun v -> (0 1)"  (* replace with manual encoding of matcher fn in FbRe *)
let encoded_do_match = "Fun va -> Fun ma -> (0 1)"  (* replace with manual encoding of do_match in FbRe *)

(* Here is a test that should exercise your encoding, it should return 5. *)
                      
let test_encoding =
  "Let ve = ("^encoded_var_one^") In Let ma = ("^encoded_matcher
    ^") In Let dm = ("^encoded_do_match^") In dm ve ma"
  
(* 2c. *)

(* Consider the following non-FbV program:

Let var_zero = `zero(3) In 
Let var_one = `one(4) In 
Let match_zero = Fun v -> Match v With `zero(x) -> x - 1
Let match_one = Fun v -> Match v With `one(x) -> x + 1 In
Let append_do_match = Fun va -> Fun m0 -> Fun m1 -> (m0 va) | (m1 va) In
 append_do_match var_zero match_zero match_one

This program is using "|" to APPEND two match clauses together -- thats not possible!

But, since our encoding in FbRe also includes record appending we can in fact encode something like this, we can append match cases together by appending records with +.  The effect of such an append is to first try to match the first clauses, and if that fails try the second ones.  This is in fact easy to encode with record append.  Fill in the following to show how this is done.

*)

(* .. encodings of `zero and `one should not need to change .. *)

let encoded_match_zero = "(0 1)"  (* replace with manual encoding of match_zero in FbRe *)
let encoded_match_one = "(0 1)"  (* replace with manual encoding of match_one in FbRe *)
let encoded_append_do_match = "Fun va -> Fun m0 -> Fun m1 -> (0 1)"  (* replace with manual encoding of append_match in FbRe.  It must use + to append applied m0/m1 and build a combined match from the two input matches. If you are repeating some code for match_zero and match_one here you are failing to answer the question, it should merge any two match clauses.  *)

(* Here is a test that should exercise your encoding, it should return 2. *)

let test_merge_encoding =
  "Let ve = ("^encoded_var_zero^
  ") In Let m0 = ("^encoded_match_zero^
  ") In Let m1 = ("^encoded_match_one^
  ") In Let am = ("^encoded_append_do_match^
  ") In am ve m0 m1"
  

(* Note that for 2b and 2c it is trivial to defeat an auto-grader, please don't do that.
   We will also be manually verifying them. *)
  
