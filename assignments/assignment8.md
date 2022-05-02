## Assigment 8 - Types

This assignment has a principles/theory paper part (A) and an implementation part (B).  The principles part is due before the implementation part.

### Part A - Type Systems

1. For each of these expressions, either construct a typing proof in **TFb**, **or** show exactly why they cannot typecheck (i.e. no derivation tree could ever be built; don't just informally describe it, use the formal system rules).

    a.  `If (Fun x : Int -> 0) 0 Then 0 Else 0`

    b.  `Fun b : Bool -> (If True Then (Fun x : Int -> x + 1) Else (Fun x : Int -> x))`

    c.  `(Fun x : (Int -> Int) -> x False)`


2. This question concerns subtyping.

    a. Establish the following subtype relations using the subtype rules in Section 6.5.2., or argue that there is no proof possible using the rules.

     i. `{} <: {q : Int}`

     ii. `Int -> {a : Int} <: Int -> {}`

     iii. `({} -> {a : Int}) -> Bool <: ({c : Bool} -> {a : Int; b : Int}) -> Bool`

     iv. `({c : Bool} -> {a : Int}) -> Bool <: ({} -> {a : Int; b : Int}) -> Bool`


    b. In lecture we defined a semantic meaning function `[[τ]]` which interpreted types as sets.  For each of the above subtype relations that you believe *fails* to be provable, show `[[τ]] ⊆ [[τ']]` fails by finding an expression in the LHS set not in the RHS set.

    c.  Type the following expression in **STFbR**

    ```ocaml
    Fun r : {} -> (Fun r1:{c : Bool} -> {x = r1.c}) ({ a = 4; c = False})
    ```

    Make sure to include any subtyping proofs you need as part of the subsumption rule.   Recall the subtype rules were covered in lecture and in Section 6.5.2.

3.  For this question we consider **STFbV**, an extension of **TFb** with *both* variants *and* subtyping.  The variant types will be of a form similar to OCaml variant type declarations, e.g `` `good of Int | `bad of Bool``.  Note that we will use backticks on the different variant names, also all variants take an argument.  This allows the types to match the **FbV** expression syntax that we covered in class.  In general these new types are of the form `n_1 of τ_1 | ... | n_m of τ_m`.

    The notion of subyping for variants can be just as useful as record subtying; in the context of OCaml which has no subtyping (on records *or* variants), if it was extended with this dual notion of subtyping on variants it would be possible to `match` with clauses that were not even in the type and the type inferencer would not complain like it does now, e.g. it would be OK to write code like `fun (opt : option int) -> match opt with | Some(x) -> 0 | None -> 1 | Wacky -> 2`, which is obviously not going to be a run-time error as the extra `Wacky` clause will not be used.  But, OCaml itself will not allow this.  

    **STFbV** needs type rules and subtype rules as with **STFbR**.  But, for this question we are only going to focus on the *semantics* of these variant types as sets of expressions, and what subtyping means in that context. Here is how we could define `[[τ]]` for the **STFbV** types.

    `e in [[τ]]` iff 

    (* clauses same as STFbR for non-record non-variant cases *)

    ... or `τ = n_1 of τ_1 | ... | n_m of τ_m`, in which case
    
    if `e => v`, then `v = n_1(v_1)` with `v_1 in [[τ_1]]`, or `v = n_2(v_2)` with `v_2 in [[τ_2]]`, ... or `v = n_m(v_m)` with `v_m in [[τ_m]]`


    In other words, the members of e.g. `` [[ `good of Int | `bad of Bool ]]`` are expressions that if they terminate either evaluate to `` `good(n)`` for some number `n`, or to `bad(True/False)`.

    a. For this question, use the semantic meaning of variants to propose what a good subtyping principle would be for potential subtyping rules of **STFbV**.  Both give the principle and justify that it makes sense in terms of the above definition.  Hint: to warm up, consider if the set containment is ``[[ `good of Int ]] ⊆ [[ `good of Int | `bad of Bool ]]``, or the opposite direction `⊇`, or neither?

    b. Does the same subtyping principle hold on functions here as we had in **StFbR**? In other words, is it (still) the case that if `[[τ1']] ⊆ [[τ1]]`  and `[[τ2]] ⊆ [[τ2']]` that `[[τ1 -> τ2]] ⊆ [[τ1' -> τ2']]` always follows?  Justify your answer.

