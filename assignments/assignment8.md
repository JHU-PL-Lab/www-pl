## Assigment 8 - Type Systems
## DRAFT!  Final assignment may differ!!


1. (20 points) For each of these expressions, either construct a typing proof in **TFb** **or** show exactly why they cannot typecheck (i.e. no derivation tree could ever be built; don't just informally describe it, use the formal system rules).

    a.  `If True Then 0 Else False`

    b.  `(If True Then (Fun x:Int -> x + 1) Else (Fun x:Int -> x)) 0`

    c.  `(Fun x:(Int -> Int) -> x False)`

    d.  `(Fun x:Bool -> Fun x:Int -> x + 1)`

2.  (25 points) Here we will extend **FbV** with types, **TFbV**. In this question you are just making a type system, not a type checker. Variant types are added to **TFb**'s types; they will be slightly different than OCaml syntax, they will be e.g. `` `good(Int) | `bad(Bool)``.


    We also need to add some type labels to facilitate type checking, modifying slightly the **TFbV** syntax: replace `` `n(e)`` with `` `n(e):τ`` - all variant data is tagged with a variant type (we don't have the `type` declarations of OCaml so we need to manually do this; this type also needs to include all potential variants since we have no subtyping here.). For example: `` `good(0): `good(Int) | `bad(Bool)``.  (Yes this is a bit ugly.  But it is simple.)

    a.  Your task is to write the new type rules beyond those already present in **TFb** to make a full type system for **TFbV**. Note you don't need to implement anything for this question. Please make your rule be strict -- OCaml will sometimes give a warning if there is a case missing, you should not allow those programs to typecheck in your rule. (To model the warning we would need to include a warning flag in our type system.)

    b.  Show your rules work by proving the simple program

    ```ocaml
    Match (`good(0): `good(Int) | `bad(Bool)) With `good(_) -> 0 | `bad(_) -> 1
    ```

    typechecks: construct the type tree for it.

    c.  Describe why the same program but with the `` `bad`` case removed fails to typecheck in your rules (yes, it should fail even though that case is not invoked).


3. (25 points)  This question concerns subtyping.

    a.  Type the following expression in **STFbR** (note this program is not showing the type declarations on `r1/r2`, you need figure those out):

    ```ocaml
    Fun n:Int -> Fun r1:{...} -> Fun r2:{...} ->
      {x = r1.x + 1; y = (If n = 0 Then r1.y - 1 Else r2.y +1); z =  r2.z + 2}
    ```

    (you only need to give a legal type, not show the full type derivation)

    b.  Now write a nontrivial subtype of your answer to a) which changes as many of the record types as you can.  Along with writing the subtype, give the proof of subtyping using the subtype rules covered in lecture and in Section 6.5.2.

    c.  Like b) but make a supertype.  Also give the proof tree.

