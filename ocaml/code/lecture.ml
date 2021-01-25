3 + 4;; (* ";;" denotes end of input, somewhat archaic. *)
let x = 3 + 4;; (* give the value a name via let keyword. *)
let y = x + 5;; (* can use x now *)
let z = x + 5 in z - 1;; (* let .. in defines a local variable z *)

let b = true;;
b && false;;
true || false;;
1 = 2;; (* = not == for equality comparison - ! *)
1 <> 2;;  (* <> not != for not equal *)

4.5;; (* floats *)
4.5 +. 4.3;; (* operations are +. etc not just + which is for ints only *)
30980314323422L;; (* 64-bit integers *)
'c';; (* characters *)
"and of course strings";;

let squared x = x * x;; 
squared 4;; (* to call a function -- separate arguments with S P A C E S *)

let rec fib n =     (* the "rec" keyword needs to be added to allow recursion *)
  if n <= 0 then 0
  else if n = 1 then 1
  else fib (n - 1) + fib (n - 2);; (* notice again everything is an expression, no "return" *)

fib 10;; (* get the 10th Fibonacci number *)

let add1 x = x + 1;; (* a normal add1 definition *)
let anon_add1 = (function x -> x + 1);; (* equivalent anonymous version; "x" is argument here *)
anon_add1 3;;
(anon_add1 4) + 7;; 
((function x -> x + 1) 4) + 7;; (* can inline anonymous function definition *)
((fun x -> x + 1) 4) + 7;; (*  shorthand notation -- cut off the "ction" *)

let add x y = x + y;;
add 3 4;;
(add 3) 4;; (* same meaning as previous application -- two applications, " " associates LEFT *)
let add3 = add 3;; (* No need to give all arguments at once!  Type of add is int -> (int -> int) - "CURRIED" *)
add3 4;;
add3 20;;
(+) 3 4;; (* Putting () around any infix operator turns it into a 2-argument function *)

add3 (3 * 2);;
add3 3 * 2;; (* NOT the previous - this is the same as (add3 3) * 2 - application binds tighter than * *)
add3 @@ 3 * 2;; (* LIKE the original - @@ is like the " " for application but binds LOOSER than other ops *)

Some 5;;
- : int option = Some 5

None;;
- : 'a option = None

# let nicer_div m n = if n = 0 then Error "Divide by zero" else Ok (m / n);;
val nicer_div : int -> int -> (int, string) result = <fun>

# match (nicer_div 5 2) with 
   | Ok i -> i + 7
   | Error s -> failwith s;;
- : int = 9

let div_exn m n = if n = 0 then failwith "divide by zero is bad!" else m / n;;
div_exn 3 4;;

if (x = 3) then (5 + 35) else 6;; (* ((x==3)?5:6)+1 in C *)
(if (x = 3) then 5 else 6) * 2;;
(if (x = 3) then 5.4 else 6) * 2;; (* type errors:  two branches of if must have same type *)

let l1 = [1; 2; 3];;
let l2 = [1; 1+1; 1+1+1];;
let l3 = ["a"; "b"; "c"];;
let l4 = [1; "a"];; (* error - All elements must have same type *)
let l5 = [];; (* empty list *)

0 :: l1;; (* "::" is 'consing' 0 to the top of the tree - fast *)
0 :: (1 :: (2 :: (3 :: [])));; (* equivalent to [0;1;2;3] *)
[1; 2; 3] @ [4; 5];; (* appending lists - slower, needs to cons 3/2/1 on front of [4;5] *)
let z = [2; 4; 6];;
let y = 0 :: z;;
z;; (* Observe z itself did not change -- recall lists are immutable in OCaml *)

let hd l =
  match l with
  |  [] -> Error "empty list has no head"
  |  x :: xs -> Ok x (* the pattern x :: xs  binds x to the first elt, xs to ALL the others *)
;;
hd [1;2;3];;
hd [];;

let rec nth l n =
  match l with
  |  [] -> failwith "no nth element in this list"
  |  x :: xs -> if n = 0 then x else nth xs (n-1)
