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
(add1 4) * 7;;  (* note this is the same as add1 4 * 7 - application "binds tightest" *)
((fun x -> x + 1) 4) * 7;; (* can inline anonymous function; useless here but useful later *)

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
let l0 = 0 :: l1;; (* fast, just makes one new node, left is 0 right is l1 - l1 is shared with l0 *)
l1;; (* Notice that l1 did not change even though we put a 0 on - immutable always! *)
[1; 2; 3] @ [4; 5];; (* appending lists - slower, needs to cons 3 then 2 then 1 on front of [4;5] *)

let hd l =
  match l with
  |  [] -> None
  |  hd :: tl -> Some x (* the pattern hd :: tl  binds hd to the first elt, tl to ALL the others *)
;;
hd [1;2;3];; (* [1;2;3] is 1 :: [2;3] So the head is 1. *)
hd [1];; (* [1] is 1 :: []  So the head is 1. *)
hd [];;

let rec append l1 l2 =
  match l1 with
  |  [] -> l2
  |  hd :: tl -> hd :: (append tl l2) (* assume function works for shorter lists like tl *)
;;
append [1;2;3] [4;5];; (* Recall `[1;2;3]` is `1 :: [2;3]` so in first call hd is 1, tl is [2;3] *)
1 :: (append [2;3] [4;5]);; (* This is what the first recursive call is performing *)

let rec keep (l : 'a list) (p : 'a -> bool) : 'a list = 
  match l with
  |  [] -> [] (* no elements to check p on *)
  |  hd :: tl -> if p hd then hd :: keep tl p else keep tl p
;;
keep [33;-22;11] (fun n -> n > 0);; (* keep only the elements greater than 0 *)
keep ["hello";"this";"is";"";"fun";""] (fun s -> s <> "");; (* keep non-empty strings *)

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
  | hd :: tl -> rev tl @ [hd] (* Assume by induction that rev tl "works" since its a shorter list. *)
;;
rev [1;2;3];; (* recall [1;2;3] is equivalent to 1 :: [2;3] *)

(2, "hi");;             (* type is int * string -- '*' is like "x" of set theory, a product *)
let tuple = (2, "hi");; (* tuple elements separated by commas, list elements by semicolon *)
(1,1.1,'c',"cc");;

let tuple = (2, "hi", 1.2);;

match tuple with
  | (f, s, th) -> s;;

(* shorthand for the above - only one pattern, can use let syntax *)
let (f, s, th) = tuple in s;;

(* Parens around tuple not always needed *)
let i,b,f = 4, true, 4.4;;

(* Pattern matching on a pair allows parallel pattern matching *)

let rec eq_lists l1 l2 = (* note `l1 = l2` in OCaml will work so no need to actually write this .. *)
  match l1,l2 with
  | [], [] -> true
  | hd :: tl, hd' :: tl' -> if hd <> hd' then false else eq_lists tl tl'
  | _ -> false (* _ is a catch-all pattern; lengths must differ if this case is hit *)

