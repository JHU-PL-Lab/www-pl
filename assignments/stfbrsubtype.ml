(* stfbrsubtype.ml - implementing subtyping for STFbR *)

(* Don't edit any of the types or the name of the function is_subtype below *)

type label = Lab of string

type fbtype =
    TInt | TBool | TArrow of fbtype * fbtype | TRecord of (label * fbtype) list
    
let rec is_subtype t1 t2 = () ;; (* INSERT ANSWER *) 
    
(*    
# let r1 = TRecord [(Lab "x", TInt)] ;;
# let r2 = TRecord [(Lab "x", TInt); (Lab "y", TBool)] ;;
# let r3 = TRecord [(Lab "x", TInt); (Lab "y", TInt)] ;;
# let r4 = TRecord [] ;;
# let r5 = TRecord [(Lab "x", TInt); (Lab "y", TBool); (Lab "z", TRecord [(Lab "x", TInt)])] ;;
# let r6 = TArrow(r1, r2) ;;
# let r7 = TArrow(r4, r5) ;;
# is_subtype r2 r1 ;;
- : bool = true
# is_subtype r3 r2 ;;
- : bool = false
# is_subtype r7 r6 ;;
- : bool = true
*)