;;
nth [33;22;11] 1;;
nth [33;22;11] 3;;

# List.nth [1;2;3] 2;;
- : int = 3

(2, "hi");;        (* type is int * string -- '*' is like "x" of set theory, a product *)
let tuple = (2, "hi");;
(1,1.1,'c',"cc");;

let mixemup n =
    match n with
    | 0 -> 4
    | 5 -> 0
    | y -> y + 1;; (* default case giving a name to the matched number, x *)

mixemup 3;; (* matches last case and x is bound to the value 3 *)

let five_oh y =
"Hawaii " ^ (match y with
    | 0 -> "Zero"
    | 5 -> "Five"  (* notice the "|" separator between multiple patterns *)
    | _ -> "Nothing") ^ "-O";; (* default case -- _ is a pattern matching anything *)

five_oh 5;;

match ['h';'o'] with      (* recall ['h';'o'] is really 'h' :: ('o' :: []) *)
      | x :: y -> "first clause"
      | _ -> "second clause";;

match [] with
      | x :: y -> "first clause"
      | _ -> "second clause";;

match ['h';'o';'p';' ';'h';'o';'p'] with
      | x :: y -> y
      | _ -> ['0'];;

match ["hi"] with (* ["hi"] is "hi" :: [] *)
      | x :: (y :: z) -> "first"
      | x :: y -> "second"
      | _ -> "third";;

let mm l = match l with
      | [] -> "empty"
      | x :: y -> "non-empty";;

let tuple = (2, "hi", 1.2);;

match tuple with
  (f, s, th) -> s
;;

let mypair = (2.2, 3.3);;
let (f, s) = mypair in f +. s;;
match mypair with (f,s) -> f +. s;; (* same behavior as above let *)

let getSecond t =
  match t with
    (f, s) -> s
;;
let s = getSecond (2, "hi");;
let s = getSecond mypair;;

let getSec t =
  match t with
    (f, s) -> (s :: [],4)
;;

let getHead l =
  match l with
    head :: tail -> head;;

getHead [];;  (* OCaml gives uncaught runtime exception *)

let getHead l =
  match l with
    | [] -> failwith "you dodo"
  |  head :: tail -> head
;;

let rec rev l =
  match l with
  |  [] -> []
  | x :: xs -> rev xs @ [x]
;;
rev [1;2;3];; (* = 1 :: ( 2 :: ( 3 :: [])) *)

rev [1;2;3] 
~= rev [2;3] @ [1]  
~= (rev [3] @ [2]) @ [1] 
~= ((rev [] @ [3]) @ [2]) @ [1]
~= (([] @ [3]) @ [2]) @ [1]
~= [3;2;1]

rev [1;2;3];;
(rev [2;3]) @ [1];;
((rev [3]) @ [2]) @ [1];;
(((rev []) @ [3]) @ [2]) @ [1];;
(([]@[3]) @ [2]) @ [1];;

type comparison = LessThan | EqualTo | GreaterThan;;

let intcmp x y =
    if x < y then LessThan else
        if x > y then GreaterThan else EqualTo;;

match intcmp 4 5 with
  | LessThan -> "less!"
  | EqualTo -> "equal!"
  | GreaterThan -> "greater!";;

type 'a nullable = Null | NotNull of 'a;;

match NotNull(4) with
  | Null -> "null!"
  | NotNull(n) -> (string_of_int n)^" is not null!"
;;

type 'a option = None | Some of 'a *)

Some(4);;
None;;

let gethead l = match l with
  | [] -> None
  | hd :: tl -> Some hd;;

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

let y = 3;;
let x = 5;;
let f z = x + z;;
let x = y;; (* as in previous example, this is a nested definition, not assignment! *)
f (y-1) + x;;

let f x = x + 1;;
let g x = f (f x);;
let shad = f;; (* make a new name for f above *)
(* lets "change" f, say we made an error in its definition above *)
let f x = if x <= 0 then 0 else x + 1;;
g (-5);; (* g still refers to the initial f - !! *)

assert( g (-5) = 0);; (* example of built-in assert in action - returns () if holds, exception if not *)

