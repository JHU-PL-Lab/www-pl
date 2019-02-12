(*

PoPL Assignment 2

Name                  :
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems
with here, as per the course academic integrity policy. TA/CA/Prof need not be
listed.

Fill in the function definitions below replacing the

  failwith "Not Implemented";; 
  or ();;

with your code.  In some cases, you may find it helpful to define auxillary
functions, feel free to.  Other than replacing the failwiths and adding recs,
don't edit or remove anything else in the file -- the autograder will not be
happy! You cannot use any mutation (arrays, :=, or any mutable data structure)
on this homework unless explicitly allowed (Q3 only). You can use core library functions
such as List.map that are not mutating. Note that the Queue, Stack, and Hashtbl
modules are mutating so you are not allowed to use them. *)


(* ****************************** Question 1 ****************************** *)
(* ************************ The Game of Types ***************************** *)

(*

For this problem, you must produce an expression which has a given type.  It
does not matter what expression you provide as long as it has that type; there
may be numerous (or even infinite) answers for each question.  Your answer may
*not* produce a compiler warning.  You are *not* permitted to use explicit type
annotations using ":" (such as "fun x:'a -> x").  Also please do not use any
libraries for this question such as List.map etc. You *may* use mutable state to
define x1.

 *)

let x1 = ();;

(* val x1 : 'a -> unit *)

let x2 = ();;

(* val x2 : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b *)

let x3 = ();;

(* val x3 : ('a -> 'b) option -> 'a ref -> 'b list *)

let x4 = ();;

(* val x4 : 'a x_role -> 'a * 'a  (* note you will need to declare type x_role for this one *) *)

let x5 = ();;

(* val x5 : 'a * ('a -> 'b) * (('a -> 'b) -> 'c) -> 'c * 'b *)

let x6 = ();;

(* val x6 : 'a -> 'b option *)

(* ****************************** Question 2 ****************************** *)
(* ****************************** List Fun ******************************** *)


(* Lets have fun with lists of functions.  Write a function mega_map which takes a
   list of functions and another list of integers the same length, and returns a list 
   containing the application of the first function to the first element, second function
   applied to the second element, etc.

   When the lengths of the lists don't match, the function should raise an exception.
*)

let rec mega_map funs ints =  failwith "Not Implemented";;

(*
    assert (mega_map [(fun y -> (y - 5) * 3); (fun x -> x - 4);(fun x -> x + 8)] [10;11;20] = [15; 7; 28]);;
    assert (mega_map [(fun y -> (y - 5) * 3); (fun x -> x - 4)] [10; 11] = [15; 7]);;

    (mega_map [(fun y -> (y - 5) * 3); (fun x -> x - 4)] [10; 11] = [15; 7]);;
     =>
          Exception: Failure "list lengths don't match"
*)


(* In lecture we re-implemented OCaml lists, lets repeat that here and then 
   code mega_map in these homebrew lists. *)

type 'a homebrew_list_t = 
  | Nil
  | Cons of 'a * 'a homebrew_list_t;;


(* OK lets write convertors between our lists and OCamls lists *)

(* First take an OCaml list and make the corresponding homebrew list *)

let homebrew_of_list list = failwith "Not Implemented";;

(* Now take a homebrew list and make the corresponding OCaml list *)

let list_of_homebrew homebrew = failwith "Not Implemented";;

(* (* These conversions should define an isomorphism, lets check: *)
   assert (list_of_homebrew(homebrew_of_list [1;5;2;8;3;1;10]) = [1;5;2;8;3;1;10])
*)

(* Now re-implement mega_map using homebrew lists.  There is an easy answer using the 
   above convertor functions but for the experience please code this one from scratch 
   -- don't invoke your mega_map above in your answer or paste the exact same code here etc.
*)

let h_mega_map h_fun_list h_arg_list = failwith "Not Implemented";;


(* ****************************** Question 2 ****************************** *)
(* ************************** Infinite List Fun *************************** *)


(* Sometimes it is convenient to program with "infinite" lists, e.g.

  [1; 2; 3; 4;...]
  [1; 1; 2; 3; 5; 8; ...]
  ["yes"; "yes"; ...]

  Its obviously not really infinite, it is "lazy" -- it won't compute a value in the list
  until you explicitly ask for it.  Such lists are often called *streams*.

  In Haskell the lists are by default lazy, but in OCaml we need to do a bit of work.

  Here is a type definition for streams in OCaml.  
  Compare the type definition of `homebrew_list_t` above with `stream_t`.

*)

type 'a stream_t = 
  | End
  | Next of 'a * (unit -> 'a stream_t);;

(* Notice how the tail is a **function** -- you need to explicitly call the function (with ())
   to get the tail value. Here are some finite lists in this notation. *)

