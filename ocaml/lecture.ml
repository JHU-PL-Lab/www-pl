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

if (x = 3) then (5 + 35) else 6;; (* ((x==3)?5:6)+1 in C *)
(if (x = 3) then 5 else 6) * 2;;
(* (if (x = 3) then 5.4 else 6) * 2;; *) (* type errors:  two branches of if must have same type *)

let rec fib n =     (* the "rec" keyword needs to be added to allow recursion *)
  if n <= 0 then 0
  else if n = 1 then 1
  else fib (n - 1) + fib (n - 2);; (* notice again everything is an expression, no "return" *)

fib 10;; (* get the 10th Fibonacci number *)

let add1 x = x + 1;; (* a normal add1 definition *)
let anon_add1 = (function x -> x + 1);; (* equivalent anonymous version; "x" is argument here *)
let anon_add1_fun = (fun x -> x + 1);; (* `function` can usually be shortened to `fun` *)
add1 3;;
(add1 4) * 7;; 
((fun x -> x + 1) 4) * 7;; (* can inline anonymous function definition; makes no sense here but will later *)

let add x y = x + y;;
add 3 4;;
(add 3) 4;; (* same meaning as previous application -- two applications, " " associates LEFT *)
let add3 = add 3;; (* No need to give all arguments at once!  Type of add is int -> (int -> int) - "CURRIED" *)
add3 4;;
add3 20;;
(+) 3 4;; (* Putting () around any infix operator turns it into a 2-argument function: `(+)` is same as our `add` above *)

add3 (3 * 2);;
add3 3 * 2;; (* NOT the previous - this is the same as (add3 3) * 2 - application binds tighter than `*` *)
add3 @@ 3 * 2;; (* LIKE the original - @@ is like the " " for application but binds LOOSER than other ops *)

let add (x : int) (y : int) : int = x + y;;

Some 5;;
(*  - : int option = Some 5 *)

