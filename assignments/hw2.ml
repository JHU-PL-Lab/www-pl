(*
  600.426 - Programming Languages
  JHU Spring 2012
  Homework 2

  In this source file, you will find a number of comments containing the text
  "ANSWER".  Each of these comments indicates a portion of the source code you
  must fill in yourself.  You are welcome to include other functions for use in
  your answers.  Read the instructions for each problem and supply a segment of
  code which accomplishes the indicated task.  For your convenience, a number of
  test expressions are provided for each problem as well as a description of
  their expected values.

  In this assignment, you are permitted to complete the listed tasks using any
  of the OCaml modules/functions.  However you are still required to avoid the use of
  mutation unless explicitly specified in the question.
*)

(* -------------------------------------------------------------------------------------------------- *)
(* HEADER: PLEASE FILL THIS IN                                                                        *)
(* -------------------------------------------------------------------------------------------------- *)

(*

Name                  :
List of Collaborators :

Please make a good faith effort at listing people you discussed any problems with here, as per the
course academic integrity policy.  TA/CA/Prof need not be listed.
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 1 : A Game of Types                                                                        *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  1. For the next several problems, you will be asked to produce an expression which
     has a given type.  It does not matter what expression you provide as long as it
     has that type; there may be numerous (or even infinite) answers for each
     question.  Your answer may *not* produce a compiler warning.  You are *not*
     permitted to use explicit type annotations (such as "fun x:'a -> x").

     [25 Points]
*) 

(* Give an expression which has the following type: int ref list *)
let exp1 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a -> ('a -> 'b) -> 'b *)
let exp2 = ();; (* ANSWER *)

(* Give an expression which has the following type: ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c *)
let exp3 = ();; (* ANSWER *)

(* Give an expression which has the following type: ('a -> 'b) -> ('c -> 'd) -> 'a * 'c -> 'b * 'd *)
let exp4 = ();; (* ANSWER *)

