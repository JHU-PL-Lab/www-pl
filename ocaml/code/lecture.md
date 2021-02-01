
## Introduction to OCaml Programming

* OCaml is a *strongly typed functional programming language*
   - Strongly typed means the compiler will detect type errors; you won't get them at runtime like in JavaScript/Python
   - Functional means an emphasis on *functions* as a key building block and use of functions as data (functions that themselves can take functions as arguments and return functions as results)

(Note if you want to get all the code (only) in this webpage into a `.ml` file to load into your editor, download the file [lecture.ml](lecture.ml).)

### The top loop

* We will begin exploration of OCaml in the interactive *top loop*
* The top loop is the same as the read-eval-print loop or the console window for other languages
* To get the top loop we are using, `utop`, follow the course [OCaml install instructions](../index.html).

#### Simple integer operations in the top loop

```ocaml
3 + 4;; (* ";;" denotes end of input, somewhat archaic. *)
let x = 3 + 4;; (* give the value a name via let keyword. *)
let y = x + 5;; (* can use x now *)
let z = x + 5 in z - 1;; (* let .. in defines a local variable z *)
```

#### Boolean operations

```ocaml
let b = true;;
b && false;;
true || false;;
1 = 2;; (* = not == for equality comparison - ! *)
1 <> 2;;  (* <> not != for not equal *)
```

#### Other basic data -- see documentation for details
```ocaml
4.5;; (* floats *)
4.5 +. 4.3;; (* operations are +. etc not just + which is for ints only *)
30980314323422L;; (* 64-bit integers *)
'c';; (* characters *)
"and of course strings";;
```

#### Simple functions on integers

To declare a function `squared` with `x` its one parameter.  `return` is  implicit.
```ocaml
let squared x = x * x;; 
squared 4;; (* to call a function -- separate arguments with S P A C E S *)
```
 *  OCaml has no `return` statement; value of the whole body-expression is what gets returned
 *  Type is automatically **inferred** and printed as domain `->` range
 *  OCaml functions in fact always take only one argument - !  multiple arguments can be encoded (later)


#### Fibonacci series example - `0 1 1 2 3 5 8 13 ...` 

Let's write a well-known function with recursion and if-then-else syntax

```ocaml
let rec fib n =     (* the "rec" keyword needs to be added to allow recursion *)
  if n <= 0 then 0
  else if n = 1 then 1
  else fib (n - 1) + fib (n - 2);; (* notice again everything is an expression, no "return" *)

fib 10;; (* get the 10th Fibonacci number *)
```

#### Anonymous functions basics

* Key advantage of FP: functions are just expressions; put them in variables, pass and return from other functions, etc.
* Much of this course will be showing how this is useful, we are just getting started now

```ocaml
let add1 x = x + 1;; (* a normal add1 definition *)
let anon_add1 = (function x -> x + 1);; (* equivalent anonymous version; "x" is argument here *)
anon_add1 3;;
(anon_add1 4) + 7;; 
((function x -> x + 1) 4) + 7;; (* can inline anonymous function definition *)
((fun x -> x + 1) 4) + 7;; (*  shorthand notation -- cut off the "ction" *)
```

<a name="ii"></a>
## Basic OCaml II

* Multiple arguments - just leave s p a c e s between multiple arguments in both definitions and uses

```ocaml
let add x y = x + y;;
add 3 4;;
(add 3) 4;; (* same meaning as previous application -- two applications, " " associates LEFT *)
let add3 = add 3;; (* No need to give all arguments at once!  Type of add is int -> (int -> int) - "CURRIED" *)
add3 4;;
add3 20;;
(+) 3 4;; (* Putting () around any infix operator turns it into a 2-argument function *)
```

Conclusion: add is a function taking an integer, and returning a **function** which takes ints to ints.
So, add is a **higher-order function**: it returns a function as result.

Observe `int -> int -> int` is parenthesized as `int -> (int -> int)` -- unusual **right** associativity

Be careful on operator precedence with this goofy way that function application doesn't need parens!
```ocaml
add3 (3 * 2);;
add3 3 * 2;; (* NOT the previous - this is the same as (add3 3) * 2 - application binds tighter than * *)
add3 @@ 3 * 2;; (* LIKE the original - @@ is like the " " for application but binds LOOSER than other ops *)
```

### Simple Structured Data Types: Option and Result

* Before getting into "bigger" data types and how to declare our own, let's use one of the simplest structured data types, the built-in `option` type.

```ocaml
Some 5;;
- : int option = Some 5
```

* all this does is "wrap" the 5 in the `Some` tag

```ocaml
None;;
- : 'a option = None
```

 * Notice these are both in the `option` type .. either you have `Some` data or you have `None`.
 * These kinds of types with the capital-letter-named tags are called **variants** in OCaml; each tag wraps a different variant.
 * The `option` type is very useful; here is a super simple example.

 ```ocaml
# let nice_div m n = if n = 0 then None else Some (m / n);;
val nice_div : int -> int -> int option = <fun>
# nice_div 10 0;;
- : int option = None
# nice_div 10 2;;
- : int option = Some 5
```

There is a downside with this though, you can't just use `nice_div` like `/`:

```ocaml
# (nice_div 5 2) + 7;;
Line 1, characters 0-14:
Error: This expression has type int option
       but an expression was expected of type int
```

This type error means the `+` lhs should be type `int` but is a `Some` value which is not an `int`.