let y = 3;;
let x = 5;;
let f z = x + z;;
let x = y;; (* this is a shadowing re-definition, not an assignment! *)
f y;; (* 3 + 3 or 5 + 3 - ?? Answer: the latter since x WAS 5 at point of f def'n. *)

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
(* lets "change" f, say we made an error in its definition above *)
let f x = if x <= 0 then 0 else x + 1;;
g (-5);; (* g still refers to the initial f - !! *)
let g x = f (f x);; (* FIX g to refer to new f: resubmit (identical) g code *)
g (-5);; (* sees new f now *)

let rec copy l =
  match l with
  | [] -> []
  | hd :: tl ->  hd::(copy tl);;

let result = copy [1;2;3;4;5;6;7;8;9;10]

let rec copy_odd l = match l with
  | [] -> []
  | hd :: tl ->  hd :: (copy_even tl) (* keep the head in this case *)
and  (* new keyword for declaring mutually recursive functions *)
  copy_even l = match l with
  |  [] -> []
  | hd :: tl -> copy_odd tl;; (* throw away the head in this case *)

copy_odd [1;2;3;4;5;6;7;8;9;10];;
copy_even [1;2;3;4;5;6;7;8;9;10];;

let copy_odd ll =
  let rec copy_odd_local l = match l with
    |  [] -> []
    | hd :: tl ->  hd::(copy_even_local tl)
  and
    copy_even_local l = match l with
    |        [] -> []
    | hd :: tl -> copy_odd_local tl
  in
  copy_odd_local ll;;

assert(copy_odd [1;2;3;4;5;6;7;8;9;10] = [1;3;5;7;9]);;

let rec append_gobble l =
  match l with
  | [] -> []
  | hd::tl -> (hd ^ "-gobble") :: append_gobble tl;;

append_gobble ["have";"a";"good";"day"];;
("have" ^"gobble") :: ("a"^"gobble") :: append_gobble ["good";"day"];;

let rec map (f : 'a -> 'b) (l : 'a list) : 'b list =  (* function f is an argument here *)
  match l with
  | [] -> []
  | hd::tl -> (f hd) :: map f tl;;

let another_append_gobble = map (fun s -> s ^ "-gobble");; (* give only the first argument -- Currying *)
another_append_gobble ["have";"a";"good";"day"];;
map (fun s -> s^"-gobble") ["have";"a";"good";"day"];; (* don't have to name the intermediate application *)

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
  | hd :: tl ->
      if contains hd l2 then diff tl l2
      else hd :: diff tl l2
;;

assert(contains 1 [1; 2; 3]);;
assert(not(contains 5 [1; 2; 3]));;
assert(diff [1;2;3] [3;4;5] = [1; 2]);;
assert(diff [1;2] [1;2;3] = []);;

let rec list_max_aux n l = (* invariant: n is the maximal integer seen thus far *)
  match l with 
  | [] -> n
  | hd :: tl -> if hd > n then list_max_aux hd tl else list_max_aux n tl
let list_max = list_max_aux Int.min_int (* prime the pump *)

let rec char_list_to_string l =
  match l with 
  | [] -> "" (* "" is the "base case code" we will want to plug in later *)
  | elt :: elts ->  (* we are calling the current list element `elt`, thats the convention in folding  *)
    let accum = char_list_to_string elts in (* this is what `accum` is, the *accumulation* from recursing *)
      (Char.escaped elt)^accum;;  (* this is the "recursive case" code: put elt on front of result thus far *)
char_list_to_string ['h';'e';'l';'l';'o';'!'];;

let rec char_list_to_string l =
  match l with 
  | [] -> ""
  | elt :: elts -> 
    let accum = char_list_to_string elts in 
      let f = fun elt accum -> (Char.escaped elt)^accum in f elt accum (* same effect as above, we did a no-op *)

let rec fold_right f l init =
  match l with 
  | [] -> init (* "" is now the parameter init *)
  | elt :: elts -> 
    let accum = fold_right f elts init in (* same as above but forwarding extra parameters f / init *)
      f elt accum (* same code as above but f passed in now as a parameter *)

fold_right (fun elt accum -> (Char.escaped elt)^accum) ['a';'b';'c'] ""

let rec summate_right l = match l with
    | []   -> 0
    | elt :: elts ->  (+) elt (summate_right elts)
    ;;
summate_right [1;2;3];; (* = (1+(2+(3+0))) - observe we start from *right* side, fold_right is fold-starting-from-right *)

List.fold_right (+) [1;2;3] 0

List.fold_right (fun elt accum -> elt + accum) [1;2;3] 0

let rev l = List.fold_right (fun elt accum -> accum @ [elt]) l [];; (* `accum` is reversed tail, `elt` is current head *)
let map f l = List.fold_right (fun elt accum -> (f elt)::accum) l [];; (* `accum` has f applied to all elts in tail *)
let filter f l = List.fold_right (fun elt accum -> if f elt then elt::accum else accum) l [];; 

let rec list_max_aux accum l = (* invariant: accum is the maximal integer seen thus far *)
  match l with 
  | [] -> accum (* we are 100% done, and by the invariant this is the biggest integer seen to its the answer *)
  | elt :: elts -> if elt > accum then list_max_aux elt elts else list_max_aux accum elts;;
list_max_aux (Int.min_int) [1;2;3;2;-1];;

let rec list_max_aux accum l = 
  match l with 
  | [] -> accum
  | elt :: elts -> let f = fun accum elt -> if elt > accum then elt else accum in
       list_max_aux (f accum elt) elts

let rec fold_left f accum l = 
  match l with 
  | [] -> accum
  | elt :: elts ->  fold_left f (f accum elt) elts;;

fold_left (fun accum elt -> if elt > accum then elt else accum) (Int.min_int) [1;2;3;2;-1];;

List.fold_left (+) 0 [1;2;3];; (* computes ((0 + 1) + 2) + 3); note using library function version List.fold_left here *)

fold_left (^) "z" ["a";"b";"c"] ;;
fold_right (^) ["a";"b";"c"] "z" ;;

let length l = List.fold_left (fun accum elt -> accum + 1) 0 l;; (* adds accum, ignores elt *)
let rev l = List.fold_left (fun accum elt -> elt::accum) [] l;; (* e.g. rev [1;2;3] = (3::(2::(1::[]))) - much faster! *)

let nth_end l n = List.nth (List.rev l) n;;

let nth_end l n = l |> List.rev |> (Fun.flip(List.nth) n);;

let compose g f = (fun x -> g (f x));;
compose (fun x -> x+3) (fun x -> x*2) 10;;

let add_c x y = x + y;; (* recall type is int -> int -> int which is int -> (int -> int) *)
add_c 1 2;; (* recall this is the same as '(add_c 1) 2' *)
let tmp = add_c 1 in tmp 2;; (* the partial application of arguments - tmp is a function *)
(* An equivalent way to define `add_c`, clarifying what the above means *)
let add_c = fun x -> (fun y -> x + y);;

let add_nc (x,y) = x + y;; (* type is int * int -> int - no way to partially apply *)

let curry fnc = fun x -> fun y -> fnc (x, y);;
let uncurry fc = fun (x, y) -> fc x y;;

let new_add_nc = uncurry add_c;;
new_add_nc (2,3);;
let new_add_c  = curry   add_nc;;
new_add_c 2 3;;

let noop1 = curry (uncurry add_c);; (* a no-op *)
let noop2 = uncurry (curry add_nc);; (* another no-op; noop1 & noop2 together show isomorphism *)

print_string ("hi\n");;

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
    | Fixed n -> n
    | Floating z -> int_of_float z;;

ff_as_int (Fixed 5);; (* beware that ff_as_int Fixed(5) won't parse properly!!  Super commmon error!
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
let zer = CZero;; (* example of a variant without a payload *)

type 'a mylist = Mt | Cons of 'a * ('a mylist);;
let mylisteg = Cons(3,Cons(5,Cons(7,Mt)));; (* equivalent in spirit to [3;5;7] *)

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

let rec lookup x bst =
  match bst with
  | Leaf -> false
  | Node (y, left, right) ->
      if x = y then true else if x < y then lookup x left else lookup x right
;;

lookup "whack!" bt;;
lookup "flack" bt;;

let rec insert x bst =
   match bst with
   | Leaf -> Node(x, Leaf, Leaf)
   | Node(y, left, right) ->
       if x <= y then Node(y, insert x left, right)
       else Node(y, left, insert x right)
;;

let bt2 = insert "goober " bt;;
bt;; (* observe bt did not change after the insert *)
let bt3 = insert "slacker " bt2;; (* pass in bt2 to accumulate both additions in bt3 *)
let manyt = List.fold_left (Fun.flip insert) Leaf 
            ["one";"two";"three";"four";"five";"six";"seven";"eight";"nine"] 
            (* folding for serial insert; accum here is the tree so keep passing it along *)

type ratio = {num: int; denom: int};;
let q = {num = 53; denom = 6};;

let rattoint r =
 match r with
   {num = n; denom = d} -> n / d;;

let rat_to_int {num = n; denom = d} =  n / d;;

let unhappy_rat_to_int r  =
   r.num / r.denom;;

let unhappy_add_ratio r1 r2 = (* Doesn't use patterns, boo hoo *)
  {num = r1.num * r2.denom + r2.num * r1.denom; 
   denom = r1.denom * r2.denom};;

unhappy_add_ratio {num = 1; denom = 3} {num = 2; denom = 5};;

let happy_add_ratio {num = n1; denom = d1} {num = n2; denom = d2} = 
  {num = n1 * d2 + n2 * d1; denom = d1 * d2};;

let x = ref 4;;    (* must declare initial value when creating; type is `int ref` here *)

(* x + 1;; *) (* a type error, need to explicitly dereference *)
!x + 1;; (* need `!x` to get out the value; parallels `*x` in C *)
x := 6;; (* assignment is := not =. x must be a ref cell.  Returns unit, () - goal is side effect *)
!x;; (* Mutation happened to contents of cell x *)
let x_alias = x;; (* make another name for x since we are about to shadow it *)
let x = ref "hi";; (* does NOT mutate x above, instead another shadowing definition *)
!x_alias;; (* confirms the previous line was not a mutation, just a shadowing *)

let x = { contents = 4};; (* identical to `let x = ref 4` *)
x := 6;;
x.contents <- 7;;  (* same effect as previous line: backarrow mutates a field *)
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

let arr = [| 4; 3; 2 |];; (* one way to make a new array, or `Array.make 3 0` *)
arr.(0);; (* access notation *)
arr.(0) <- 5;; (* update notation *)
arr;;

failwith "Oops";; (* Generic code failure - exception is a built-in `Failure` exception *)
invalid_arg "This function works on non-empty lists only";; (* Invalid_argument exception *)

exception Bad of string;; (* Declare a new exception named `Bad` with a string payload *)

let f _ = raise (Bad "keyboard on fire");;
(* f ();; *) (* raises the exception to the top level *)
(* (f ()) + 1;; *) (* recall that exceptions blow away the context *)

let g () =
  try
    f ()
  with (* `catch` is the analogous keyword in Java; use pattern matching in handlers *)
      Bad s -> Printf.printf "exception Bad raised with payload \"%s\" \n" s
;;
g ();;