(* Give an expression which has the following type: ('a -> 'b) -> ('a -> 'c) -> 'a -> 'b * 'c *)
let exp5 = ();; (* ANSWER *)

(* Give an expression which has the following type: 'a list -> int -> 'a *)
let exp6 = ();; (* ANSWER *)

(* Give an expression which has the following type: int -> (int -> 'a) -> 'a list *)
let exp7 = ();; (* ANSWER *)

(* Give an expression which has the following type: ('a -> 'b option) -> 'a list -> 'b list *)
let exp8 = ();; (* ANSWER *)

(* Give an expression which has the following type: unit -> 'a *)
let exp9 = ();; (* ANSWER *)

type ('a, 'b) sometype = Foo of 'a | Bar of 'b ;;

(* Give an expression which has the following type:
   ('a * 'b) list -> ('a -> 'b -> 'c) -> ('d, 'c) sometype list *)
let exp10 = ();; (* ANSWER *)


(* -------------------------------------------------------------------------------------------------- *)
(* Section 2 : Making Modules, Using Modules                                                          *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  2a. Create a simple stack class that has the following methods:
      * emptystack : unit -> 'a stack         - The method returns a *new* empty stack instance
      * push : 'a -> 'a stack -> 'a stack     - Push a new value on to the stack and return the new stack 
      * top : 'a stack -> 'a option           - Return the value at the top of the stack if there is one.
      * pop : 'a stack -> 'a stack            - Pop the top value off the stack and return the new stack. If the 
                                                stack is empty, throw an exception (use invalid_arg)
      * is_empty : 'a stack -> bool           - Returns true if the stack is empty, otherwise false
    
      In the section below, fill out the signature and the implementation details. You must explicitly leave any
      types in the signature abstract. (This is good practice in the software engineering sense. By not explicitly
      binding the types on the interface, you allow different implementations to choose types best suited
      for their goals)
    
      NOTE: When you query the type of your functions in the top loop, it might return the fully qualified type signatures.
      E.g: emptystack : unit -> 'a GStack.stack instead of just unit -> 'a stack. This is fine. 
		
      [10 Points]
*)


module type GSTACKTYPE =
  sig
      (* ANSWER *)                      
  end
;;

module GStack : GSTACKTYPE =
  struct
    (* ANSWER *)     
  end
;;
 
(*
# let s = GStack.emptystack () ;;
val s : '_a GStack.stack = <abstr>
# GStack.is_empty s ;;
- : bool = true
# let s = GStack.push 1 s ;;
val s : int GStack.stack = <abstr>
# GStack.top s;;
- : int option = Some 1
# let s = GStack.pop s ;;
val s : int GStack.stack = <abstr>
# GStack.is_empty s ;;
- : bool = true

# let s = GStack.emptystack () ;;
val s : '_a GStack.stack = <abstr>
# let s = GStack.push "Foo" s ;;
val s : string GStack.stack = <abstr>
# let s = GStack.pop s ;;
val s : string GStack.stack = <abstr>
# let s = GStack.pop s ;;
Exception: Invalid_argument "Empty stack".
*)


(*
  2b. Write a simple postfix calculator that operates over integers and floats and supports
      the mathematical operations +, -, * and /.
      
      Numbers are defined as the type "Int of int | Float of float"
      
      The input is expressed as a list of tokens. The numeric and token types are defined below. 
      
      The output should be a number type. When floats and integers occur in the same expression, the result
      should be a float type. i.e. Mul(Float 3.2, Int 2) evaluates to Float(6.4)
      
      If the input is ill-formed, or the computations result in divide by zero error, raise an exception 
      using invalid_arg.
      
      HINT: It is worth considering the design of this function carefully - What are the sub-operations that 
      you want to perform? Can the repetitive code be abstracted away in to functions?. A few well-written 
      utility functions would serve to simplify the problem quite a lot.
			
      [10 Points]
*)

type number = Int of int | Float of float ;;

type token = Number of number | Plus | Minus | Mul | Div ;;


let postfix_calculator tokenlist = () ;; (* ANSWER *)
  
(*
# postfix_calculator [ Number (Int 3) ; Number (Int 5) ; Minus ] ;;
- : number = Int (-2)
# postfix_calculator [ 
  Number (Int 2); Number (Int 3); Number (Int 8); 
  Mul; Plus; Number (Int 4); Number (Int 48);
  Number (Int 4); Number (Int 2); Plus; Div;
  Number (Int 6); Mul; Plus; Minus
] ;;
- : number = Int (-26)
*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 3 : Trees and Directories                                                                  *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  Most file systems offer a classic recursive view of its contents via directories and files. We can 
  define a simplistic file system type as follows:
*)

type filesystemobject = Directory of string * filesystemobject list | File of string * int ;;

(* In the above definition the string will be the name of the object and int the size of the file *)

(*
  3a. Like most regular file systems, let us assume that the name of a filesystemobject is unique within 
      its parent's namespace. This allows us to define unique paths to each object using just the names 
      and a separator. For our purposes we will fix the separator to be the character '/' and assume that 
      this character cannot occur in object names.
  
      All intermediate parts of the path string are guaranteed to be a directory references. The final part
      can refer to a file or a directory object. i.e. For a path string "foo/bar/moo", the names "foo" and
      "bar" are references to directories. The name "moo" can refer to a directory or a file. For 
      simplicity paths never start or end with a separator.
  
      Given the root filesystemobject (guaranteed to be a directory) and a path string, write a function 
      to return the filesystemobject corresponding to the path string. You can assume that the path 
      provided is always relative to the given root.
  
      If an object corresponding to the path is not found, raise an exception via invalid_arg 
  
      [5 Points]
*)

let get_filesystemobject root path = () ;; (* ANSWER *)
 
(*
# let filesystem = 
	  Directory("<ROOT>", [ (* The name doesnt really matter for the root *)
		  Directory("Apps", [
	      Directory("Notes", [
          File("Note.txt", 550) ;
          Directory("600.446", [File("Assignment-2.txt", 150)])
        ]);  
	      Directory("Ode", [File("Ode.exe", 1200); File("Ode.txt", 200)]);
	      File("TODO.txt", 75);
	      File("README", 125)
	    ]) ;
		  Directory("Config", [
	      File(".vimrc", 250);
	      File(".bashrc", 250);
	    ]) ;
		  Directory("Notes", [
	      File("Note1.txt", 100);
	      File("Note2.txt", 120);
	    ])
	  ])
	;;

# get_filesystemobject filesystem "Apps/Ode/Ode.exe" ;;
- : filesystemobject = File ("Ode.exe", 1200)
# get_filesystemobject filesystem "Apps/Notes" ;;
- : filesystemobject =
Directory ("Notes",
 [File ("Note.txt", 550);
  Directory ("600.446", [File ("Assignment-2.txt", 150)])])
# get_filesystemobject filesystem "Apps/Notes/600.446/Assignment-2.txt" ;;
- : filesystemobject = File ("Assignment-2.txt", 150)
# get_filesystemobject filesystem "Config/Apache" ;;
Exception: Not_found.
*)

(*
  3b. Write a function to do the reverse. i.e. Given a filesystemobject and the root
      return the relative path to the object.
  
      [5 Points]
*)

let rec get_path fobj root = () ;; (* ANSWER *)

(*
(* -- Wherein we test whether the universe is circular -- *)

# get_path (get_filesystemobject filesystem "Apps/Ode/Ode.exe") filesystem ;;
- : string = "Apps/Ode/Ode.exe"
# get_path (get_filesystemobject filesystem "Apps/Notes") filesystem ;;
- : string = "Apps/Notes"
# get_path (get_filesystemobject filesystem "Apps/Notes/600.446/Assignment-2.txt") filesystem ;;
- : string = "Apps/Notes/600.446/Assignment-2.txt"
*)
              
(*
  3c. A common operation on trees (including directory trees) is to walk the structure 
      in some order and build up a return value. For example, to compute the total size 
      of files in a directory and its sub-directories, one way would be to walk the tree
      in a bottom-up fashion, computing sizes as we go.
  
      This is such a general concept that it is useful to write a function to help us
      with this.
  
      Given a function f with signature ('a -> filesystemobject -> 'a) and an initial
      value of type 'a, write a function that walks the directory structure in postorder 
      (i.e. Child nodes are processed before parent nodes) and builds a result. 
      
      [5 Points]
*)

let rec process_filesystem_in_postorder f init root = () ;; (* ANSWER *)    

(*
# let filesizesum filelist = List.fold_left (
    fun res -> fun n -> match n with File(name, size) -> res + size | Directory(_, _) -> res
  ) 0 filelist
  ;;
# process_filesystem_in_postorder (
    fun res -> fun n -> match n with 
     | File(_, _)                -> failwith "The processing function should not have been called with a file object"
     | Directory(name, filelist) -> res + (filesizesum filelist)
  ) 0 filesystem
  ;;
- : int = 3020
# module DirSizeMap = Map.Make (struct type t = filesystemobject let compare = Pervasives.compare end) ;;
# let filesizesum_with_map map filelist = List.fold_left (
    fun res -> fun n -> match n with 
      | File(name, size)        -> res + size 
      | Directory(name, _) as d -> res + (DirSizeMap.find d map)
  ) 0 filelist
  ;; 
# let dirsizes = process_filesystem_in_postorder (
    fun dirsizemap -> fun n -> match n with 
     | File(_, _)                     -> failwith "The processing function should not have been called with a file object"
     | Directory(name, filelist) as d -> DirSizeMap.add d (filesizesum_with_map dirsizemap filelist) dirsizemap
  ) DirSizeMap.empty filesystem
  ;;
# DirSizeMap.iter (fun k -> fun v -> match k with 
    | Directory(name, _) -> Printf.printf "%s - %d\n" name v
    | File(_, _)         -> ()
  ) dirsizes
  ;;