Here is a non-solution to that:
 ```ocaml
# let not_nice_div m n = if n = 0 then None else m / n;;
Line 1, characters 47-52:
Error: This expression has type int but an expression was expected of type
         'a option
```
- The `then` and `else` branches must return the same type, here they do not.
- The `int` and `int option` types have no overlap of members!  Generally true across OCaml.

#### Pattern matching first example

Here is a real solution to the above issue:
```ocaml
# match (nice_div 5 2) with 
   | Some i -> i + 7 (* i is bound to the result, 2 here *)
   | None -> failwith "This should never happen, we divided by 2";;
- : int = 9
```
* This shows how OCaml lets us *destruct* option values, via the `match` syntax.
* `match` is similar to `switch` in C/Java/.. but is much more flexible in OCaml
* The LHS in OCaml can be a general pattern which binds variables (the `i` here), etc
* Note that we turned `None` into a runtime exception via `failwith`.

Lastly, the function could itself raise an exception

```ocaml
let div_exn m n = if n = 0 then failwith "divide by zero is bad!" else m / n;;
div_exn 3 4;;
```

* This has the property of not needing a match on the result.  
* Note that the built-in `/` also raises an exception.
* Exceptions are side effects though, we want to minimize their usage to avoid error-at-a-distance.
* The above examples show how exceptional conditions can either be handled via exceptions or in the return value; 
   - the latter is the C approach

### Everything is an expression

Everything in OCaml returns values (i.e. is an 'expression') - no commands
```ocaml
if (x = 3) then (5 + 35) else 6;; (* ((x==3)?5:6)+1 in C *)
(if (x = 3) then 5 else 6) * 2;;
(if (x = 3) then 5.4 else 6) * 2;; (* type errors:  two branches of if must have same type *)
```

### Lists

* Lists are pervasive in OCaml
* They are **immutable** (cannot update elements in an existing list) so while they look something like arrays or vectors they are not

```ocaml
let l1 = [1; 2; 3];;
let l2 = [1; 1+1; 1+1+1];;
let l3 = ["a"; "b"; "c"];;
let l4 = [1; "a"];; (* error - All elements must have same type *)
let l5 = [];; (* empty list *)
```

#### Operations on lists.  

Lists are represented internally as **binary trees** with left child a leaf.
```ocaml
0 :: l1;; (* "::" is 'consing' 0 to the top of the tree - fast *)
0 :: (1 :: (2 :: (3 :: [])));; (* equivalent to [0;1;2;3] *)
[1; 2; 3] @ [4; 5];; (* appending lists - slower, needs to cons 3/2/1 on front of [4;5] *)
let z = [2; 4; 6];;
let y = 0 :: z;;
z;; (* Observe z itself did not change -- recall lists are immutable in OCaml *)
```

#### Destructing Lists with pattern matching

* Before writing real programs here is a simple example of pattern matching on a list.
* This function gets the head, the first element.

```ocaml
let hd l =
  match l with
  |  [] -> None
  |  x :: xs -> Some x (* the pattern x :: xs  binds x to the first elt, xs to ALL the others *)
;;
hd [1;2;3];;
hd [1];; (* [1] is 1 :: [] - !  So the head is 1. *)
hd [];;
```

* Lists are not random access like arrays; if you want to get the nth element, you need to work for it.

```ocaml
let rec nth l n =
  match l with
  |  [] -> failwith "no nth element in this list"
  |  x :: xs -> if n = 0 then x else nth xs (n-1)
;;
nth [33;22;11] 1;;
nth [33;22;11] 3;;
```
* Pattern priority: pick the first matched clause
* The above two patterns are mutually exclusive so order irrelevant, but not in all cases.

Don't use non-exhaustive pattern matches!

```ocaml
let dumb l = match l with
      | x :: y -> x;;
dumb [1;2;3];; (* this works to return head of list but.. *)
dumb [];; (* runtime error here *)
```

Built-in `List.hd` is the same as `dumb` and it is nearly always a **dumb** function, don't use it unless it is 100% obvious that the list is not empty.


### List library functions
Fortunately many common list operations are in the `List` module in the standard library:

```ocaml
# List.nth [1;2;3] 2;;
- : int = 3
```
* We will discuss modules later, but for now just think of them as containers of a collection of functions types etc.  Something like a `package` in Java, or a Java `class` with only `static` methods.

Some more handy `List` library functions
```ocaml
List.length ["d";"ss";"qwqw"];;
List.concat [[1;2];[22;33];[444;5555]];;
List.append [1;2] [3;4];; 
[1;2] @ [3;4] (* Use this equivalent infix syntax for append *)
```

* Type `#show List;;` into utop to get a dump of all the functions in `List`.
* The [Standard Library Reference page for lists](http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html) contains descriptions as well.
* There are similar modes for `Int`, `String`, `Float`, etc modules which similarly contain handy functions.

#### Types of these library functions

* The types of the functions are additional hints to their purpose, get used to reading them
* Much of the time when you mis-use a function you will get a type error
* `'a list` etc is a polymorphic aka generic type, `'a` can be *any* type
```ocaml
# List.length;;
- : 'a list -> int = <fun>
# List.concat;;
- : 'a list list -> 'a list = <fun>
# List.append;;
- : 'a list -> 'a list -> 'a list = <fun>
```

A cool feature of OCaml is how it automatically *infers* polymorphic types, unlike Java where generics usually need to be declared explicitly.

### Correctness of recursive Functions

