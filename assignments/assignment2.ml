(*

PoPL Assignment 2

Name                  :
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems
with here, as per the course academic integrity policy. TA/CA/Prof need not be
listed.

Fill in the function definitions below replacing the

  failwith "Not Implemented"

with your code.  In some cases, you may find it helpful to define auxillary
functions, feel free to.  Other than replacing the failwiths and adding recs,
don't edit or remove anything else in the file -- the autograder will not be
happy! You cannot use any mutation (arrays, :=, or any mutable data structure)
on this homework unless explicitly allowed. You can use core library functions
such as List.map that are not mutating. Note that the Queue, Stack, and Hashtbl
modules are mutating so you are not allowed to use them. *)


(* ****************************** Problem 1 ****************************** *)
(* ************************ The Game of Types **************************** *)

(*

For this problem, you must produce an expression which has a given type.  It
does not matter what expression you provide as long as it has that type; there
may be numerous (or even infinite) answers for each question.  Your answer may
*not* produce a compiler warning.  You are *not* permitted to use explicit type
annotations using ":" (such as "fun x:'a -> x").  Also please do not use any
libraries for this question such as List.map etc. You *may* use mutable state to
define x1.

[20 Points]

 *)

let x1 = failwith "Not Implemented"

(* val x1 : int list ref = ... *)

let x2 = failwith "Not Implemented"

(* val x2 : 'a -> ('a -> 'b) -> 'b = ... *)

let x3 = failwith "Not Implemented"

(* val x3 : unit -> unit = ... *)

let x4 = failwith "Not Implemented"