600.446 - 150
<ROOT> - 3020
Apps - 2300
Config - 500
Notes - 700
Notes - 220
Ode - 1400
- : unit = ()
*)

(*
  3d. Write a function to find files and directories that match a predicate. If the function
      returns true for a file or directory, it is included in the result. If it returns false
      the file or directory is not included. (Note: If a directory is not included, all its 
      subdirectories are also not included. The entire subtree is pruned)
  
      The result is returned as a new filesystemobject.
  
      Note: The root of the file system cannot go away. Start the filtering operation from
      the children of the provided root. 
  
      [5 Points]
*) 

let rec find_files predicate root = () ;; (* ANSWER *)

(*
-- Only unix hidden files --
          
# find_files (
  fun fobj -> match fobj with File(n, _) -> (String.get n 0) = '.' | Directory(_,_) -> true
) filesystem
;;
- : filesystemobject =
Directory ("<ROOT>",
 [Directory ("Apps",
   [Directory ("Notes", [Directory ("600.446", [])]); Directory ("Ode", [])]);
  Directory ("Config", [File (".vimrc", 250); File (".bashrc", 250)]);
  Directory ("Notes", [])])
  
-- Everything except the Notes directory *directly under* the root is removed --  
 # find_files (
  fun fobj -> match fobj with File(n, _) -> true | Directory(n,_) -> n = "Notes"
) filesystem
;;
- : filesystemobject =
Directory ("<ROOT>",
 [Directory ("Notes", [File ("Note1.txt", 100); File ("Note2.txt", 120)])])
