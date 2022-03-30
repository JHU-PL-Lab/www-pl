## Assigment 6: A **FbRX** Interpreter

Implement an interpreter for the variant language **FbRX** which implements **Fb** operational semantics extensions including

*   **FbR** with in addition a record append operation `@` as described below
*   **FbX** with runtime exceptions
*   A new primitive type String which `=` also can compare (along with the integers it already works on; this is implementing the string extension of HW3) and which `@` can append strings together (the same as `^` of HW3)

The only file you should modify is **fbrxinterp.ml**; do not change the code above **eval** in that file.

For records, we permit the append of arbitrary records so e.g. `{a = 1; b = 1} @ {a = 2; c = 1} => {a = 2; b = 1; c = 1}` . If the same field is present in both records, the value in the right record has precedence.  Make sure you support `@` in all contexts, e.g. code like `(f 0) @ (g 1)` should work if `f`/`g` are functions returning records.

For exceptions, **FbRX** supports exceptions via expression `Raise #xn e` and `Try e With #xn e` as is defined in **FbX** in the book. **FbRX** also supports runtime exceptions so the language itself can handle the dynamic errors that may arise. For example, e.g. `1 + True` should evaluate to `Raise #TypeMismatch 0` since there is a type mismatch here. Another **FbRX** exception you should support is `Raise #LabelNotFound 0` when a non-existing label is selected from a record, e.g. for `{a = 1}.b`. The value 0 in the exception is arbitrary, but when grading we will check whether the exception id matches the names above.  In general, for any case that there is a run-time type error the interpreter should return an **FbRX** exception instead of raising an OCaml exception as we did with **Fb**.

For the string extension, **FbRX** supports literal strings equality testing on them.

For `=` in **FbRX**, it works on two values of int or string type (only). If the types of two operands are different, or either type is a function, record, or boolean, it evaluates to an **FbRX** runtime type error exception `Raise #TypeMismatch 0`.

In order to get you going we have included a scanner/parser/pretty printer for **FbRX** to the FbDK in directory [`FbRX/`](https://pl.cs.jhu.edu/pl/book/dist/fbdk/FbRX/). Like the Fb interpreter, that directory contains a dummy `fbrxinterp.ml` file which you need to complete the `eval` function for. All of the other instructions are the same as for the **Fb** interpreter of Assignment 4: `dune build` to build, etc.  Note there is a reference implementation available as well, but we are not exactly following that reference in every single case; refer to the above for the description of how the operators should work (`=` in particular is slightly different in the reference implementation, it works on e.g. booleans but yours should not; also `@` does not append strings in the reference but it should for you).

You will need to port over your **Fb** interpreter code for the basic **Fb** features. If you lost points for buggy code there, we will be _very_ helpful in getting your basic **Fb** interpreter stuff working now if you ask (i.e. ask any CA or on Courselore and you will be told exactly how to fix your code). In any case the tests will primarily be on the new features and not on the function calling. **FbRX** does include `Let Rec` in the syntax but no testcases will touch it in this assignment. The AST type is as usual in the file [fbrxast.ml](https://pl.cs.jhu.edu/pl/book/dist/fbdk/FbRX/fbrxast.ml). The AST representation is mostly self-explanatory; Use the `Debutils` parser to test if you are not sure on the AST format.

Hint: make sure to use the **FbSt** and **FbR2** operational semantics from HW3 and 5 respectively, and the **FbX** operational semantics in the book, as guides for your implementation.

### Submission

Upload (only) your file `fbrxinterp.ml` to the _Assignment 6_ target on Gradescope.