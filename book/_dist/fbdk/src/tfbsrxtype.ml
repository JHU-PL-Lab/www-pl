open Tfbsrxast;;
open Tfbsrxpp;;
(*
 * If you would like typechecking to be enabled by your interpreter by default,
 * then change the following value to true.  Whether or not typechecking is
 * enabled by default, you can explicitly enable it or disable it using
 * command-line arguments. 
 *) 
let typecheck_default_enabled = true;;

(* Exception on error *)
exception TypeError ;;
exception UndefinedIdentifier ;;

(*
 * Replace this with your typechecker code.  Your code should not throw the
 * following exception; if you need to raise an exception, create your own
 * exception type here.
 *) 
let typecheck e =
  let rec check gamma e =
    let rec teq t1 t2 = match (t1, t2) with
      | (TBottom, _)       -> true
      | (_, TBottom)       -> true
      | (TRec r1, TRec r2) -> List.for_all (
          function (l, t)  -> (List.mem_assoc l r1) && (teq t (List.assoc l r1))
        ) r2 && (List.length r1 = List.length r2) (* Quite a crude technique; Should use a set *)
      | (TRef r1, TRef r2) -> teq r1 r2
      | (TArrow(a1, b1), TArrow(a2, b2)) -> (teq a1 a2) && (teq b1 b2)
      | (a, b)             -> a = b
    (* let teq t1 t2 = t1 = TBottom || t2 = TBottom || t1 = t2 *)
    in
    let best_type t1 t2 = if (t1 <> TBottom) then t1 else t2 in
    let check_binop e1 e2 expected ret =
	    let (t1, t2) = (check gamma e1, check gamma e2) in
        if (teq t1 expected) && (teq t2 expected) then ret 
        else raise TypeError
    in
    let find_mapping key lst =
      try List.assoc key lst with Not_found -> raise UndefinedIdentifier
    in
    match e with
      | Int(v)  -> TInt
		  | Bool(b) -> TBool
	    | Var(v)  -> (find_mapping v gamma) 
			| Appl(e1, e2) ->
        (match (check gamma e1, check gamma e2) with
	        | (TArrow(t1, t2), t3) when (teq t1  t3) -> t2
          | (TBottom, _)          -> TBottom (* Strange, but seems valid *)
	        | _                     -> raise TypeError)
			| Plus(e1, e2)  -> check_binop e1 e2 TInt TInt 
		  | Minus(e1, e2) -> check_binop e1 e2 TInt TInt 
			| Equal(e1, e2) -> check_binop e1 e2 TInt TBool
		  | And(e1, e2)   -> check_binop e1 e2 TBool TBool
			| Or(e1, e2)    -> check_binop e1 e2 TBool TBool
		  | Not e -> 
        if (teq (check gamma e) TBool) then TBool else raise TypeError 
			| If(e, e1, e2) ->
        let (t, t1, t2) = (check gamma e, check gamma e1, check gamma e2) in
          if not (teq t TBool) then raise TypeError else (
          if (teq t1 t2) then (best_type t1 t2) else (
            raise TypeError))
      | Ref(e) -> TRef (check gamma e) (* No bubbling up of TBottoms as per the nature of the rules *)  
      | Set(e1, e2) -> 
        (match (check gamma e1, check gamma e2) with
          | (TRef t1, t2) when (teq t1 t2) -> t2
          | (TBottom, _)                   -> TBottom
          | _                              -> raise TypeError)
      | Get(e) -> 
        (match (check gamma e) with
          | TRef t  -> t
          | TBottom -> TBottom
          | _       -> raise TypeError) 
	    | Record(rbody) -> (* No bubbling up of TBottoms as per the nature of the rules *)
        let rbodytype = List.map (function (l, e) -> (l, check gamma e)) rbody in
          TRec(rbodytype)
	    | Select(l, e)  -> 
	      (match (check gamma e) with
	        | TRec(rbodytype) -> (find_mapping l rbodytype)
          | TBottom         -> TBottom 
	        | _               -> raise TypeError)
      | Raise(n, t, e)  -> 
        if not (teq (check gamma e) t) then 
          raise TypeError
        else
          TBottom
      | Try(e1, exn, id, t, e2) ->
        let t1 = check gamma e1 in
        let newgamma = (id, t)::gamma in
        let t2 = check newgamma  e2 in
          if (teq t1 t2) then t2
          else raise TypeError
      | Function(v, t, e)	-> 
        let newgamma = (v, t)::gamma in
	      let t' = check newgamma e in
	        TArrow(t, t')
			| Letrec(f, v, t1, e1, t2, e2) ->
        let newgamma1 = (f, TArrow(t1, t2))::(v, t1)::gamma in
	      let t'  = check newgamma1 e1 in
        if not (teq t' t2) then
          raise TypeError
        else (
	        let newgamma2 = (f, TArrow(t1, t2))::gamma in
		      let t'' = check newgamma2 e2 in
		        t''
        )
      | Cell(_)   -> raise TypeError (* Syntactically not possible; constructed asts might have it though *)
      
  in 
    (check [] e)