*)


(* -------------------------------------------------------------------------------------------------- *)
(* Section 4 : Graphs                                                                                 *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  Prof. Scott pointed out in class that arbitrary linked structures like graphs cannot be represented 
  as simple variants in OCaml. But you can always come up with indirect representations.
	
  For the purpose of this exercise we represent directed graphs as a combination of:
    a. A list of vertices and
    b. A function which when applied to a specific vertex produces the list of vertices it has an edge to.
*)

type 'a graph = Graph of 'a list * ('a -> 'a list) ;; 


(*
  4a. Write a function to convert an edge list representation of a graph to the above form.
	
	    The edge list is a list of tuples (a, b) such that a and b are vertices and the graph 
	    contains an edge from a to b.
	
	    [5 Points]
*)

let rec graph_from_edgelist elist = () ;; (* ANSWER *)

(*  	
# let graph_1 = graph_from_edgelist [(7,11);(7,8);(5,11);(3,8);(3,10);(11,2);(11,9);(11,10);(8,9)];;
val graph_1 : int graph = Graph ([9; 2; 10; 3; 5; 8; 11; 7], <fun>)
# let Graph(vertices, efn) = graph_1 ;;
val vertices : int list = [9; 2; 10; 3; 5; 8; 11; 7]
val efn : int -> int list = <fun>
# efn 11 ;;
- : int list = [2; 9; 10]
# efn 10 ;;
- : int list = []
*)

(*
  4b. Write a function to determine the shortest path between two specified vertices. The output should
      be the list of vertices along the path.
  
      Note: The graphs we are dealing with are unweighted. So you don't have to use a complex algorithm like
      Dijkstra's. If there are several equal length paths between two vertices, choose any one. If no path is
      found return an empty list
  
      [10 Points]
*)

let rec shortest_path g source target = () ;; (* ANSWER *)          

(*         
# let graph_1 = graph_from_edgelist [('a','b'); ('a','c'); ('b','d');('b','e');('c','f');('c','g')] ;;
# shortest_path graph_1 'a' 'f' ;;
- : char list = ['a'; 'c'; 'f']
# shortest_path graph_1 'b' 'f' ;;
- : char list = []
# let graph_2 = graph_from_edgelist [(1,2);(1,3);(3,4);(4,5);(2,5);(4,6);(5,6);(6,7);(5,7);(7,8);(8,4)] ;;
# shortest_path graph_2 2 8 ;;
- : int list = [2; 5; 7; 8]
# shortest_path graph_2 2 4 ;;
- : int list = [2; 5; 7; 8; 4]
# shortest_path graph_2 2 3 ;;
- : int list = []
*)