let g x = f (f x);; (* FIX to get new f: resubmit (identical) g code *)

assert(g (-5) = 0);; (* now it works as we initially expected *)

let rec copy l =
  match l with
  | [] -> []
  | hd :: tl ->  hd::(copy tl);;

let result = copy [1;2;3;4;5;6;7;8;9;10]

let rec copyodd l = match l with
  | [] -> []
  | hd :: tl ->  hd::(copyeven tl)
and  (* new keyword for declaring mutually recursive functions *)
  copyeven l = match l with
  |  [] -> []
  | x :: xs -> copyodd xs;;

copyodd [1;2;3;4;5;6;7;8;9;10];;
copyeven [1;2;3;4;5;6;7;8;9;10];;

let copyodd ll =
    ( let rec
     copyoddlocal l = match l with
      |  [] -> []
      | hd :: tl ->  hd::(copyevenlocal tl)
    and
     copyevenlocal l = match l with
    |        [] -> []
    | x :: xs -> copyoddlocal xs
  in
   copyoddlocal ll
    );;

assert(copyodd [1;2;3;4;5;6;7;8;9;10] = [1;3;5;7;9]);;

let rec timestenlist l =
  match l with
    []    -> []
  | hd::tl -> (hd * 10) :: timestenlist tl;;

timestenlist [3;2;50];;

let rec appendgobblelist l =
  match l with
    []    -> []
  | hd::tl -> (hd ^"gobble") :: appendgobblelist tl;;

appendgobblelist ["have";"a";"good";"day"];;
("have" ^"gobble") :: ("a"^"gobble") :: appendgobblelist ["good";"day"];;

let rec map f l =  (* Notice function f is an ARGUMENT here *)
  match l with
    []    -> []
  | hd::tl -> (f hd) :: map f tl;;

map (fun x -> x * 10) [3;2;50];;

let middle = List.map (function s -> s^"gobble");;
middle ["have";"a";"good";"day"];;

map (fun (x,y) -> x + y) [(1,2);(3,4)];;
let flist = map (fun x -> (fun y -> x + y)) [1;2;4] ;; (* make a list of functions - why not? *)

(* compose_list [f1;..;fn] v = f1 (... (fn v) ... ) *)
let rec compose_list lf v =
  match lf with
  | [] -> v
  | hd :: tl -> hd(compose_list tl v);;

compose_list flist 0;;

let rec fold_left f v l = match l with
    | []   -> v
    | hd::tl -> fold_left f (f v hd) tl (* pass down f v hd as new "v" -- accumulating *)
    ;;

fold_left (fun elt -> fun accum -> elt + accum) 0 [1;2;3];; (* = (((0+1)+2)+3) - 0 on LEFT *)
fold_left (+) 0 [1;2;3];; (* equivalent to previous - built-in operator in parens is function *)

let rec summate accum l = match l with
    | []   -> accum
    | hd::tl -> summate (accum + hd) tl (* pass down f v hd as new "v" -- accumulating *)
    ;;
summate 0 [1;2;3];;

let length l = List.fold_left (fun accum elt -> accum + 1) 0 l;; (* adds accum, ignores elt *)
let rev l = List.fold_left (fun accum elt -> elt::accum) [] l;; (* e.g. rev [1;2;3] = (3::(2::(1::[]))) *)

let rec fold_right f l v = match l with
  | [] -> v
  | hd::tl -> f hd (fold_right f tl v) (* v not changing on recursion here *)
;;
fold_right (+) [1;2;3] 0;; (* = (1+(2+(3+0))) - 0 on right *)

fold_left (fun elt -> fun accum -> "("^elt^"+"^accum^")") "0" ["1";"2";"3"] ;; 
fold_right (fun accum -> fun elt -> "("^accum^"+"^elt^")") ["1";"2";"3"] "0" ;; 

let map f l = List.fold_right (fun elt accum -> (f elt)::accum) l [];;

let map_and_rev f l = List.fold_left (fun accum elt -> (f elt)::accum) [] l ;; (* notice how this reverses *)

