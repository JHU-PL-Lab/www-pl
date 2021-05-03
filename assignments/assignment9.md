## Assigment 9 - Type Inferencer Implementation

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
$ ./Fb/reference/interpreter.exe --typecheck
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