Consider list reverse (no need to code as it is `List.rev`; this is just an example):
```ocaml
let rec rev l =
  match l with
  |  [] -> []
  | x :: xs -> rev xs @ [x]
;;
rev [1;2;3];; (* recall [1;2;3] is equivalent to 1 :: ( 2 :: ( 3 :: [])) *)
```

Let us argue why this works.

We assume we have a notion of "program fragments behaving the same", `~=`.
 -  e.g. `1 + 2 ~= 3`, `1 :: [] ~= [1]`, etc.  
 -  (`~=` is called "operational equivalence", we will define it later in the course)

Before doing the general case, here are some equivalences we can see from the above program run 
(by running it in our heads):
```ocaml
rev [1;2;3] 
~= rev (1 :: [2;3]) (by the meaning of the [...] list syntax)
~= (rev [2;3]) @ [1]  (the second pattern is matched: x is 1, xs is [2;3] and run the match body)
~= (rev [3] @ [2]) @ [1]  (same thing for the rev [2;3] expression - plug in its elaboration)
~= ((rev [] @ [3]) @ [2]) @ [1]
~= (([] @ [3]) @ [2]) @ [1]
~= [3;2;1] (by the meaning of append)
``` 

But, what we really want to show is it reverses ANY list.. use induction!

Let P(n) mean "for any list l of length n, `rev l ~=` its reverse".

Recall an induction principle:
To show P(n) for all in, it suffices to show 
  1) P(0), and 
  2) P(k) holds implies P(k+1) holds for any natural number k.

* Induction is not explained well by mathematicians which causes confusion
* It is easier for us CS-ers, the induction step 2) is really just a **proof macro** with k a parameter
* Induction is justified by repeatedly instantiating the macro for 1,2,3,..

So, if we showed 1) and 2) above, 
- P(0) is true by 1)
- P(1) is true because letting k=0 in 2) we have P(0) implies P(1),
    and we just showed we have P(0), so we also have P(1).
- P(2) is true because letting k=1 in 2) we have P(1) implies P(2),
    and we just showed we have P(1), so we also have P(2).
- P(3) is true because letting k=2 in 2) we have P(2) implies P(3),
    and we just showed we have P(2), so we also have P(3).
- ... etc for all k

Let us now prove by induction.

Theorem: For any list `l` of length n, `rev l ~=` the reverse of `l` .
Proof.  Proceed by induction to show this property for any n.
  1) for n = 0, `l ~= []` since that is the only 0-length list.
     `rev [] ~= []` which is `[]` reversed, check!
  2) Assume for any k-length list `l` that `rev l ~= l` reversed.
     Show for any k+1 length list, i.e. for any list `x :: l`
     that `rev (x :: l) ~= (x :: l)` reversed:

OK, by computing, `rev (x :: l) ~= rev l @ [x]`.
Now by the induction hypothesis, `rev l` is `l` reversed.
So, since `(l` reversed`) @ [x]` reverses the whole list `x :: l`,
`rev (x :: l) ~= (x :: l)` reversed.
This completes the induction step.

QED.    

<a name="iii"></a>
###  OCaml Lecture III

### Tuples

Think of tuples as fixed length lists, where the types of each element can differ, unlike lists

```ocaml
(2, "hi");;        (* type is int * string -- '*' is like "x" of set theory, a product *)
let tuple = (2, "hi");;
(1,1.1,'c',"cc");;
```
Tuple pattern matching
```ocaml
let tuple = (2, "hi", 1.2);;

match tuple with
  (f, s, th) -> s;;

(* shorthand for the above - only one pattern, can use let syntax *)
let (f, s, th) = tuple in s;;
```

#### Consequences of immutable variable declarations on the top loop

 * All variable declarations in OCaml are **immutable** -- value will never change
 * Helps in reasoning about programs, we know the variable's value is fixed
 * But can be confusing when shadowing (re-definition) happens

```ocaml
(let y = 3 in
  ( let x = 5 in
    ( let f z = x + z in
      ( let x = y in  (* this is a re-definition of x, NOT an assignment *)
        (f (y - 1)) + x
            )
        )
    )(* x is STILL 5 in the function body - thats what x was when f defined *)
)
;;
```

This is in the spirit of this C pseudo-code:
```c
 { int y = 3;
   { int x = 5;
     { int (int) f = z -> return(x + z); (* imagining higher-order functions in C *)
       { int x = y; (* shadows previous x in C *)
         return(f(y-1) + x); 
  }}}})
```

The top loop is conceptually an open-ended series of let-ins which never close:
```ocaml
let y = 3;;
let x = 5;;
let f z = x + z;;
let x = y;; (* as in previous example, this is a nested definition, not assignment! *)
f (y-1) + x;;
```
Function definitions are similar, you can't mutate an existing definition.

```ocaml
let f x = x + 1;;
let g x = f (f x);;
let shad = f;; (* make a new name for f above *)
(* lets "change" f, say we made an error in its definition above *)
let f x = if x <= 0 then 0 else x + 1;;
g (-5);; (* g still refers to the initial f - !! *)

assert( g (-5) = 0);; (* example of built-in assert in action - returns () if holds, exception if not *)

let g x = f (f x);; (* FIX to get new f: resubmit (identical) g code *)

assert(g (-5) = 0);; (* now it works as we initially expected *)
```

* Moral: don't code (too much) directly in the top-loop since this behavior can cause anomalies
* For Assignment 1, you will be able to say `dune test` in the terminal to run tests on your code, and `dune utop` will load it all into `utop` so you can then play with your functions.