let one_one = Next(1, fun _ -> End);;
let two_ones = Next(1, fun _ -> one_one);;
let three_ones = Next(1, fun _ -> two_ones);;

(* Now, write an infinite stream of ones.  Hint: use `let rec` *)

let infinite_ones = ();;

(* Write a function which makes an infinite stream of a particular constant value *)

let make_const_stream c = failwith "Not Implemented";;

(* One more stream: the Fibonnaci numbers ! *)

let fibonacci_stream = ();;

(* assert ((stream_nth fibonacci_stream 5) = 8) *)(* Write a function to get the head of the stream, raise an exception if its End *)

let stream_hd s = failwith "Not Implemented";;

(* Write a function to get the tail function of the stream, again raise exception if End *)

let stream_tl s = failwith "Not Implemented";;

(* Write a function to get the nth element of the stream: stream_nth s 5 gives 5th elt *)
(* Note we start counting from 0 here; also again raise exception if out of bounds *)

let stream_nth s n= failwith "Not Implemented";;

(* Re-implement the mega_map function above with stream_t; f_list here is still an OCaml list 
   Note that the stream need not end, you are only converting as far as you have functions to. *)

(* 
  let id x = x;;
  let yes = make_const_stream "yes";;
  assert (mega_map_stream [id; id; id] yes = ["yes"; "yes"; "yes"]);;
  assert (mega_map_stream [(fun s -> s ^ "!"); (fun s -> s^", "^s^"!")] yes =  ["yes!"; "yes,yes!"]);;
 
*)



(* ****************************** Question 3 ****************************** *)
(* ********************* Infinitely Changing List Fun ********************* *)