(*
  4c. Given a graph, produce a topological ordering of its vertices. You can assume that the graph is
	    directed and acyclic.
	
	    Note: Your function can produce *any* valid topological ordering of the graph. It does not have to
	    look exactly like the examples.
	
	    [10 Points] 
*)
      
let topological_sort g = () ;; (* ANSWER *)

(* 
-- An example from Wikipedia --

# let node_list_1 = [ 2; 3; 5; 7; 8; 9; 10; 11] ;;
# let edgefn_1 node = match node with
	| 7          -> [11 ; 8]
	| 5          -> [11]
	| 3          -> [8 ; 10]
	| 11         -> [2 ; 9; 10]
	| 8          -> [9]
	| 2 | 9 | 10 -> []
	| n          -> invalid_arg "Not a valid node" 
;;
# let graph_1 = Graph(node_list_1, edgefn_1) ;;   
# topological_sort graph_1 ;;
- : int list = [7; 5; 11; 3; 10; 8; 9; 2]

-- Professor Bumstead example from Cormen et.al --
        
# let node_list_2 = ["Pants"; "Belt"; "Undershorts"; "Shirt"; "Tie"; "Jacket"; "Shoes"; "Socks"; "Watch"] ;;
# let edgefn_2 node = match node with
	  | "Shirt"       -> [ "Tie"; "Belt" ]
	  | "Tie"         -> [ "Jacket" ]
	  | "Jacket"      -> []
	  | "Belt"        -> [ "Jacket" ]
	  | "Pants"       -> [ "Shoes"; "Belt" ]
	  | "Undershorts" -> [ "Pants"; "Shoes" ]
	  | "Socks"       -> [ "Shoes" ]
	  | "Watch"       -> []
	  | "Shoes"       -> []
	  | _             -> invalid_arg "Not a valid node" 
;;
# let graph_2 = Graph(node_list_2, edgefn_2) ;; 
# topological_sort graph_2 ;;
- : string list =
["Watch"; "Socks"; "Shirt"; "Tie"; "Undershorts"; "Pants"; "Belt"; "Jacket";
 "Shoes"]

*)

(* -------------------------------------------------------------------------------------------------- *)
(* Section 5 : Mutable State and Memoization                                                          *)
(* -------------------------------------------------------------------------------------------------- *)

(*
  5. Cache: Pure functions (those without side effects) always produces the same value
     when invoked with the same parameter. So instead of recomputing values each time,
     it is possible to cache the results to achieve some speedup.
     
     The general idea is to store the previous arguments the function was called
     on and its results. On a subsequent call if the same argument is passed, 
     the function is not invoked - instead, the result in the cache is immediately 
     returned.  
    
     Note: you will need to use mutable state in some form to implement the cache.
  
     [10 Points]
*)

(*
  Given any function f as an argument, create a function that returns a
  data structure consisting of f and its cache
*)  
let new_cached_fun f = () (* ANSWER *)

(*
  Write a function that takes the above function-cache data structure,
  applies an argument to it (using the cache if possible) and returns
  the result 
*)
let apply_fun_with_cache cached_fn x = () (* ANSWER *)

(*
  The following function makes a cached version for f that looks
  identical to f; users can't see that values are being cached 
*)

let make_cached_fun f = 
  let cf = new_cached_fun f in 
    function x -> apply_fun_with_cache cf x
;;


(*
let f x = x + 1;;
let cache_for_f = new_cached_fun f;;
apply_fun_with_cache cache_for_f 1;;
cache_for_f;;
apply_fun_with_cache cache_for_f 1;;
cache_for_f;;
apply_fun_with_cache cache_for_f 2;;
cache_for_f;;
apply_fun_with_cache cache_for_f 5;;
cache_for_f;;
let cf = make_cached_fun f;;
cf 4;;
cf 4;;


# val f : int -> int = <fun>
# val cache_for_f : ... 
# - : int = 2
# - : ...
# - : int = 2
# - : ...
# - : int = 3
# - : ...
# - : int = 6
# - : ...
# val cf : int -> int = <fun>
# - : int = 5
# - : int = 5
*)
