## Assigment 8 - Type Systems

1. (15 points) For each of these expressions, either construct a typing proof in **TFb** **or** show exactly why they cannot typecheck (i.e. no derivation tree could ever be built; don't just informally describe it, use the formal system rules).

    a.  `If True Then 0 Else False`

    b.  `(If True Then (Fun x:Int -> x + 1) Else (Fun x:Int -> x)) 0`

    c.  `(Fun x:(Int -> Int) -> x False)`


2. (25 points)  This question concerns subtyping.

    a.  Complete and type the following expression in **STFbR** (note this program is not showing the type declarations on `r1/r2`, you need figure those out):

    ```ocaml
    Fun n:Int -> Fun r1:{...} -> Fun r2:{...} ->
      {x = r1.x + 1; y = (If n = 0 Then r1.y - 1 Else r2.y +1); z =  r2.z + 2}
    ```

    (You only need to give the type of the above expression, you don't need to show the full type derivation.)

    b.  Now write a nontrivial subtype of your answer to a) which changes as many of the record types as you can.  
    
    c. Give the proof tree showing that your subtyping from part b. holds using the subtype rules covered in lecture and in Section 6.5.2.

3.  (25 points) For this question we will extend **FbV** with types, producing **TFbV**. In this question you are to make a type system for **TFbV**. Most of the rules are the same as **TFb** and you do not need to repeat those rules.  Variant types are added to **TFb**'s type grammar, of the syntactic form `` `good(Int) | `bad(Bool)`` (which would be `type eg = Good of int | Bad of bool` in OCaml).


    Rather than adding variant type declarations like in OCaml, we are going to simply inline the variant type everywhere it is used.  (Yes this is a bit ugly.  But it is simple.) In particular, the **FbV** syntax `` `n(e)`` becomes `` `n(e):τ`` in **TFbV** - *all* variant data is tagged with its variant type. For example: `` `good(0): `good(Int) | `bad(Bool)``.  Note what you generally *don't* want to do in a program is to say `` `good(0): `good(Int)`` - that would mean there is no other variant ever possible (note if we had subtyping on variant types we could do that, but we do not).

    a.  Your task is to write the new type rules beyond those already present in **TFb** to make a full type system for **TFbV**.  Please make your rule be strict in that all cases in the type must be in the `Match` clause -- OCaml will sometimes give a warning if there is a case missing, you should not allow those programs to typecheck in your rule.

    b.  Show your rules work by proving the simple program

    ```ocaml
    (Fun goo : `good(Int) | `bad(Bool) ->  Match goo With `good(_) -> 0 | `bad(_) -> 1)(`good(0): `good(Int) | `bad(Bool))
    ```

    typechecks: construct the type tree for it using your rules.

    c.  Propose subtyping rules for a **STFbV** extension to **TFbV**.  Hint: variants are *unions* of different possible tags, and subtyping can be modeled as a subset as we covered in lecture.  Give the full `<:` rule set; you are welcome to borrow subtyping rules from **STFbR**.