### Part B - Type Inferencer Implementation

The FbDK has been designed to be extensible with typechecking. It is just turned off by default. For this homework you are to use the FbDK to implement the type inference algorithm for **EFb** in OCaml. Your implementation is expected to handle all of **EFb** with the exception of `Let Rec`.

To complete this assignment, you will need to edit `fbtype.ml` in the `Fb/` directory and implement the `typecheck` function which in the dist is just raising an exception. This function must return the type of that expression as specified by the **EFb** algorithm; you should use the `fbtype` data type which appears in `fbast.ml`. You also should set `typecheck_default_enabled` to `true` in `fbtype.ml` so the typechecker will run. 

For this part, you should turn in your `fbtype.ml` file and nothing else. Do not change `fbast.ml` or similar files, since your code will be auto-graded by dropping your `fbtype.ml` file into a correct implementation of **Fb**.

You can directly invoke the typechecker function `typecheck` in the top loop, either your own or the reference depending on whether you did a `dune utop ./Fb` or a `./reference/Fb/toplevel.exe`:

```ocaml
$ ./reference/Fb/toplevel.exe
...
# open Fbdk;;
# open Ast;;
# open Typechecker;;
# open Pp;
# open Debugutils;;
# typecheck @@ parse "Fun x -> x";;
- : fbtype = TArrow (TVar "a", TVar "a")
# let tc  s = show_fbtype @@ typecheck @@ parse s;;
val tc : string -> string = <fun>
# tc "Fun x -> x";;
- : string = "a -> a"
```

The `Fb` reference binary also supports typechecking. You can turn it on by passing `--typecheck` to it. As an example, a correctly working interpreter should behave as follows:

```ocaml
$ ocamlrun reference/Fb/interpreter.bc --typecheck
        Fb version 1.4.0                (typechecker enabled)
# (Function x -> Function y -> x + y) 4;;
: Int -> Int
==> Function y ->
4 + y
# Function x -> x;;    
: 'a -> 'a
==> Function x ->
x
# True + 1;;
Exception: Fbtype.TypeInferenceFailure("immediately inconsistent types")
```


Note also that the exception which is raised by a type error is defined in the `fbtype.ml` module; you must define your own exception `NotTypable` to throw when the expression cannot be assigned a type.

You need to implement the full algorithm _except_ you do not need to implement the cycle detection algorithm - your checker can loop forever on programs with cyclic constraints (but only on such programs). Extra credit will be given for implementing cycle detection. Throw a `CyclicalConstraints` exception in this case.  Also, note that you don't need to include the let-polymorphism of **PEFb**, we are implementing **EFb** only.

Here are some suggestions:

*   Break down your implementation into the same phases as in lecture and the book:
    1.  Generate the type `τ \ E` using the ideas in the type system,
    2.  Perform the closure on `E`,
    3.  Check the closure for immediate inconsistencies, and
    4.  Substitute equations of `E` into `τ` to give a printable type.
*   The `E` is a set of pairs (the type equations τ = τ'); built-in Caml types such as `Set` or `Map` may prove useful in your implementation of this data structure. You can use any of the built-in libraries but the auto-grader cannot install any extra packages to run your type checker.
*   In the closure outlined in the book, we assumed = was symmetric; in your implementation, one easy (but inefficient) method to achieve this to add an additional closure step: every time you add τ = τ' to the closure, also add τ' = τ.
*   The "substitute to solve" phase is the same idea as your substitution function you wrote for **Fb** expressions in the `eval` function; just do it here on types.