let filter f l = List.fold_right (fun elt accum -> if f elt then elt::accum else accum) l [];; 
let rev_slow l = List.fold_right (fun elt accum -> accum @ [elt]) l [];; (* can also fold_right rev with @ *)

let compose g f = (fun x -> g (f x));;

let plus3 x = x+3;;
let times2 x = x*2;;
let times2plus3 = compose plus3 times2;;
times2plus3 10;;
(* equivalent but with anonymous functions: *)
compose (fun x -> x+3) (fun x -> x*2) 10;;

let compose g f x =  g (f x);;
let compose = (fun g -> (fun f -> (fun x -> g(f x))));;

let id = fun x -> x;;
let id x = x;; (* equivalent to above *)
id 3;; (* id applied to int returns an int *)
id true;; (* SAME id applied to bool returns a bool *)

copyodd;;    (* type is 'a list -> 'a list *)
map;;     (* type is ('a -> 'b) -> 'a list -> 'b list *)
compose;; (* type is ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b *)

let add1 = fun x -> x + 1;;
add1 4;;

(function addup -> addup 4)(fun x -> x + 1);;

let id = function x -> x;;

match id (true) with
    true -> id (3)
  | false -> id(4);;

(function mono_id ->
    match mono_id(true) with
                true -> mono_id(3)
              | false -> mono_id(4)) (fun x -> x);;

(function mono_id -> mono_id 4) id;; (* mono_id is solely of type int -> int, thats OK *)

let addC x y = x + y;;
addC 1 2;; (* recall this is the same as '(addC 1) 2' *)
let tmp = addC 1 in tmp 2;; (* the partial application of arguments - result is a function *)

let addC = fun x -> (fun y -> x + y);;
(* yet another identical way .. *)
let addC x = fun y -> x + y;;

(addC 1) 2;; (* same result as above *)

let addCagain = (+);;
(addCagain 1) 2;; (* same result as above *)

let addNC p =
    match p with (x,y) -> x+y;;

let addNC (x, y) = x + y;;

addNC (3, 4);;
addNC 3;; (* will error, need all or no arguments supplied *)

let curry fNC = fun x -> fun y -> fNC (x, y);;
let uncurry fC = fun (x, y) -> fC x y;;

let newaddNC = uncurry addC;;
newaddNC (2,3);;
let newaddC  = curry   addNC;;
newaddC 2 3;;

curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c

let noop1 = curry (uncurry addC);; (* a no-op *)
let noop2 = uncurry (curry addNC);; (* another no-op; noop1 & noop2 together show isomorphism *)

print_string ("hi\n");;

(failwith "BOOM!") + 3 ;;

let f x = if x <= 0 then invalid_arg "Let's be positive, please!" else x + 1;;
f (-5);;

let add (x: float) (y: float) = x +. y;;
let add (x: int) (y: int) = (((x:int) + y) : int);;

type intpair = int * int;;
let f (p : intpair) = match p with
                      (l, r) -> l + r