#### Mutually recursive functions

Warm up to the next function - write a (useless) copy function on lists

```ocaml
let rec copy l =
  match l with
  | [] -> []
  | hd :: tl ->  hd::(copy tl);;

let result = copy [1;2;3;4;5;6;7;8;9;10]
```
* Argue by induction that this will copy the input list `l`.
* (List copy is in fact useless because lists are immutable - compiler can *share*)
  - This property is a form of *referential transparency*

Refine copy to flip back and forth between copying and not

```ocaml
let rec copyodd l = match l with
  | [] -> []
  | hd :: tl ->  hd::(copyeven tl)
and  (* new keyword for declaring mutually recursive functions *)
  copyeven l = match l with
  |  [] -> []
  | x :: xs -> copyodd xs;;

copyodd [1;2;3;4;5;6;7;8;9;10];;
copyeven [1;2;3;4;5;6;7;8;9;10];;
```

### Using `let .. in` to define local functions

Here is a version that hides the `copyeven` function -- make both internal and export one

```ocaml
let copyodd ll =
  let rec copyoddlocal l = match l with
    |  [] -> []
    | hd :: tl ->  hd::(copyevenlocal tl)
  and
    copyevenlocal l = match l with
    |        [] -> []
    | x :: xs -> copyoddlocal xs
  in
  copyoddlocal ll;;

assert(copyodd [1;2;3;4;5;6;7;8;9;10] = [1;3;5;7;9]);;
```

### Higher Order Functions

Higher order functions are functions that either
 * take other functions as arguments
 * or return functions as results
 * or both of the above

Why?
 * "pluggable" programming by passing in and out chunks of code
 * greatly increases reusability of code since any varying code can be pulled out as a function to pass in
 * Lets show the power by extracting out some pluggable code

Example: append `"gobble"` to each word in a list of strings

```ocaml
let rec appendgobblelist l =
  match l with
  | [] -> []
  | hd::tl -> (hd ^"gobble") :: appendgobblelist tl;;

appendgobblelist ["have";"a";"good";"day"];;
("have" ^"gobble") :: ("a"^"gobble") :: appendgobblelist ["good";"day"];;
```

* Lets pull out the "append gobble" action as a function parameter, make it code we can plug in
* The resulting function is called `map` (note it is also available as `List.map`):
```ocaml
let rec map f l =  (* function f is an argument here *)
  match l with
  |  [] -> []
  | hd::tl -> (f hd) :: map f tl;;
```

```ocaml
let middle = map (function s -> s^"gobble");;
middle ["have";"a";"good";"day"];;
```

Mapping on lists of pairs - in and out lists can be different types.
```ocaml
map (fun (x,y) -> x + y) [(1,2);(3,4)];;
let flist = map (fun x -> (fun y -> x + y)) [1;2;4] ;; (* make a list of functions - why not? *)
```
* This aligns with the type of `map`, `('a -> 'b) -> 'a list -> 'b list ` - `'a` and `'b` can differ.

### Folds

 * fold_left/right are classic operators on lists 
 * combines a vector of data like the reduce of map/reduce

```ocaml
let rec fold_left f v l = match l with
    | []   -> v
    | hd::tl -> fold_left f (f v hd) tl (* pass down f v hd as "the new v" -- accumulating *)
    ;;
```

Summing elements of a list can now be succinctly coded:
```ocaml
fold_left (fun elt -> fun accum -> elt + accum) 0 [1;2;3];; (* = (((0+1)+2)+3) - 0 on LEFT *)
fold_left (+) 0 [1;2;3];; (* equivalent to previous *)
```

Compare to this manual summate - pulled out the combining operator `+` and zero `0`

```ocaml
let rec summate accum l = match l with
    | []   -> accum
    | hd::tl -> summate (accum + hd) tl (* pass down f v hd as new "v" -- accumulating *)
    ;;
summate 0 [1;2;3];;
```

More examples.  Note this is `List.fold_left` in OCaml library

```ocaml
let length l = List.fold_left (fun accum elt -> accum + 1) 0 l;; (* adds accum, ignores elt *)
let rev l = List.fold_left (fun accum elt -> elt::accum) [] l;; (* e.g. rev [1;2;3] = (3::(2::(1::[]))) *)
```
* Right fold is similar but f is applied "on the way out" of recursion, not "on the way down" like in left fold above.
* also in List.fold_right.
* Args are swapped compared to fold_left, be careful !

```ocaml
let rec fold_right f l v = match l with
  | [] -> v
  | hd::tl -> f hd (fold_right f tl v) (* v not changing on recursion here *)
;;
fold_right (+) [1;2;3] 0;; (* = (1+(2+(3+0))) - observe the 0 is on the right *)
```

Example where left and right folds produce a different result:

```ocaml
fold_left (fun elt -> fun accum -> "("^elt^"+"^accum^")") "0" ["1";"2";"3"] ;; 
fold_right (fun accum -> fun elt -> "("^accum^"+"^elt^")") ["1";"2";"3"] "0" ;; 
```

`map` is a simple right fold - the fold does the recursion work.
```ocaml
let map f l = List.fold_right (fun elt accum -> (f elt)::accum) l [];;
```

Another example of left vs right - left's accumulating maps and reverses
```ocaml
let map_and_rev f l = List.fold_left (fun accum elt -> (f elt)::accum) [] l ;; (* notice how this reverses *)
```

More operations
```ocaml
let filter f l = List.fold_right (fun elt accum -> if f elt then elt::accum else accum) l [];; 
let rev l = List.fold_right (@) l [];;
```

