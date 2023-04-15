(*
   File: tfbsrx.ml
   This File contains some typechecking examples  *)

open Debugutils;;

(* Pretty printer (unparser) for types *)

let tu t = Format.asprintf "%a" Fbdk.Pp.pp_fbtype t;;

(* A shorter name for the type checker function *)
let tc = Fbdk.Typechecker.typecheck;;

(* Function to parse a string, perform type checking, and unparse the inferred type *)
let ptcu s = s |> parse |> tc |> tu;;

(* Examples. *)

(* Int *)
let s1 = "(Function x:Int -> x + 1) 3" ;;
ptcu s1 ;;

(* Bool -> Int -> Int *)
let s2 = "Function switch:Bool -> Function x:Int -> If switch Then x Else x - 1" ;;
ptcu s2 ;;

(* Int -> Int *)
let s3 = "Let Rec f x:Int = (If x = 0 Then 0 Else x + f (x - 1)):Int In f";;
ptcu s3 ;;

(* Int *)
let s4 = "(Function c:Int Ref -> c := (!c + 1)) (Ref 3)" ;;
ptcu s4 ;;

(* Bool *)
let s5 = "{x = 2+1 ; y = (Function x:Int -> x + 1) 3 ; z = False}.z" ;;
ptcu s5 ;;

(* {a:Int, b:Bool} *)
let s6 = "(Function r:{x:Int;y:Int} -> {a = r.x + r.y ; b = False} ) {y = If 0 = 2 Then 1 Else 2 ; x = 1-2}" ;;
ptcu s6 ;;

(* Int *)
let s7 = "Try Raise (#Ex@Bool) False With #Ex@Int x -> x + 1" ;;
ptcu s7;;

(* Int *)
let s8 = "Try Raise #Ex@Int 9 With #Ex@Int x -> x + 1" ;;
ptcu s8;;

(* This one should fail to typecheck *)
let s9 = "1 And False" ;;
ptcu s9 ;;

(* Int *)
let s10 = "(Function r:{x:Int} -> r.x) ((Function x:Int -> Raise #Ex@Int 0) 0)" ;;
ptcu s10 ;;

(* Int *)
let s11 = "Try (Try Raise (#Ex@Bool) False With #Ex@Int x -> x + 1) With #Ex@Bool b -> (If b Then 1 Else 0)" ;;
ptcu s11;;

(* This one should fail to typecheck *)
let s12 = "Try (Try Raise (#Ex@Bool) False With #Ex@Int x -> x + 1) With #Ex@Bool b -> b" ;;
ptcu s12;;

(* Int -> Bool -> Bool *)
let s13 = "Function x:Int -> Function x:Bool -> Not x" ;;
ptcu s13 ;;

(* Int -> Int *)
let s14 = "Function x:Int -> x + (( Function x:Bool -> If x Then 0 Else 1 ) True)" ;;
ptcu s14 ;;

(* Fails : Expression not closed *)
let s15 = "Function x:Int -> Function y:Int -> x + y + z" ;;
ptcu s15 ;;

(* This one should fail to typecheck *)
let s16 = "Function x:Int -> Function y:Bool -> x + y" ;;
ptcu s16 ;;

(* Int -> Int *)
let s17 = "If 1 = 2 Then (Function x:Int -> x) Else (Function y:Int -> y + 1)" ;;
ptcu s17 ;;

(* This one should fail to typecheck *)
let s18 = "If 1 = 2 Then (Function x:Int -> x) Else (Function y:Int -> y = 1)" ;;
ptcu s18 ;;

(* Int *)
let s19 = "If 1 = 1 Then Raise #Exn@Int 1 Else 2" ;;
ptcu s19 ;;

(* Int *)
let s20 = "(Function x:Int -> x + 1) (Raise #Exn@Int 1)" ;;
ptcu s20 ;;

(* Int -> BOTTOM *)
let s21 = "Function x:Int -> Raise #Exn@Bool False" ;;
ptcu s21 ;;

(* Int *)
let s22 = "(Function r:{x:Int;y:Int} -> r.x) {x = 1 ; y = (Raise #Foo@Int 3)}" ;;
ptcu s22 ;;

(* Bool *)
let s23 = "(Function a:{r:{m:Int;n:Bool};s:{l:Bool}} -> a.r.n And a.s.l) {s={l=True};r={m=2;n=(1=1)}}" ;;
ptcu s23 ;;

(* Int *)
let s24 = "(Function x:Int Ref -> x := !x) ((Function x:Int -> Ref (Raise #Xn@Int x)) (1+1))" ;;
ptcu s24;;
