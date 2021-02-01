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
  |  [] -> None
  |  x :: xs -> Some x (* the pattern x :: xs  binds x to the first elt, xs to ALL the others *)
;;
hd [1;2;3];;
hd [1];; (* [1] is 1 :: [] - !  So the head is 1. *)
hd [];;

let rec nth l n =
  match l with
  |  [] -> failwith "no nth element in this list"
  |  x :: xs -> if n = 0 then x else nth xs (n-1)
;;
nth [33;22;11] 1;;
nth [33;22;11] 3;;

let dumb l = match l with
      | x :: y -> x;;
dumb [1;2;3];; (* this works to return head of list but.. *)
dumb [];; (* runtime error here *)

# List.nth [1;2;3] 2;;
- : int = 3

List.length ["d";"ss";"qwqw"];;
List.concat [[1;2];[22;33];[444;5555]];;
List.append [1;2] [3;4];; 
[1;2] @ [3;4] (* Use this equivalent infix syntax for append *)

# List.length;;
- : 'a list -> int = <fun>
# List.concat;;
- : 'a list list -> 'a list = <fun>
# List.append;;
- : 'a list -> 'a list -> 'a list = <fun>

let rec rev l =
  match l with
  |  [] -> []
  | x :: xs -> rev xs @ [x]
;;
rev [1;2;3];; (* recall [1;2;3] is equivalent to 1 :: ( 2 :: ( 3 :: [])) *)

rev [1;2;3] 
~= rev (1 :: [2;3]) (by the meaning of the [...] list syntax)
~= (rev [2;3]) @ [1]  (the second pattern is matched: x is 1, xs is [2;3] and run the match body)
~= (rev [3] @ [2]) @ [1]  (same thing for the rev [2;3] expression - plug in its elaboration)
~= ((rev [] @ [3]) @ [2]) @ [1]
~= (([] @ [3]) @ [2]) @ [1]
~= [3;2;1] (by the meaning of append)

(2, "hi");;        (* type is int * string -- '*' is like "x" of set theory, a product *)
let tuple = (2, "hi");;
(1,1.1,'c',"cc");;

let tuple = (2, "hi", 1.2);;

match tuple with
  (f, s, th) -> s;;

(* shorthand for the above - only one pattern, can use let syntax *)
let (f, s, th) = tuple in s;;

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

let rec appendgobblelist l =
  match l with
  | [] -> []
  | hd::tl -> (hd ^"gobble") :: appendgobblelist tl;;

appendgobblelist ["have";"a";"good";"day"];;
("have" ^"gobble") :: ("a"^"gobble") :: appendgobblelist ["good";"day"];;

let rec map f l =  (* function f is an argument here *)
  match l with
  |  [] -> []
  | hd::tl -> (f hd) :: map f tl;;

let middle = map (function s -> s^"gobble");;
middle ["have";"a";"good";"day"];;

map (fun (x,y) -> x + y) [(1,2);(3,4)];;
let flist = map (fun x -> (fun y -> x + y)) [1;2;4] ;; (* make a list of functions - why not? *)

let rec fold_left f v l = match l with
    | []   -> v
    | hd::tl -> fold_left f (f v hd) tl (* pass down f v hd as "the new v" -- accumulating *)
    ;;

fold_left (fun elt -> fun accum -> elt + accum) 0 [1;2;3];; (* = (((0+1)+2)+3) - 0 on LEFT *)
fold_left (+) 0 [1;2;3];; (* equivalent to previous *)

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
fold_right (+) [1;2;3] 0;; (* = (1+(2+(3+0))) - observe the 0 is on the right *)

fold_left (fun elt -> fun accum -> "("^elt^"+"^accum^")") "0" ["1";"2";"3"] ;; 
fold_right (fun accum -> fun elt -> "("^accum^"+"^elt^")") ["1";"2";"3"] "0" ;; 

let map f l = List.fold_right (fun elt accum -> (f elt)::accum) l [];;

let map_and_rev f l = List.fold_left (fun accum elt -> (f elt)::accum) [] l ;; (* notice how this reverses *)

let filter f l = List.fold_right (fun elt accum -> if f elt then elt::accum else accum) l [];; 
let rev l = List.fold_right (@) l [];;

let nth_end l n = List.nth (List.rev l) n;;

let nth_end l n = l |> List.rev |> (Fun.flip(List.nth) n);;

let compose g f = (fun x -> g (f x));;

let plus3 x = x+3;;
let times2 x = x*2;;
let times2plus3 = compose plus3 times2;;
times2plus3 10;;
(* equivalent but with anonymous functions: *)
compose (fun x -> x+3) (fun x -> x*2) 10;;

let compose g f x =  g (f x);;
let compose = (fun g -> (fun f -> (fun x -> g(f x))));;

let addC x y = x + y;;
addC 1 2;; (* recall this is the same as '(addC 1) 2' *)
let tmp = addC 1 in tmp 2;; (* the partial application of arguments - result is a function *)

let addC = fun x -> (fun y -> x + y);;
(* and, yet another identical way .. *)
let addC x = fun y -> x + y;;
(* Yet one more, this is the built-in (+) *)
(+);;

let addNC p =
    match p with (x,y) -> x+y;;

let addNC (x, y) = x + y;;

addNC (3, 4);;
addNC 3;; (* errors, need all or no arguments supplied *)

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

let g _ = (* aside: "_" notates a variable that can never be accessed *)
  (try f ()
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

FSet.emptyset;;