### Pipeling and composition

Pipelining Example: get the nth-from the end from a list, by first reversing and then getting nth element.

Obvious version:
```ocaml
let nth_end l n = List.nth (List.rev l) n;;
```

* But, from the analogy of shell pipes `|`, we are "piping" the output of `rev` into `nth` for some fixed n.  
* Here is an equivalent way to code that using OCaml pipe notation, `|>`

```ocaml
let nth_end l n = l |> List.rev |> (Fun.flip(List.nth) n);;
```
* All `[1;2] |> List.rev` in fact does is apply the second argument to the first - very simple!
* The type gives it away: `(|>)` has type `'a -> ('a -> 'b) -> 'b`
* The `Fun.flip` is needed to put the list argument second, not first
  - it is another interesting higher-order function, with type `('a -> 'b -> 'c) -> 'b -> 'a -> 'c`.

#### Function Composition: functions in, functions out

Composition function g o f: take two functions, return their composition
```ocaml
let compose g f = (fun x -> g (f x));;

let plus3 x = x+3;;
let times2 x = x*2;;
let times2plus3 = compose plus3 times2;;
times2plus3 10;;
(* equivalent but with anonymous functions: *)
compose (fun x -> x+3) (fun x -> x*2) 10;;
```

* Equivalent ways to write the `compose` funtion in OCaml syntax
* Work on interconverting between these equivalent forms in your head

```ocaml
let compose g f x =  g (f x);;
let compose = (fun g -> (fun f -> (fun x -> g(f x))));;
```

### Currying

* An idea due to logician Haskell Curry
* First lets recall how multi-argument functions work in OCaml

```ocaml
let addC x y = x + y;;
addC 1 2;; (* recall this is the same as '(addC 1) 2' *)
let tmp = addC 1 in tmp 2;; (* the partial application of arguments - result is a function *)
```

An equivalent way to define `addC`, clarifying what the above means:

```ocaml
let addC = fun x -> (fun y -> x + y);;
(* and, yet another identical way .. *)
let addC x = fun y -> x + y;;
(* Yet one more, this is the built-in (+) *)
(+);;
```

Here is the so-called non-Curried version: use a *pair of arguments* instead
```ocaml
let addNC p =
    match p with (x,y) -> x+y;;
```

Here is an equivalent OCaml syntax which looks like a standard C function
  - This is a one-argument function, but you can pattern match in the argument position in OCaml!
```ocaml
let addNC (x, y) = x + y;;
```


Notice how the type of the above differs from addC's type: `int * int -> int` vs `int -> int -> int`.

```ocaml
addNC (3, 4);;
addNC 3;; (* errors, need all or no arguments supplied *)
```
* Fact: these two approaches to defining a 2-argument function are isomorphic:
`'a * 'b -> 'c` ~= `'a -> 'b -> 'c`
* (This isomorphism also holds in set theory, you may have already seen it)

We now define two cool higher-order functions:
* `curry`   - takes in non-curry'ing 2-arg function and returns a curry'ing version
* `uncurry` - takes in curry'ing 2-arg function and returns an non-curry'ing version

Since we can then go back and forth between the two reps, they are **ISOMORPHIC**

```ocaml
let curry fNC = fun x -> fun y -> fNC (x, y);;
let uncurry fC = fun (x, y) -> fC x y;;

let newaddNC = uncurry addC;;
newaddNC (2,3);;
let newaddC  = curry   addNC;;
newaddC 2 3;;
```

Observe the types themselves pretty much specify the behavior
```ocaml
curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c
```

```ocaml
let noop1 = curry (uncurry addC);; (* a no-op *)
let noop2 = uncurry (curry addNC);; (* another no-op; noop1 & noop2 together show isomorphism *)
```
### Misc OCaml

See [module Stdlib](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Stdlib.html) for various functions available in the OCaml top-level like `+`, `^` (string append), `print_int` (print an integer), etc.