;;
(2,3);; (* ocaml doesn't call this an intpair by default *)
f (2, 3);; (* still, can pass it to the function expecting an intpair *)
((2,3):intpair);; (* can also explicitly tag data with its type *)

let rec compose_funs lf =
  match lf with
    [] -> (function x -> x)
  | f :: fs -> (function x -> (compose_funs fs) (f x))
;;

let rec compose_funs lf =
  function x ->
    (match lf with
      [] -> x
    | f :: fs -> (compose_funs fs) (f x)
    )
;;

let rec compose_funs lf x =
    match lf with
      [] -> x
    | f :: fs -> (compose_funs fs) (f x)
;;

let composeexample = compose_funs [(function x -> x+1); (function x -> x-1);
                 (function x -> x*3); (function x -> x-1)];;
assert(composeexample 5 = 14);;

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

assert(toUpperCase ['a'; 'q'; 'B'; 'Z'; ';'; '!'] = ['A'; 'Q'; 'B'; 'Z'; ';'; '!']);;

let toUpperCase l = List.map toUpperChar l ;;

let toUpperCase = List.map toUpperChar ;;

let rec nth l n =
  match l with
  |  [] -> failwith "list too short"
  | x :: xs ->
      if n = 0 then
        x
      else
        nth xs (n - 1) (* eureka *)
;;

assert(nth [1;2;3] 0 = 1);;
nth [1;2;3] 1;; (* should return 2 *)
nth [1;2;3] (-1);; (* should raise exception *)
nth [1;2;3] 3;; (* should raise exception *)

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

let isPositive n = n > 0 in
assert(partition isPositive [1; -1; 2; -2; 3; -3] = ([1; 2; 3], [-1; -2; -3]))

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

assert(contains 1 [1; 2; 3])
assert(not(contains 5 [1; 2; 3]))
assert(diff [1;2;3] [3;4;5] = [1; 2])
assert(diff [1;2] [1;2;3] = [])

type mynumber = Fixed of int | Floating of float;;  (* read "|" as "or" *)

Fixed(5);; (* tag 5 as a Fixed *)
Floating 4.0;; (* tag 4.0 as a Floating *)

let pullout_int x =
    match x with
    | Fixed n -> n    (* variants fit well into pattern matching syntax *)
    | Floating z -> int_of_float z;;

pullout_int (Fixed 5);;

let add_num n1 n2 =
   match (n1, n2) with    (* note use of pair here to parallel-match on two variables  *)
     | (Fixed i1, Fixed i2) ->       Fixed   (i1       +  i2)
     | (Fixed i1,   Floating f2) ->  Floating(float i1 +. f2)       (* need to coerce *)
     | (Floating f1, Fixed i2)   ->  Floating(f1       +. float i2) (* ditto *)
     | (Floating f1, Floating f2) -> Floating(f1       +. f2)
;;

add_num (Fixed 123) (Floating 3.14159);;

type complex = CZero | Nonzero of float * float;;

let com = Nonzero(3.2,11.2);;
let zer = CZero;;

type myintlist = Mt | Cons of int * myintlist;; (* Observe: self-referential type *)
let mylisteg = Cons(3,Cons(5,Cons(7,Mt)));; (* equivalent to [3;5;7] *)

type 'a mylist = Mt | Cons of 'a * ('a mylist);;

let mylisteg = Cons(3.,Cons(5.,Cons(7.,Mt)));;

let rec double_list_elts ml =
  match ml with
    | Mt -> Mt (* vs [] -> [] *)
    | Cons(hd,tl) -> Cons(hd *. 2.,double_list_elts tl);; (* vs hd :: tl -> .. *)

double_list_elts mylisteg;;

type 'a btree = Leaf | Node of 'a * 'a btree * 'a btree;;

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

let rec add_gobble binstringtree =
   match binstringtree with
     Leaf -> Leaf
   | Node(y, left, right) ->
       Node(y^"gobble",add_gobble left,add_gobble right)
;;

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

let rec insert x bintree =
   match bintree with
     Leaf -> Node(x, Leaf, Leaf)
   | Node(y, left, right) ->
       if x <= y then
         Node(y, insert x left, right)
       else
         Node(y, left, insert x right)
;;

let goobt = insert "goober " bt;;
bt;; (* observe bt did not change after the insert *)
let gooobt = insert "slacker " goobt;; (* thread in the most recent tree *)

type ratio = {num: int; denom: int};;
let q = {num = 53; denom = 6};;
q.num;;
q.denom;;

let rattoint r =
 match r with
   {num = n; denom = d} -> n / d;;

let rattoint {num = n; denom = d}  =
   n / d;;

let rattoint r  =
   r.num / r.denom;;
rattoint q;;

let add_ratio r1 r2 = {num = r1.num * r2.denom + r2.num * r1.denom; 
                      denom = r1.denom * r2.denom};;
add_ratio {num = 1; denom = 3} {num = 2; denom = 5};;

type newratio = {num: int; coeff: float};; (* shadows ratio's label num *)

fun x -> x.num;; (* x is a newratio, the most recent num field defined *)

fun {num = n; denom = _} -> n;;

let x = ref 4;;    (* always have to declare initial value when creating a reference *)

x + 1;; (* a type error ! *)
!x + 1;; (* need !x to get out the value; parallels *x in C *)
x := 6;; (* assignment - x must be a ref cell.  Returns () - goal is side effect *)
!x + 1;; (* Mutation happened to contents of cell x *)

let x = { contents = 4};; (* identical to x's definition above *)
x := 6;;
x.contents <- 7;;  (* same effect as previous line: backarrow updates a field *)

!x + 1;;
x.contents + 1;; (* same effect as previous line *)

type mutable_point = { mutable x: float; mutable y: float };;
let translate p dx dy =
                p.x <- (p.x +. dx); (* observe use of ";" here to sequence effects *)
                p.y <- (p.y +. dy)  (* ";" is useless without side effects (think about it) *)
                                ;;
let mypoint = { x = 0.0; y = 0.0 };;
translate mypoint 1.0 2.0;;
mypoint;;

type mtree = MLeaf | MNode of int * mtree ref * mtree ref;;

let x = ref 4;;
let f () = !x;; (* This is syntax for a 0-argument function in OCaml - it only takes () as argument *)

x := 234;;
f();;

let x = ref 6;; (* shadowing previous x definition, NOT an assignment to x !! *)
f ();;

let x = ref 1 in
    while !x < 10 do
      print_int !x;
      print_string "\n";
      x := !x + 1;
    done;;

let arrhi = Array.make 100 "";; (* size and initial value are the params here *)
let arr = [| 4; 3; 2 |];; (* another way to make an array *)
arr.(0);; (* access (unfortunately already used [] for lists in the syntax) *)
arr.(0) <- 55;; (* update *)
arr;;

exception Foo;;  (* This is a new form of top-level declaration, along with let, type *)

let f () = raise Foo;; (* note no need to "raises Foo" in the type as in Java *)
f ();;

exception Bar;;

let g _ = 
  (try
    f ()
  with
    Foo ->  5 | Bar -> 3) + 4;; (* Use power of pattern matching in handlers *)
g ();;

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

failwith "Oops";; (* Generic code failure - exception is named Failure *)
invalid_arg "This function works on non-empty lists only";; (* Invalid_argument exception *)

List.map (fun x -> x ^"gobble")["Have";"a";"good";"day"];;

module FSet = (* Module names must start with a Capital Letter *)
struct (* keyword stands for "structure" *)
  exception NotFound (* any top-level definable can be included in a module *)

  type 'a set = 'a list (* sets are just lists but make a new type to keep them distinct *)

  let emptyset : 'a set = []

  let rec add x (s: 'a set) = ((x :: s) : ('a set)) (* observe this is a FUNCTIONAL set - RETURN new *)

  let rec remove x (s: 'a set) =
   match s with
    | [] -> raise NotFound
    | hd :: tl ->
     if hd = x then (tl: 'a set)
     else hd :: remove x tl

  let rec contains x (s: 'a set) =
   match s with
   | [] -> false
   | hd :: tl ->
     if x = hd then true else contains x tl
end
;;

let mySet = FSet.add 5 [];;
let myNextSet = FSet.add 22 mySet;;
FSet.contains 22 mySet;;
FSet.remove 5 myNextSet;;

open FSet;; (* puts an implicit "FSet." in front of all things in FSet; may shadow existing names *)

add "a" ["b"];;
contains "a" ["a"; "b"];;

module type GROWINGSET = (* define a module type (signature) with no remove; not very useful *)
  sig
    exception NotFound
    type 'a set = 'a list
    val emptyset : 'a set
    val add : 'a -> 'a set -> 'a set
    val contains : 'a -> 'a set -> bool
  end
;;

module GrowingSet = (FSet: GROWINGSET);; (* constrain a structure to have that signature *)
GrowingSet.add "a" ["b"];;

(* GrowingSet.remove;; *) (* Error: remove in struct but not in signature! *)

FSet.remove;;  (* This is still fine, remember we are not mutating FSet when making GrowingSet *)

module type HIDDENSET =
  sig
    type 'a set (* hide the type 'a list here by not giving 'a set definition in signature *)
    val emptyset : 'a set
    val add: 'a -> 'a set -> 'a set
    val remove : 'a -> 'a set -> 'a set
    val contains: 'a -> 'a set -> bool
  end
;;

module HiddenSet = (FSet: HIDDENSET);;

HiddenSet.add 3 [];; (* Errors: [] not a set since we HID the fact that sets are really lists *)

let hs = HiddenSet.add 5 (HiddenSet.add 3 HiddenSet.emptyset);; (* now it works - <abstr> result means type is abstract *)
HiddenSet.contains 5 hs;;

module HFSet :
  sig
    type 'a set
    val emptyset : 'a set
    val add: 'a -> 'a set -> 'a set
    val remove : 'a -> 'a set -> 'a set
    val contains: 'a -> 'a set -> bool
  end =
struct
exception NotFound (* any top-level definable can be included in a module *)

type 'a set = 'a list (* sets are just lists but make a new type to keep them distinct *)

let emptyset : 'a set = []

let rec add x (s: 'a set) = ((x :: s) : ('a set)) (* observe this is a FUNCTIONAL set - RETURN new *)

let rec remove x (s: 'a set) =
  match s with
  | [] -> raise NotFound
  | hd :: tl ->
    if hd = x then (tl: 'a set)
    else hd :: remove x tl

let rec contains x (s: 'a set) =
  match s with
  | [] -> false
  | hd :: tl ->
    if x = hd then true else contains x tl
end
;;

let hs = HFSet.add 5 (HFSet.add 3 HFSet.emptyset);; (* same use as before *)

module FSet: sig (* contents of file fSet.mli *) end
          = struct (* contents of file fSet.ml *) end;;

module Main: sig (* contents of main.mli *) end
           = struct (* contents of main.ml *) end;;

#load "fSet.cmo";;
FSet.emptyset;;

module type ORDERED_TYPE =
  sig
    type t
    val compare: t -> t -> comparison
  end;;

module FSetFunctor =
  functor (Elt: ORDERED_TYPE) ->
  struct
    type element = Elt.t (* import the type of elements from the structure *)
    type set = element list

    let empty = []

    let rec add x s =
      match s with
        [] -> [x]
      | hd::tl ->
          match Elt.compare x hd with
            EqualTo   -> s
          | LessThan    -> x :: s
          | GreaterThan -> hd :: add x tl

    let rec contains x s =
      match s with
        [] -> false
      | hd::tl ->
          match Elt.compare x hd with
            EqualTo   -> true
          | LessThan    -> false
          | GreaterThan -> contains x tl
  end;;

module OrderedInt =
  struct
    type t = int
    let compare x y =
      if x = y then
    EqualTo
      else
    if x < y then
      LessThan
    else
      GreaterThan
  end;;

module OrderedIntSet = FSetFunctor(OrderedInt);; (* note how this looks like a function application *)

let myOrderedIntSet = OrderedIntSet.add 5 OrderedIntSet.empty;;
OrderedIntSet.contains 3 myOrderedIntSet;;

module OrderedString =
struct
  type t = string
  let compare x y =
    if x = y then EqualTo
    else if x < y then LessThan
    else GreaterThan
end;;

module OrderedStringSet = FSetFunctor(OrderedString);; (* a DIFFERENT instantiation of same *)

let myOrderedStringSet = OrderedStringSet.add "abc" OrderedStringSet.empty;;

module type SETFUNCTOR = (* below is the syntax for a signature of a functor *)
    functor (Elt: ORDERED_TYPE) ->
  sig
    type element = Elt.t      (* concrete *)
    type set                  (* abstract *)
    val empty : set
    val add : element -> set -> set
    val contains : element -> set -> bool
  end;;

module AbstractSet = (FSetFunctor : SETFUNCTOR);; (* slap that sig on a functor *)
module AbstractIntSet = AbstractSet(OrderedInt);;

AbstractIntSet.add 5 AbstractIntSet.empty;;

