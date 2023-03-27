## Assigment 6: A **FbRX** Interpreter

Implement an interpreter for the variant language **FbRX** which implements **Fb** operational semantics extensions including

*   **FbR** with in addition a record append operation `@` as described below
*   **FbX** with runtime exceptions
*   **FbG**, the stash/unstash operator of homework 5.

The only file you should modify is **fbrxinterp.ml**; do not change the code above **eval** in that file.

For records, we permit the append of arbitrary records so e.g. `{a = 1; b = 1} @ {a = 2; c = 1} => {a = 2; b = 1; c = 1}` . If the same field is present in both records, the value in the right record has precedence.  Make sure you support `@` in all contexts, e.g. code like `(f 0) @ (g 1)` should work if `f`/`g` are functions returning records.

For exceptions, **FbRX** supports exceptions via expression `Raise #xn e` and `Try e With #xn e` as is defined in **FbX** in the book. **FbRX** also supports runtime exceptions so the language itself can handle the dynamic errors that may arise. For example, e.g. `1 + True` should evaluate to `Raise #TypeMismatch 0` since there is a type mismatch here. Another **FbRX** exception you should support is `Raise #LabelNotFound 0` when a non-existing label is selected from a record, e.g. for `{a = 1}.b`. The value 0 in the exception is arbitrary, but when grading we will check whether the exception id matches the names above.  In general, for any case that there is a run-time type error the interpreter should return an **FbRX** exception instead of raising an OCaml exception as we did with **Fb**.

For stash/unstash, since `Stash` and `Unstash` are not keywords in the **fbrxast.ml** file we are using, we are going to be a little hack-ish and just use the variables `stash` and `unstash` for these operators.  To be more precise, the special AST `Appl(Var(Ident "stash"),...)` will now mean a stash of the `...` and `Var(Ident "unstash"))` is an unstash.   Make sure to evaluate the `...` before stashing it in line with call-by-value.  Your function to check if programs are closed should allow these special variables to be free since they are not really variables now.

In order to get you going we have included a scanner/parser/pretty printer for **FbRX** to the FbDK in directory [`FbRX/`](https://pl.cs.jhu.edu/pl/book/dist/fbdk/FbRX/). Like the Fb interpreter, that directory contains a dummy `fbrxinterp.ml` file which you need to complete the `eval` function for. All of the other instructions are the same as for the **Fb** interpreter of Assignment 4: `dune build` to build, etc.  Note there is a reference implementation available as well, but we are not exactly following that reference (the reference does not include stash/unstash and so on such programs it will generate a not closed error).

You will need to port over your **Fb** interpreter code for the basic **Fb** features. If you lost points for buggy code there, we will be _very_ helpful in getting your basic **Fb** interpreter stuff working now if you ask (i.e. ask any CA or on Courselore and you will be told exactly how to fix your code). In any case the tests will primarily be on the new features and not on the function calling. **FbRX** does include `Let Rec` in the syntax but no testcases will touch it in this assignment. The AST type is as usual in the file [fbrxast.ml](https://pl.cs.jhu.edu/pl/book/dist/fbdk/FbRX/fbrxast.ml). The AST representation is mostly self-explanatory; Use the `Debutils` parser to test if you are not sure on the AST format.

Hint: make sure to use the **FbR** operational semantics from lecture, and the **FbX** operational semantics in the book and lecture, and the **FbG** operational semantics of stash, to define your implementation.  Note that you can more simply just use an OCaml reference cell to implement stash and unstash, this will be easier but it is less directly following the operational semantics.  If you follow the homework math and implement the whole interpreter without any OCaml state you will get extra credit.. Please put the keyword "ExtraCredit" in your file somewhere if you did this and we will manually look over your code to verify.

### Submission

Upload (only) your file `fbrxinterp.ml` to the _Assignment 6_ target on Gradescope.