See [the Standard Library](http://caml.inria.fr/pub/docs/manual-ocaml/stdlib.html) for modules of functions for `List`s, `String`s, `Int`egers, as well as `Set`s, `Map`s, etc, etc.

```ocaml
print_string ("hi\n");;
```

Some `Stdlib` built-in exception generating functions (more on exceptions later)
```ocaml
(failwith "BOOM!") + 3 ;;
```

Invalid argument exception `invalid_arg`:
```ocaml
let f x = if x <= 0 then invalid_arg "Let's be positive, please!" else x + 1;;
f (-5);;
```

* OCaml infers types most of the time
* But, you can optionally declare types on any expression
 - Put parens around any such declaration or it won't parse

```ocaml
let add (x: float) (y: float) = x +. y;;
let add (x: int) (y: int) = (((x:int) + y) : int);;
```

Type abbreviations are also possible via `type `
```ocaml
type intpair = int * int;;
let f (p : intpair) = match p with
                      (l, r) -> l + r
;;
(2,3);; (* ocaml doesn't call this an intpair by default *)
f (2, 3);; (* still, can pass it to the function expecting an intpair *)
((2,3):intpair);; (* can also explicitly tag data with its type *)
```

### Time-out to solve some simple problems
Lets work through some simple programming problems to get experience with writing simple functional OCaml programs
1. Write a function 'toUpperCase' which takes a list (l) of characters and returns a list which has the same characters as l, but capitalized (if not already).

Notes: 
a. Assume that the capital of characters other than alphabets
            (A - Z or a - z), are the characters themselves e.g.

```
                character               corresponding capital character

                    a                             A
                    z                             Z
                    A                             A
                    1                             1
                    %                             %
```

b. You can only use `Char.code` and `Char.chr` library functions. You **cannot** use `Char.uppercase`.

**Answer:**
```ocaml
let toUpperChar c =
  let c_code = Char.code c in
  if c_code >= 97 && c_code <= 122 then
    Char.chr (c_code - 32)
  else c;;


let rec toUpperCase l =
  match l with
    [] -> []
  | c :: cs -> toUpperChar c :: toUpperCase cs
;;
```

Test
```ocaml
assert(toUpperCase ['a'; 'q'; 'B'; 'Z'; ';'; '!'] = ['A'; 'Q'; 'B'; 'Z'; ';'; '!']);;
```

Could have used map instead (note map is built in as `List.map`):

```ocaml
let toUpperCase l = List.map toUpperChar l ;;
```

Could have also defined it even more simply - partly apply the Curried map:

```ocaml
let toUpperCase = List.map toUpperChar ;;
```

2. Write a function 'partition' which takes a predicate (p) and a list (l) as arguments  and returns a tuple (l1, l2) such that l1 is the list of all the elements of l that satisfy the predicate p and l2 is the list of all the elements of l that do NOT satisfy p. The order of the elements in the input list (l) should be preserved.

Note: A predicate is any function which returns a boolean. e.g. let isPositive n = (n > 0);;

**Answer:**
```ocaml
let rec partition p l =
  match l with
  |[] -> ([],[])
  | hd :: tl ->
    let (posl,negl) = partition p tl in
    if (p hd)
    then
      (hd :: posl,negl)
    else
      (posl,hd::negl);;
```
Test

```ocaml
let isPositive n = n > 0 in
assert(partition isPositive [1; -1; 2; -2; 3; -3] = ([1; 2; 3], [-1; -2; -3]))
```

3. Write a function `diff` which takes in two lists l1 and l2 and returns a list containing all elements in l1 not in l2.

Note: You will need to write another function `contains x l` which checks  whether an element `x` is contained in a list `l` or not.

**Answer:**
```ocaml
let rec contains x l =
  match l with
    [] -> false
  | y :: ys -> x = y || contains x ys
;;

let rec diff l1 l2 =
  match l1 with
    [] -> []
  | x :: xs ->
      if contains x l2 then
    diff xs l2
      else
    x :: diff xs l2
;;
```

Tests
```ocaml
assert(contains 1 [1; 2; 3])
assert(not(contains 5 [1; 2; 3]))
assert(diff [1;2;3] [3;4;5] = [1; 2])
assert(diff [1;2] [1;2;3] = [])
```

<a name="iv"></a>
### OCaml Lecture IV: Variants, records, mutution, exceptions, modules

We saw a simple examples of variants above, the `option` type; now we go into the full possibilities
  - related to `union` types in C or `enum`s in Java: "this OR that OR theother"
  - like OCamls lists/tuples they are IMMMUTABLE data structures
  - each case of the union is identified by a name called 'Constructor' which serves for both
      - constructing values of the variant type
      - inspecting them by pattern matching
      - constructors must start with Capital Letter to distinguish from variables
      - type declarations are needed but once they are in place type inference on them works


Example variant type for doing mixed arithmetic (integers and floats)

```ocaml
type mynumber = Fixed of int | Floating of float;;  (* read "|" as "or" *)

Fixed(5);; (* tag 5 as a Fixed *)
Floating 4.0;; (* tag 4.0 as a Floating *)
```

Note constructors look like functions but they are **not** -- you always need to give argument

```ocaml
let pullout_int x =
    match x with
    | Fixed n -> n    (* variants fit well into pattern matching syntax *)
    | Floating z -> int_of_float z;;

pullout_int (Fixed 5);;
```

A non-trivial function using the above variant type

```ocaml
let add_num n1 n2 =
   match (n1, n2) with    (* note use of pair here to parallel-match on two variables  *)
     | (Fixed i1, Fixed i2) ->       Fixed   (i1       +  i2)
     | (Fixed i1,   Floating f2) ->  Floating(float i1 +. f2)       (* need to coerce *)
     | (Floating f1, Fixed i2)   ->  Floating(f1       +. float i2) (* ditto *)
     | (Floating f1, Floating f2) -> Floating(f1       +. f2)
;;

add_num (Fixed 123) (Floating 3.14159);;
```

Multiple data items in a single clause?  Use tuple types

```ocaml
type complex = CZero | Nonzero of float * float;;

let com = Nonzero(3.2,11.2);;
let zer = CZero;;
```

#### Recursive data structures 
  - A key use of variant types
  - Functional programming is fantastic for computing over tree-structured data
  - Recursive types can refer to themselves in their own definition
  - Similar in spirit to how C structs can be recursive (but, no pointer needed here)

Warm-up: homebrew lists - built-in list type not needed
First just int lists

```ocaml
type myintlist = Mt | Cons of int * myintlist;; (* Observe: self-referential type *)
let mylisteg = Cons(3,Cons(5,Cons(7,Mt)));; (* equivalent to [3;5;7] *)
```
Let us extend the above to be just like built-in polymorphic lists

```ocaml
type 'a mylist = Mt | Cons of 'a * ('a mylist);;
```
Observe how above type takes a (prefix) argument, 'a -- "mylist" is a type function

```ocaml
let mylisteg = Cons(3.,Cons(5.,Cons(7.,Mt)));;
```

```ocaml
let rec double_list_elts ml =
  match ml with
    | Mt -> Mt (* vs [] -> [] *)
    | Cons(hd,tl) -> Cons(hd *. 2.,double_list_elts tl);; (* vs hd :: tl -> .. *)

double_list_elts mylisteg;;
```

Binary trees, like lists but two self-referential sub-structures not one

```ocaml
type 'a btree = Leaf | Node of 'a * 'a btree * 'a btree;;
```

Example trees

```ocaml
let whack = Node("whack!",Leaf, Leaf);;
let bt = Node("fiddly ",
            Node("backer ",
               Leaf,
               Node("crack ",
                  Leaf,
                  Leaf)),
            whack);;

let bt2 = Node("fiddly ",
            Node("backer ",
               Leaf,
               Node("crack ",
                  Leaf,
                  Leaf)),
            whack);;
(* Type error, like list, must have uniform type: *)
Node("fiddly",Node(0,Leaf,Leaf),Leaf);;
```

Functions on binary trees are similar to functions on lists: use recursion

```ocaml
let rec add_gobble binstringtree =
   match binstringtree with
     Leaf -> Leaf
   | Node(y, left, right) ->
       Node(y^"gobble",add_gobble left,add_gobble right)
;;
```
(Remember, this is not mutating the tree, its building a new one)

```ocaml
let rec lookup x bintree =
   match bintree with
     | Leaf -> false
     | Node(y, left, right) ->
       if x = y then
          true
       else if x < y then
          lookup x left
       else
          lookup x right
;;

lookup "whack!" bt;;
lookup "flack" bt;;
```

```ocaml
let rec insert x bintree =
   match bintree with
     Leaf -> Node(x, Leaf, Leaf)
   | Node(y, left, right) ->
       if x <= y then
         Node(y, insert x left, right)
       else
         Node(y, left, insert x right)
;;
```

This is also NOT MUTATING -- returns a whole new tree instead.

```ocaml
let goobt = insert "goober " bt;;
bt;; (* observe bt did not change after the insert *)
let gooobt = insert "slacker " goobt;; (* thread in the most recent tree *)
```

### Records
  - like tuples but with labels on fields.
  - similar to the structs of C/C++.
  - the types must be declared just like OCaml variants.
  - can be used in pattern matches as well.
  - again the fields are immutable by default

Example: a record type to represent rational numbers

```ocaml
type ratio = {num: int; denom: int};;
let q = {num = 53; denom = 6};;
q.num;;
q.denom;;
```

Pattern matching works of course
```ocaml
let rattoint r =
 match r with
   {num = n; denom = d} -> n / d;;
```

Only one pattern matched so can again inline pattern in functions and lets
```ocaml
let rattoint {num = n; denom = d}  =
   n / d;;
```

Equivalently can use dot projections, but happy path is usually patterns
```ocaml
let rattoint r  =
   r.num / r.denom;;
rattoint q;;
```

```ocaml
let add_ratio r1 r2 = {num = r1.num * r2.denom + r2.num * r1.denom; 
                      denom = r1.denom * r2.denom};;
add_ratio {num = 1; denom = 3} {num = 2; denom = 5};;
```

Annoying shadowing issue: there is one global namespace of record labels
```ocaml
type newratio = {num: int; coeff: float};; (* shadows ratio's label num *)

fun x -> x.num;; (* x is a newratio, the most recent num field defined *)
```
Solution in event of shadowing: pattern match on full record

```ocaml
fun {num = n; denom = _} -> n;;
```

#### End of Pure Functional programming in OCaml
* On to side effects
* But before heading there, remember to stay OUT of side effects unless *really* needed - that is the happy path in OCaml coding
* The autograder may let you get away with side effects on assignment 1 but you will get a manual ding by the CAs.

### State
 *   Variables in OCaml are NEVER directly mutable themselves; only (indirectly) mutable if they hold a
      - reference
      - mutable record
      - array

Indirect mutability - variable itself can't change, but what it points to can.
 - items are immutable unless their mutability is explicitly declared

### Mutable References

```ocaml
let x = ref 4;;    (* always have to declare initial value when creating a reference *)
```

Meaning of the above: x forevermore (i.e. forever unless shadowed) refers to a fixed cell.  The **contents** of that fixed call can change, but not x.

```ocaml
x + 1;; (* a type error ! *)
!x + 1;; (* need !x to get out the value; parallels *x in C *)
x := 6;; (* assignment - x must be a ref cell.  Returns () - goal is side effect *)
!x + 1;; (* Mutation happened to contents of cell x *)
```

* `'a ref` is really implemented by a mutable record with one field, contents:
* `'a ref` abbreviates the type `{ mutable contents: 'a }`
* The keyword mutable on a record field means it can mutate

```ocaml
let x = { contents = 4};; (* identical to x's definition above *)
x := 6;;
x.contents <- 7;;  (* same effect as previous line: backarrow updates a field *)

!x + 1;;
x.contents + 1;; (* same effect as previous line *)
```

Declaring your own mutable record: put `mutable` qualifier on field

```ocaml
type mutable_point = { mutable x: float; mutable y: float };;
let translate p dx dy =
                p.x <- (p.x +. dx); (* observe use of ";" here to sequence effects *)
                p.y <- (p.y +. dy)  (* ";" is useless without side effects (think about it) *)
                                ;;
let mypoint = { x = 0.0; y = 0.0 };;
translate mypoint 1.0 2.0;;
mypoint;;
```

Observe: mypoint is immutable at the top level but it has two spots in it where we can mutate

Tree with mutable nodes

```ocaml
type mtree = MLeaf | MNode of int * mtree ref * mtree ref;;
```

- ONLY ref typed variables or mutable records may be assigned to
- The notion of immutable variables is one of the great strengths of OCaml.
- Note: `let` doesn't turn into a mutation operator with `ref`:

```ocaml
let x = ref 4;;
let f () = !x;; (* This is syntax for a 0-argument function in OCaml - it only takes () as argument *)

x := 234;;
f();;

let x = ref 6;; (* shadowing previous x definition, NOT an assignment to x !! *)
f ();;
```

Yes, OCaml has our old friend `;` and with it we can write an imperative `while` loop
```ocaml
let x = ref 1 in
    while !x < 10 do
      print_int !x;
      print_string "\n";
      x := !x + 1;
    done;;
```

Fact: while loops are useless without mutation: either never loop or infinitely loop

Why is immutability good?
 - programmer can depend on the fact that something will never be mutated when writing code: permanent like mathematical definitions
 - OCaml lets you express mutation if it is critically needed

### Arrays
 - Fairly self-explanatory, we will just flash over this in lecture
 - Have to be initialized before using
   - in general there is no such thing as "uninitialized"/"null" in OCaml


```ocaml
let arrhi = Array.make 100 "";; (* size and initial value are the params here *)
let arr = [| 4; 3; 2 |];; (* another way to make an array *)
arr.(0);; (* access (unfortunately already used [] for lists in the syntax) *)
arr.(0) <- 55;; (* update *)
arr;;
```

### Exceptions
* OCaml has a standard (e.g. Java-like) notion of exception
* Unfortunately types do not include what exceptions a function will raise - an outdated aspect of OCaml.
* Modern OCaml coding style is to *minimize* the use of exceptions
  - Causes action-at-a-distance, hard to debug
  - Instead follow the old C approach of bubbling up error codes

```ocaml
exception Foo;;  (* This is a new form of top-level declaration, along with let, type *)

let f () = raise Foo;; (* note no need to "raises Foo" in the type as in Java *)
f ();;

exception Bar;;

let g _ = (* aside: "_" notates a variable that can never be accessed *)
  (try f ()
   with  
     Foo ->  5 | Bar -> 3) + 4;; (* Use power of pattern matching in handlers *)
g ();;
```

Exceptions with a parameter - syntax is like a variant
```ocaml
exception Goo of string;;

let f _ = raise (Goo "keyboard on fire");;
f ();;

let g () =
  try
    f ()
  with
      Foo -> ()
        | Goo s ->
      (print_string("exception raised: ");
       print_string(s);print_string("\n"))
;;
g ();;
```

There are a few built-in exceptions we mentioned previously:

```ocaml
failwith "Oops";; (* Generic code failure - exception is named Failure *)
invalid_arg "This function works on non-empty lists only";; (* Invalid_argument exception *)
```
###  OCaml Lecture V: Modules

Modules in programming languages
   - a module is a larger level of program abstraction: functional units or library.
   - e.g. Java package, Python module, C directory, etc
   - needed for all but very small programs: imagine a file system without directories/folders as analogy to a PL without modules - YUCK!

Some principles of modules:
  -  Modules have names they can be referenced by.
  -  A module contains code declarations: functions, classes,  types, etc.
  - They often are file-based: one module per file, module name is file name
  -  The module has a way to
      * import things (e.g. other modules) from the outside and
      * export some (or all) things it has declared for outsiders to use;
      * it may **hide** some things for internal use only
         -- hiding is a key feature, don't overwhelm users
      * Separate name spaces, so e.g. the Window's reset() won't clash
        with a File's reset(): use `Window.reset()` and `File.reset()`
      * Nested name spaces for ever larger software: `Window.Init.reset()`
      * Often modules can be compiled separately (for compiled languages)

Most modern languages have a module system solving most of these problems.

### Modules in OCaml

* We already saw OCaml modules in action earlier, 
* Example: `List.map`, this is an invocation of the map function in the built-in `List` module.
* Now, lets study how we can build our own OCaml modules
* We focus here on building modules via files, but there are other methods we skip

#### Making a module

* Assignment 1 requires you to fill out a file `assignment.ml`
* This is in fact creating a *module* `Assignment` (notice the first letter (only) is capped)
* `dune utop` will load your module in the top loop
* You then need to write `Assignment.factorial 5;;` etc to access the functions in the module's namespace
* Or, use `open Assignment;;` to make all the functions in the module available at the top level.

### Separate Compilation with OCaml

* File-based modules are also compiled separately, there is no top loop needed.
* This is the traditional `javac`/`cc`/etc style of coding
* The underlying compiler for OCaml is `ocamlc`, but in this course we will give you build files
  - just use `dune build` to invoke the compiler on all the files

### An example of a separately-compiled OCaml program

* See [set-example.zip](http://pl.cs.jhu.edu/pl/ocaml/code/set-example.zip) for the example we cover in lecture.
* We will follow [readme.txt](http://pl.cs.jhu.edu/pl/ocaml/code/sep_compile/readme.txt) in particular.
* See the ocaml manual Chapter 8 for the full documentation
* For this example we can use `dune utop` to load it into the `utop`

```sh
dune utop
```
```ocaml
FSet.emptyset;;
```