None;;
(* - : 'a option = None *)

let div_exn m n = if n = 0 then failwith "divide by zero is bad!" else m / n;;
div_exn 3 4;;

let l1 = [1; 2; 3];;
let l2 = [1; 1+1; 1+1+1];;
let l3 = ["a"; "b"; "c"];;
(* let l4 = [1; "a"];; *) (* error - All elements must have same type *)
let l5 = [];; (* empty list *)

3 :: [] (* also written [3], a singleton list -- tree with root ::, left sub tree 3, right sub tree empty list *) 
let l1 = 1 :: (2 :: (3 :: []));; (* equivalent to [1;2;3] *)
let l0 = 0 :: l1;; (* fast, just makes one new node, left is 0 right is l1 - SHARE it *)
l1;; (* Notice that l1 did not change even though we put a 0 on - immutable always! *)
[1; 2; 3] @ [4; 5];; (* appending lists - slower, needs to cons 3 then 2 then 1 on front of [4;5] *)

let hd l =
  match l with
  |  [] -> None
  |  x :: xs -> Some x (* the pattern x :: xs  binds x to the first elt, xs to ALL the others *)
;;
hd [1;2;3];; (* [1;2;3] is 1 :: [2;3] So the head is 1. *)
hd [1];; (* [1] is 1 :: []  So the head is 1. *)
hd [];;

let rec append l1 l2 =
  match l1 with
  |  [] -> l2
  |  x :: xs -> x :: (append xs l2) (* assume function works for shorter lists like xs *)
;;
append [1;2;3] [4;5];; (* Recall `[1;2;3]` is `1 :: [2;3]` so in first call x is 1, xs is [2;3] *)
1 :: (append [2;3] [4;5]);; (* This is what the first recursive call is performing *)

let rec nth l n =
  match l with
  |  [] -> failwith ("no "^(Int.to_string n)^"th element in this list")
  |  x :: xs -> if n = 0 then x else nth xs (n-1) (* to get nth elt in list, get n-1-th elt from tail *)
;;
nth [33;22;11] 0;; (* Recall [`33;22;11]` is `33 :: [22;11]` so in first call x is 33 *)
(* nth [33;22;11] 3;; *) (* Hits failure case; could have instead returned Some/None *)

let dumb l = match l with
      | x :: y -> x;;
dumb [1;2;3];; (* this works to return head of list but.. *)
(* dumb [];; *) (* runtime error here *)

List.nth [1;2;3] 2;;
(* - : int = 3 *)

List.length ["d";"ss";"qwqw"];;
List.concat [[1;2];[22;33];[444;5555]];;
List.append [1;2] [3;4];; 
[1;2] @ [3;4];; (* Use this equivalent infix syntax for append *)

List.length;;
(* - : 'a list -> int = <fun> *)
List.concat;;
(* - : 'a list list -> 'a list = <fun> *)
List.append;;
(* - : 'a list -> 'a list -> 'a list = <fun> *)

let rec rev l =
  match l with
  |  [] -> []
  | x :: xs -> rev xs @ [x]
;;
rev [1;2;3];; (* recall [1;2;3] is equivalent to 1 :: ( 2 :: ( 3 :: [])) *)

(2, "hi");;             (* type is int * string -- '*' is like "x" of set theory, a product *)
let tuple = (2, "hi");; (* tuple elements separated by commas, list elements by semicolon *)
(1,1.1,'c',"cc");;

let tuple = (2, "hi", 1.2);;

match tuple with
  (f, s, th) -> s;;

(* shorthand for the above - only one pattern, can use let syntax *)
let (f, s, th) = tuple in s;;

(* Parens around tuple not always needed *)
let i,b,f = 4, true, 4.4;;

(* Pattern matching on a pair allows parallel pattern matching *)

let rec eq_lists l1 l2 = 
  match l1,l2 with
  | [], [] -> true
  | x::xs, x'::xs' -> if x <> x' then false else eq_lists xs xs'
  | _ -> false (* lengths must differ if this case is hit *)

let y = 3;;
let x = 5;;
let f z = x + z;;
let x = y;; (* this is a shadowing re-definition, not an assignment! *)
f y;; (* 3 + 3 or 5 + 3 - ??   Answer: the latter. *)

(let y = 3 in
 ( let x = 5 in
   ( let f z = x + z in
     ( let x = y in  (* this is a shadowing re-definition of x, NOT an assignment *)
       (f y)
     )
   )
 )
)
;;

let f x = x + 1;;
let g x = f (f x);;
let f_alias = f;; (* make a new name for f above *)
(* lets "change" f, say we made an error in its definition above *)
let f x = if x <= 0 then 0 else x + 1;;
f_alias;; (* it is the original f, similar to how let works on integer variables above *)
g (-5);; (* g still refers to the initial f - !! *)
let g x = f (f x);; (* FIX to get new f: resubmit (identical) g code *)
g (-5);; (* works now *)

let rec copy l =
  match l with
  | [] -> []
  | hd :: tl ->  hd::(copy tl);;

let result = copy [1;2;3;4;5;6;7;8;9;10]

let rec copy_odd l = match l with
  | [] -> []
  | hd :: tl ->  hd::(copy_even tl)
and  (* new keyword for declaring mutually recursive functions *)
  copy_even l = match l with
  |  [] -> []
  | x :: xs -> copy_odd xs;;

copy_odd [1;2;3;4;5;6;7;8;9;10];;
copy_even [1;2;3;4;5;6;7;8;9;10];;

let copy_odd ll =
  let rec copy_odd_local l = match l with
    |  [] -> []
    | hd :: tl ->  hd::(copy_even_local tl)
  and
    copy_even_local l = match l with
    |        [] -> []
    | x :: xs -> copy_odd_local xs
  in
  copy_odd_local ll;;

assert(copy_odd [1;2;3;4;5;6;7;8;9;10] = [1;3;5;7;9]);;

let rec append_gobble l =
  match l with
  | [] -> []
  | hd::tl -> (hd ^"-gobble") :: append_gobble tl;;

append_gobble ["have";"a";"good";"day"];;
("have" ^"gobble") :: ("a"^"gobble") :: append_gobble ["good";"day"];;

let rec map (f : 'a -> 'b) (l : 'a list) : 'b list =  (* function f is an argument here *)
  match l with
  | [] -> []
  | hd::tl -> (f hd) :: map f tl;;

let another_append_gobble = map (fun s -> s^"-gobble");; (* give only the first argument -- Currying *)
another_append_gobble ["have";"a";"good";"day"];;
map (fun s -> s^"-gobble") ["have";"a";"good";"day"];; (* Or, don't give the intermediate application a name *)

map (fun (x,y) -> x + y) [(1,2);(3,4)];;
let flist = map (fun x -> (fun y -> x + y)) [1;2;4] ;; (* make a list of functions - why not? *)

let to_upper_char c =
  let c_code = Char.code c in
  if c_code >= 97 && c_code <= 122 then Char.chr (c_code - 32)
  else c;;

let rec to_upper_case l =
  match l with
   | [] -> []
   | c :: cs -> to_upper_char c :: to_upper_case cs
;;

assert(to_upper_case ['a'; 'q'; 'B'; 'Z'; ';'; '!'] = ['A'; 'Q'; 'B'; 'Z'; ';'; '!']);;

let to_upper_case l = List.map to_upper_char l ;;

let to_upper_case = List.map to_upper_char ;;

let rec partition p l =
  match l with
  |[] -> ([],[])
  | hd :: tl ->
    let (posl,negl) = partition p tl in
    if (p hd) then (hd :: posl,negl)
    else (posl,hd::negl);;

let is_positive n = n > 0 in
assert(partition is_positive [1; -1; 2; -2; 3; -3] = ([1; 2; 3], [-1; -2; -3]))

let rec contains x l =
  match l with
  | [] -> false
  | y :: ys -> x = y || contains x ys
;;

let rec diff l1 l2 =
  match l1 with
  | [] -> []
  | x :: xs ->
      if contains x l2 then diff xs l2
      else x :: diff xs l2
;;

assert(contains 1 [1; 2; 3]);;
assert(not(contains 5 [1; 2; 3]));;
assert(diff [1;2;3] [3;4;5] = [1; 2]);;
assert(diff [1;2] [1;2;3] = []);;

let rec summate_right l = match l with
    | []   -> 0 (* this is the initial number to start with; a special case *)
    | hd::tl ->  (+) hd (summate_right tl) (* assume by induction this will summate tl, add hd *)
    ;;
summate_right [1;2;3];;

let rec summate_right l init = match l with
    | []   -> init (* init is the initial number to start with *)
    | hd::tl ->  (+) hd (summate_right tl init)
    ;;
summate_right [1;2;3] 0;;

let rec fold_right f l init = match l with
  | [] -> init
  | hd::tl -> f hd (fold_right f tl init) (* same code as above just extracting (+) as a parameter *)
;;
let summate_right' = fold_right (+);; (* re-constitute the version above by feeding in (+) *)
fold_right (+) [1;2;3] 0;; (* = (1+(2+(3+0))) - observe the 0 is on the right *)

let rev l = List.fold_right (fun elt accum -> accum @ [elt]) l [];;
let map f l = List.fold_right (fun elt accum -> (f elt)::accum) l [];;
let filter f l = List.fold_right (fun elt accum -> if f elt then elt::accum else accum) l [];; 

let rec rev’ l init = match l with
    | []   -> init 
    | hd::tl ->  (@) (rev’ tl init) [hd] (* recall our previous rev was identical but @ infix *)
        ;;
rev’ [1;2;3] [];;

let rec summate_left accum l = match l with
    | []   -> accum
    | hd::tl -> summate_left ((+) accum hd) tl (* pass down accum + hd as new "accum" -- accumulating *)
    ;;
summate_left 0 [1;2;3];; (* ~= summate_left (0+1) [2;3] ~= summate_left (1+2) [3] = summate_left (3+3) [] ~= 6 *)

let rec fold_left f accum l = match l with
    | []   -> accum
    | hd::tl -> fold_left f (f accum hd) tl
    ;;

fold_left (+) 0 [1;2;3];;

let length l = List.fold_left (fun accum elt -> accum + 1) 0 l;; (* adds accum, ignores elt *)
let rev l = List.fold_left (fun accum elt -> elt::accum) [] l;; (* e.g. rev [1;2;3] = (3::(2::(1::[]))) - much faster! *)

fold_left (fun elt -> fun accum -> "("^elt^" op "^accum^")") "z" ["a";"b";"c"] ;;  (* "(((z op a) op b) op c)" *)
fold_right (fun accum -> fun elt -> "("^accum^" op "^elt^")") ["a";"b";"c"] "z" ;; (* "(a op (b op (c op z)))" *)

let nth_end l n = List.nth (List.rev l) n;;

let nth_end l n = l |> List.rev |> (Fun.flip(List.nth) n);;

let compose g f = (fun x -> g (f x));;
compose (fun x -> x+3) (fun x -> x*2) 10;;

let add_c x y = x + y;; (* recall type is int -> int -> int which is int -> (int -> int) *)
add_c 1 2;; (* recall this is the same as '(add_c 1) 2' *)
let tmp = add_c 1 in tmp 2;; (* the partial application of arguments - tmp is a function *)
(* An equivalent way to define `add_c`, clarifying what the above means *)
let add_c = fun x -> (fun y -> x + y);;
(* and, yet another identical way .. lots of equivalent notation in OCaml *)
let add_c = fun x y -> x + y;;
(* yet one more, the built-in (+) *)
let add_c = (+);;

let add_nc (x,y) = x+y;; (* type is int * int -> int - no way to partially apply *)

let curry fnc = fun x -> fun y -> fnc (x, y);;
let uncurry fc = fun (x, y) -> fc x y;;

let new_add_nc = uncurry add_c;;
new_add_nc (2,3);;
let new_add_c  = curry   add_nc;;
new_add_c 2 3;;

let noop1 = curry (uncurry add_c);; (* a no-op *)
let noop2 = uncurry (curry add_nc);; (* another no-op; noop1 & noop2 together show isomorphism *)

print_string ("hi\n");;

let add (x: float) (y: float) : int = Float.to_int (x +. y);;

type intpair = int * int;;
let f (p : intpair) : int = match p with
                      (l, r) -> l + r
;;
(2,3);; (* ocaml doesn't call this an intpair by default *)
f (2, 3);; (* still, can pass it to the function expecting an intpair *)
((2,3):intpair);; (* can also explicitly tag data with its type *)

type mynumber = Fixed of int | Floating of float;;  (* read "|" as "or" *)

Fixed(5);; (* tag 5 as a Fixed *)
Fixed 5;; (* parens optional as is often the case in OCaml *)
Floating 4.0;; (* tag 4.0 as a Floating *)

let ff_as_int x =
    match x with
    | Fixed n -> n    (* variants fit well into pattern matching syntax *)
    | Floating z -> int_of_float z;;

ff_as_int (Fixed 5);; (* beware that ff_as_int Fixed(5) won't parse properly!!  Super commmon error!!! 
                         ff_as_int @@ Fixed 5 will though *)

let add_num n1 n2 =
   match n1, n2 with    (* note use of pair here to parallel-match on two variables  *)
     | Fixed i1, Fixed i2 -> Fixed   (i1 + i2)
     | Fixed i1, Floating f2 -> Floating(float i1 +. f2) (* need to coerce with `float` function *)
     | Floating f1, Fixed i2 -> Floating(f1 +. float i2) (* ditto *)
     | Floating f1, Floating f2 -> Floating(f1 +. f2)
;;

add_num (Fixed 10) (Floating 3.14159);;

type complex = CZero | Nonzero of float * float;;

let com = Nonzero(3.2,11.2);;
let zer = CZero;;

type myintlist = Mt | Cons of int * myintlist;; (* Observe: self-referential type *)
let mylisteg = Cons(3,Cons(5,Cons(7,Mt)));; (* equivalent in spirit to [3;5;7] *)

type 'a mylist = Mt | Cons of 'a * ('a mylist);;

let mylisteg = Cons(3,Cons(5,Cons(7,Mt)));;

let rec map ml f =
  match ml with
    | Mt -> Mt
    | Cons(hd,tl) -> Cons(f hd,map tl f);;

let map_eg = map mylisteg (fun x -> x - 1);;

type 'a btree = Leaf | Node of 'a * 'a btree * 'a btree;;

let whack = Node("whack!",Leaf, Leaf);;
let bt = Node("fiddly ",
            Node("backer ",
               Leaf,
               Node("crack ",
                  Leaf,
                  Leaf)),
            whack);;

(* Type error; like lists, tree data must have uniform type: *)
(* Node("fiddly",Node(0,Leaf,Leaf),Leaf);; *)

let rec add_gobble binstringtree =
   match binstringtree with
   | Leaf -> Leaf
   | Node(y, left, right) ->
       Node(y^"gobble",add_gobble left,add_gobble right)
;;

let rec lookup x bintree =
  match bintree with
  | Leaf -> false
  | Node (y, left, right) ->
      if x = y then true else if x < y then lookup x left else lookup x right
;;

lookup "whack!" bt;;
lookup "flack" bt;;

let rec insert x bintree =
   match bintree with
   | Leaf -> Node(x, Leaf, Leaf)
   | Node(y, left, right) ->
       if x <= y then Node(y, insert x left, right)
       else Node(y, left, insert x right)
;;

let goobt = insert "goober " bt;;
bt;; (* observe bt did not change after the insert *)
let gooobt = insert "slacker " goobt;; (* pass in goobt to accumulate both additions *)
let manyt = List.fold_left (Fun.flip insert) Leaf ["one";"two";"three";"four"] (* folding helps *)

type ratio = {num: int; denom: int};;
let q = {num = 53; denom = 6};;

let rattoint r =
 match r with
   {num = n; denom = d} -> n / d;;

let rat_to_int {num = n; denom = d} =  n / d;;

let unhappy_rat_to_int r  =
   r.num / r.denom;;

let unhappy_add_ratio r1 r2 = 
  {num = r1.num * r2.denom + r2.num * r1.denom; 
   denom = r1.denom * r2.denom};;

unhappy_add_ratio {num = 1; denom = 3} {num = 2; denom = 5};;

let happy_add_ratio {num = n1; denom = d1} {num = n2; denom = d2} = 
  {num = n1 * d2 + n2 * d1; denom = d1 * d2};;

let x = ref 4;;    (* always have to declare initial value when creating a reference; type is `int ref` here *)

(* x + 1;; *) (* a type error ! *)
!x + 1;; (* need `!x` to get out the value; parallels `*x` in C *)
x := 6;; (* assignment - x must be a ref cell.  Returns () - goal is side effect *)
!x;; (* Mutation happened to contents of cell x *)
let x_alias = x;; (* make another name for x since we are about to shadow it *)
let x = ref "hi";; (* does NOT mutate x above, instead another shadowing definition *)
!x_alias;; (* confirms the previous line was not a mutation, just a shadowing *)

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

let arr = [| 4; 3; 2 |];; (* one way to make a new array *)
arr.(0);; (* access (unfortunately already used [] for lists in the syntax) *)
arr.(0) <- 5;; (* update *)
arr;;

exception Goo of string;; (* Exception named `Goo` has a string payload *)

let f _ = raise (Goo "keyboard on fire");;
(* f ();; *) (* raises the exception to the top level *)
(* (f ()) + 1;; *) (* recall that exceptions blow away the context *)

let g () =
  try
    f ()
  with (* "catch" in Java *)
      Goo s ->
      (print_string("exception raised: ");
       print_string(s);print_string("\n"))
;;
g ();;

