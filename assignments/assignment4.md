## Assignment 4: F♭ Interpreter and Programming in F♭

## DRAFT only at this point, we will be adding testing and part 2. questions.  The part 1. assignment is complete below.

This assignment has two parts.

1.  Write an interpreter for F♭ as defined in the book. You need to implement all features **except** for `Let Rec` (if you implement `Let Rec` you can get 5 points extra credit).
2.  Write some F♭ programs by filling in the template in [assignment4.ml](assignment4.ml).

### The F♭ Development Kit (FbDK)

We have provided you with the FbDK to make your job easier.

*  The FbDK distribution is [here](http://pl.cs.jhu.edu/pl/book/dist), download the zip file.
*  The [README.md](http://pl.cs.jhu.edu/pl/book/dist/fbdk/README.md) in the distribution contains basic instructions on how to install, build, and run the various interpreters in the FbDK.
* For part 1, you will need to fill in the very incomplete `eval` function in the file [`.../fbdk/Fb/fbinterp.ml`](http://pl.cs.jhu.edu/pl/book/dist/fbdk/Fb/fbinterp.ml).
*   File [`.../fbdk/Fb/fbast.ml`](http://pl.cs.jhu.edu/pl/book/dist/fbdk/Fb/fbast.ml) is the type declaration for the F♭ AST's.  There are many other files in the FbDK which you generally can ignore if you want.
*   The FbDK contains a complete BOOL interpreter in the directory [`.../fbdk/BOOL/`](http://pl.cs.jhu.edu/pl/book/dist/fbdk/BOOL/). The complete source for the [BOOL evaluator](http://pl.cs.jhu.edu/pl/book/dist/fbdk/BOOL/boolinterp.ml) is given and can help you get started on your F♭ evaluator.
*  As was shown in class and described in the README, you can run your interpreter in OCaml's `utop`, or in standalone mode, and additionally we have supplied reference binary implementations to help you  -- see the README.
*  The source of the F♭ code examples in the book as well as the examples and macros used in the **Programming in F♭** lecture are found in the file [`fb_examples.ml`](http://pl.cs.jhu.edu/pl/ocaml/code/fb_examples.ml) as a separate download.

### Interpreter writing hints

1.  *Use the F♭ operational semantics rules as the guidepost*: all you are doing is implementing those rules.
2.  For a warm-up, get the numbers and booleans to evaluate properly, then tackle functions. The BOOL interpreter is a very big hint on implementing boolean operations in F♭.
3.  You will need to write several auxiliary functions for performing substitution, etc.
4.  Declare and raise appropriate exceptions.
5.  You will probably want to write at least three functions:
    1.  `eval`, a stub for which is provided,
    2.  `subst`, a function implementing variable substitution
    3.  `check_closed`, a function which determines whether or not an expression is closed.  Remember that you must raise an exception if you are provided an expression which is not closed, such as `Function x -> y`.
6.  There are many implementations of interpreters for functional languages out there, but you need to hedge closely to the given operational semantics rules in your implementation. For example make sure you are using substitution for function application, etc. We will look over your code to verify this.
7.  Typing `Printexc.record_backtrace true;;` into `utop` will enable a stack trace to be dumped if your interpreter has a run-time error.  If you start the standalone F♭ interpreter with the command line argument `--show-backtrace` it will accomplish the same thing.

### Submission

*   We will be putting up two separate Gradescope submission points.
*   For part 1, upload _only_ your `fbinterp.ml` file with your evaluator code.
*   For part 2, upload _only_ the filled-in `assignment4.ml` file (that name exactly and no other files).