(* One more round with lists.. for this question you are to create your
   own mutable lists: lists for which you can change element values.
   You will need to make your own type for this question, and supply some 
   conversion functions so we can test your code.

   Note that you can't mutate the length of these lists, only individual elements. 

   Also please don't use OCaml arrays here *)

type 'a m_list = MNil (* | ... keep MNil, fill in the rest! *)

(* Convert an OCaml (built-in, functional) list to your m_list *)
  
let mlist_of_list list = failwith "Not Implemented";;

(* Now the other way around *)

let list_of_mlist homebrew = failwith "Not Implemented";;

(* Since we have a mutable list finally, lets use it! 
   Write a function mutate_list mlist n v which replaces the nth element 
   of mlist with val.  The first list element is #0 *)

let mutate_list mlist n v = failwith "Not Implemented";;

(* let m_eg = mlist_of_list [1;5;2;5;2;1;6;5;3] in
   assert(list_of_mlist(mutate_list m_eg 4 99) = [1;5;2;5;99;1;6;5;3])
*)


(* ****************************** Problem 4 ***************************** *)
(* ************************** Fun with JSON  **************************** *)

(* For this question you will write some basic JSON data manipulation functions.
OCaml in fact comes with a module to do this, but to get some experience with
tree data we are going to start from the ground up here. If you are not familiar
with JSON it is a simple string format for writing structured data which looks a
lot like JavaScript syntax.  Here is a tutorial with some examples:
 
  https://www.elated.com/articles/json-basics/

 *)

(* Please use the following OCaml type for your JSON data. *)

type json =
  | Assoc of (string * json) list
  | Bool of bool
  | Float of float
  | Int of int
  | List of json list
  | Null
  | String of string
;;

(*

Write a function string_of_json to convert any OCaml json data item into a legal
JSON string. If you want to verify your string output is valid JSON you can use
a tool like http://jsonlint.com.

Note that whitespace between tokens is irrelevant. That means, the following are
all equivalent:

    {"grades":[90,95,88],"undergrad":false}

    {"grades": [90, 95, 88], "undergrad": false}

    {
        "grades": [
            90,
            95,
            88
        ],
        "undergrad": false
    }

We will be ignoring this whitespace when we test this function. Feel free to
include any whitespace in the output you need to make debugging easier.

Note that JSON has some rules for escape sequences in strings (that is, ways of
expressing control characters, the quote character itself, and other characters
which you may not want to verbatim include in your JSON). For example, "\n" in
a string is JSON that contains a newline character. Another way of representing
this is "\u000A". You do not need to worry about this (unless you want the
extra challenge!). We will only be testing you on strings that contain ASCII
characters excluding control characters (newline and friends), the blackslash,
or double quotes.
*)


let string_of_json jsn = failwith "Not Implemented";;

(*

  assert(string_of_json(Assoc[]) = "{}");;

  let person = Assoc([
    ("id", Int(42));
    ("attributes", Assoc([
        ("name", String("John"));
        ("age", Int(80));
        ("gender", String("male"))
    ]));
    ("favorite-colors", List([
        String("red");
        String("blue")
    ]));
    ("rating",Float(4.5))
]);;

 assert(string_of_json person = "{\"id\":42,\"attributes\":{\"name\":\"John\",\"age\":80,\"gender\":\"male\"},
     \"favorite-colors\":[\"red\",\"blue\"],\"rating\":4.5}");;

*)

(*

Write a function to look up a particular field's value in a OCaml json object.
The function should return the OCaml json object that is the value. This
function only needs to work on json data that at the top level is an Assoc.
Invoke invalid_arg in other cases. Additionally, invoke invalid_arg if key
s isn't one of the keys in the top level Assoc. *)

let lookup jsn s = failwith "Not Implemented";;

(*

  assert(lookup person "id" = Int(42));;

  assert(lookup person "attributes" = Assoc([("name", String("John"));("age", Int(80));("gender", String("male"))]));;

  lookup person "name" ;;
  (* Exception: Invalid_argument "key not found". *)

  lookup (String "Lambda") "id" ;;
  (* Exception: Invalid_argument "Assoc not top level". *)

*)


(*

   Write a function to deeply look up a particular field's value in a
   OCaml json object. This will look for the named field arbitrarily
   deeply inside of any Assoc, e.g. Assocs within Assocs and Assocs
   within Lists.

   This function only needs to work on JSON data that at the top level
   is an Assoc or a List. Invoke invalid_arg in other
   cases. Additionally, invoke invalid_arg if key s isn't one of the
   keys in any of the Assoc's in jsn.  You should traverse Assoc's and
   List's in depth-first order, returning the first value that matches
   the key being search for.  *)


let deep_lookup jsn s = failwith "Not Implemented";;

(*

let person2 = Assoc([
    ("id", Int(42));
    ("attributes", Assoc([
        ("name", String("John"));
        ("age", Int(80));
        ("gender", String("male"))
    ]));
    ("school", Assoc([
        ("name", String("Johns Hopkins"));
        ("city", String("Baltimore"))
    ]));
    ("favorite-colors", List([
        Assoc([
            ("name", String("red"));
            ("rgb", List([Int(255); Int(0); Int(0)]))
        ]);
        Assoc([
            ("name", String("blue"));
            ("rgb", List([Int(0); Int(0); Int(255)]))
        ])
    ]));
    ("rating", Float(4.5))
]) ;;

  assert(deep_lookup person2 "id" = Int(42));;

  assert(deep_lookup person2 "name" = String("John"));;

  assert(deep_lookup person2 "rgb" = List([Int(255); Int(0); Int(0)]));;

  deep_lookup person2 "state" ;;
  (* Exception: Invalid_argument "key not found". *)

  deep_lookup (String "Lambda") "id" ;;
  (* Exception: Invalid_argument "Assoc or List not top level". *)

*)


(*

Write a function json_filter to deeply filter out (remove) any Assoc fields
whose names match a filter predicate supplied by the user, filter : string ->
bool. The json object should be idential other than the indicated fields being
removed.

As with deep_lookup, json_filter should traverse into both Assoc's and List's.
Calling the function with a json value that isn't either should return the
value unchanged.
*)

let json_filter jsn filter = failwith "Not Implemented";;

(*

  assert(json_filter person2 (fun x -> x = "name") = 
    Assoc([
    ("id", Int(42));
    ("attributes", Assoc([
        ("age", Int(80));
        ("gender", String("male"))
    ]));
    ("school", Assoc([
        ("city", String("Baltimore"))
    ]));
    ("favorite-colors", List([
        Assoc([
            ("rgb", List([Int(255); Int(0); Int(0)]))
        ]);
        Assoc([
            ("rgb", List([Int(0); Int(0); Int(255)]))
        ])
    ]));
    ("rating", Float(4.5))
    ]));;

  assert(json_filter (Int 10) (fun x -> true) = Int(10));;

*)

(* ****************************** Problem 5 ***************************** *)
(* ******************************* json.ml  ***************************** *)

(* 

Port your JSON library above to a module: make a file json.ml which is a
standalone module implementation of the json type, and the four functions
defined above (just copy your final code into that file, you are submitting two
versions of the same question answer).

We will test it by #load-ing your compiled module into the top loop and invoking
it using OCaml module syntax:

#load "json.cmo";;
Json.string_of_json ...

You should test your module that way as well just to be sure it is working correctly.

Reference: recall that at the end of lecture.ml we reviewed how to do file-based compilation.  Here is a remark from that file that bears repeating:

   See http://pl.cs.jhu.edu/pl/ocaml/code/sep.zip for the example we cover in lecture.
   We will follow http://pl.cs.jhu.edu/pl/ocaml/code/sep_compile/readme.txt in particular.
   See the ocaml manual Chapter 8 for the full documentation

The above readme.txt we did not explicitly look at in lecture but we went through the
steps.

*)