(* val x4 : 'a list -> 'a array -> 'a = ... *)

let x5 = failwith "Not Implemented"

(* val x5 : 'a list -> 'b list list -> ('a * 'b) list = ... *)

let x6 = failwith "Not Implemented"

(* val x6 :  ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c = ... *)

let x7 = failwith "Not Implemented"

(* val x7 : 'a -> 'b = ... *)

type ('a, 'b) stuff = Stu of 'a | Uff of 'b ;;

let x8 = failwith "Not Implemented"
    
(* val x8 : ('a, 'b) stuff list -> (unit -> 'c) -> ('b, 'c) stuff list  = ... *)

(* ****************************** Problem 2 ****************************** *)
(* ***************************** Trie Again ****************************** *)

(* One reasonably efficient way to store sets of strings or maps with
   string keys is by using a trie data structure
   (https://en.wikipedia.org/wiki/Trie). A trie is a tree structure
   whose edges are labeled with the elements of the alphabet. Each
   node in the tree corresponds to the sequence of alphabet elements
   traversed on the path from the root to that node. When used as a map,
   nodes that correspond to keys of the map store an additional value.

   For example, this picture based on the example in the above
   Wikipedia article:

          [ ]
      t /  |  \ i
       /  A|   \
      v    v    v
    [ ]   [15]  [11]
  o / \ e         \ n
   /   \           \
  v     v           v
[7]    [ ]          [5]
    a / | \ n    n /
     / d|  \      /
    v   v   v    v
   [3] [4] [12] [9]

   represents a map:

   { to => 7, tea => 3, ted => 4, ten => 12, A => 15, i => 11, in =>
   5, inn => 9 }.

   A couple of points to note:

   a. A typical trie does not actually store the full key at each node
   as the picture appears to show. This is not needed since the path
   to the node encodes the key.

   b. The "inner" nodes (node "t" and node "te") are not part of the
   map since they do not have values associated with them.


   For this question you will write some basic functions to manipulate trie 
   data structures.

   We will use OCamls option types, here is a brief description as we did not cover
   them in lecture. The built-in 'a option type is the type
     Some of 'a | None
   Some(3), or None for example are elements of the type int option.  Option
   types are very useful for functions that may or may not return interesting 
   results, depending on some condition. 

   We will use the following data type for a trie:

*)

type 'a trie = Node of 'a option * (char * 'a trie) list ;; 

(* In the above definition, the type variable 'a represents the value
   stored at a node (which is optional). Thus a node of the trie
   consists of an optional value and a list of (character - subtrie
   pairs).

  The ocaml output for tries you construct is generally readable. But for when it is not, 
  here is a pretty printer you are free to use:
  
  let print_tree value_converter (Node(v, lst)) = 
    let rec print_node_impl (c, (Node(v, lst))) indent = 
      Printf.printf "%s%c => %s\n" indent c 
          (match v with None -> "None" | Some v -> value_converter v) ;
      List.iter (fun v -> print_node_impl v (indent ^ "  ")) lst
   in
    print_string "ROOT\n" ;
    List.iter (fun n -> print_node_impl n "  ") lst
    
  
   To call this function, you must supply a converter function that can map the values 
   stored in a node to a string.  For a trie with integer values, you call it like so: 

    print_tree string_of_int the_trie_you_want_to_print
*)

(* 2a. [10 Points]

   Given a trie, a string key and a value, write a function that
   returns a new trie that contains the key value pair.

*)
let rec add_to_trie trie str value = failwith "Not Implemented";;
  
(*  
# let root = Node(None, []) ;;  
# let trie_1_n1 = add_to_trie (Node(None, [])) "to" 7 ;;
val trie_1_n1 : int trie =
  Node (None, [('t', Node (None, [('o', Node (Some 7, []))]))])
# let trie_1_n2 = add_to_trie trie_1_n1 "tea" 3 ;;
val trie_1_n2 : int trie =
  Node (None,
   [('t',
     Node (None,
      [('o', Node (Some 7, []));
       ('e', Node (None, [('a', Node (Some 3, []))]))]))])
# let trie_1 = List.fold_left (fun trie -> fun (str, v) -> add_to_trie trie str v) root
  [("to", 7); ("tea", 3); ("ted", 4); ("ten", 12); ("A", 15); ("i", 11); ("in", 5); ("inn", 9)] ;;
val trie_1 : int trie =
  Node (None,
   [('t',
     Node (None,
      [('o', Node (Some 7, []));
       ('e',
        Node (None,
         [('a', Node (Some 3, [])); ('d', Node (Some 4, []));
          ('n', Node (Some 12, []))]))]));
    ('A', Node (Some 15, []));
    ('i', Node (Some 11, [('n', Node (Some 5, [('n', Node (Some 9, []))]))]))])
*)

(* 2b. [10 Points]

  Given a trie and a key, fetch the value corresponding to the key if
   it exists.  The return value should be an option type. If the key
   does not exist in the map, return None.  *)

let rec get_value_from_trie trie key = failwith "Not Implemented";;

(*
# get_value_from_trie trie_1 "tea" ;;
- : int option = Some 3
# get_value_from_trie trie_1 "inn" ;;
- : int option = Some 9
*)


(* ****************************** Problem 3 ****************************** *)
(* ************************* Chow-Down, Mutably ************************** *)

(*

3a. [10 points]

   For this question you can use the built-in state of OCaml: ref, :=,
   arrays, and records with mutable fields. You can also use stateful
   standard library data structures if you so choose.

   You are a chef, and your kitchen needs to stock four kinds of
   ingredients. You are to implement a very simple stock data
   structure. You can make a new stock, add an ingredient to the
   stock, remove an ingredient from the stock, and return counts of
   the current stock.

   Here is the simple stock item data structure you are to use: *)

type item = Tomato | Lettuce | Patty | Bun

(* This function should return a new (mutable) stock structure. *)

let make_stock () = failwith "Not Implemented"

(* This function should add a new item i to a stock. It should
   just return () since all it is doing is a side-effect. 
*)

let add_item s i = failwith "Not Implemented"

(* This function should remove one item i from the stock. It
   should just return () since all it is doing is a side-effect. It
   should raise an exception if a non-existent item is removed.  *)
    
let remove_item s i = failwith "Not Implemented"

(* This function should count the number of items i in the stock *)

let count_item s i = failwith "Not Implemented"

(*
# let s = make_stock ();;
...

# count_item s Tomato;;
- : int = 0

# add_item s Tomato;;
- : unit = ()

# count_item s Tomato;;
- : int = 1

# add_item s Tomato;;
- : unit = ()

# remove_item s Tomato;;
- : unit = ()

# remove_item s Tomato;;
- : unit = ()

# count_item s Tomato;;
- : int = 0

# remove_item s Tomato;;
Exception: ...
*)

(* 
3b. [5 points] 

OK, now lets cook!

The chef can make four kinds of burgers:
 - a FullBurger, which needs one Tomato, one Lettuce, one Patty, and one Bun
 - a DoubleBurger, which needs two Tomatoes, two Lettuce, two Patties, and one Bun
 - a VeggieBurger, which needs one Tomato, one Lettuce, and one Bun
 - a NothingBurger, which needs only one Bun.

 *)

type burgerKind = FullBurger | DoubleBurger | VeggieBurger | NothingBurger

(* This function should return () if the stock permits that kind of
   burger to be made. Raise an exception if the stock is short of any
   ingredient.  If a Burger can be successfully made, you should
   consume (remove) the associated ingredients from the stock. Don't
   remove any ingredients if some of the ingredients for the
   burger are missing. *)

let cook s bk = failwith "Not Implemented"

(*
# let s = make_stock ();;
...

# add_item s Tomato;;
- : unit = ()

# add_item s Lettuce;;
- : unit = ()

# cook s VeggieBurger;;
Exception: Insufficent_Ingredient

# add_item s Bun;;
- : unit = ()

# cook s VeggieBurger;;
- : unit = ()

# count_item s Bun;;
- : int = 0
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

(* 4a. [5 points]

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

# string_of_json(Assoc[]);;
- : string "{}"

# let person = Assoc([
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
]) ;;
val person : json = ...

# string_of_json person ;;
- : string = "{\"id\":42,\"attributes\":{\"name\":\"John\",\"age\":80,\"gender\":\"male\"},\"favorite-colors\":[\"red\",\"blue\"],\"rating\":4.5}"

*)

(* 4b. [10 points]

Write a function to look up a particular field's value in a OCaml json object.
The function should return the OCaml json object that is the value. This
function only needs to work on json data that at the top level is an Assoc.
Invoke invalid_arg in other cases. Additionally, invoke invalid_arg if key
s isn't one of the keys in the top level Assoc. *)

let lookup jsn s = failwith "Not Implemented";;

(*

# let person = Assoc([
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
    ("rating", Float(4.5))
]) ;;
val person : json = ...

# lookup person "id" ;;
- : json = Int(42)

# lookup person "attributes" ;;
- : json = Assoc([("name", String("John"));("age", Int(80));("gender", String("male"))])

# lookup person "name" ;;
Exception: Invalid_argument "key not found".

# lookup (String "Lambda") "id" ;;
Exception: Invalid_argument "Assoc not top level".

*)


(* 4c. [10 points]

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

# let person = Assoc([
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
val person : json = ...

# deep_lookup person "id" ;;
- : json = Int(42)

# deep_lookup person "name" ;;
- : json = String("John")

# deep_lookup person "rgb" ;;
- : json = List([Int(255); Int(0); Int(0)])

# deep_lookup person "state" ;;
Exception: Invalid_argument "key not found".

# deep_lookup (String "Lambda") "id" ;;
Exception: Invalid_argument "Assoc or List not top level".

*)


(* 4d. [10 points]

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

# let person = Assoc([
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
val person : json = ...

# json_filter person (fun x -> x = "name") ;;
- : json = Assoc([
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
])

# json_filter (Int 10) (fun x -> true) ;;
- : json = Int(10)

*)


(* 4e. [10 points]

Port your JSON library above to a module: make a file json.ml which is a
standalone module implementation of the json type, and the four functions
defined above (just copy your final code into that file, you are submitting two
versions of the same question answer).

We will test it by #load-ing your compiled module into the top loop and invoking
it using OCaml module syntax:

#load "json.cmo";;
Json.string_of_json ...

You probably want to test your module that way as well just to be sure it is working correctly.

*)
