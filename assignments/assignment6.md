## Assigment 6

This is an OCaml "coding" homework but for simplicity we are only asking for outlines of the code so the code need not run.  You are of course welcome to flesh it out fully to be certain you are correct.

1.  Outline an interpreter for **FbX**. In order to make things easier we will do this in one of the language extensions already in the FbDK: **FbRX** (which also has records for which we will be ignoring). Here is the expression type in [`FbRX/fbrxast.ml`](http://pl.cs.jhu.edu/pl/book/dist/fbdk/FbRX/fbrxast.ml):

    <pre>type exnid = string (* these are the `#xn` of the book, exception identifiers *)
     ...
    type expr = (* ... Fb stuff, elided, see file *)
      (* strings, for exception comments -- implement these (hint: there are no string operations so it is trivial) *)
      | String of string
      (* Records - we are skipping these *)
      | Record of (label * expr) list | Select of label * expr | Append of expr * expr
      (* Exceptions - implement these *)
      | Raise of exnid * expr
      | Try of expr * exnid * ident * expr
      </pre>

    You are not required to fully implement this interpreter, it will suffice to just give some of the key clauses.
    
      a. For the **FbX** substitution function, give the `Raise` and `Try` cases of the `match`  (the others should be similar to **Fb**'s).  Make sure to specify what the different parameters to your substitution function are.

      b. For the `eval` function, give all clauses for values, `Raise` and `Try`, and also include `Plus`, `Let`, and `Appl`. Recall how we need to "bubble up" exceptions so these latter three cases will not just be like the **Fb** ones.
    
2.  In the exceptions lecture we discussed how languages without exceptions (such as C) encode exception-like behavior by "bubbling" up the exception condition, and we also discussed how in OCaml we can use `Some(v)` vs `None` for a non-exception and and exceptional result -- we reviewed the `nice_div` example in the [OCaml lecture notes](../ocaml/code/lecture.html).  Then, when we covered the operational semantics of **FbX** (which you just implemented above) we showed how this bubbling could be used to implement runtime exceptions.

    For this question, show that we could alternatively characterize exceptions in **FbX** via a **translation** from **FbX** programs to **FbV** programs, in the spirit of how we used `Some/None` to bubble up exceptions in the `nice_div` example.  Concretely, write a translation from **FbX** syntax to **FbV** syntax.  As with the previous question, you only have to show the translation of values and `Raise`/`Try`/`Plus`/`Let`/`Appl`.  Also you can *either* give a mathematical definition similar to how we defined the **FbOB** to **FbSR** in Section 5.2.3 of the book, or you can equivalently write a recursive function in OCaml (with only these clauses, so it won't necesssarily run).  The abstract syntax for **FbV** variants is defined in [`afbvast.ml`](http://pl.cs.jhu.edu/pl/book/dist/fbdk/AFbV/afbvast.ml) (the `Variant`/`Match` clauses there; ignore the rest!)

3.  For this question we are going to do some object-oriented programming inside **FbV**. We used records to encode objects in lecture, but as we discussed at the start of the 3/15 lecture we can encode records with variants.  So we should be able to express object-oriented programming with just variants.  To review here is more or less how we encoded the Point class in lecture:

    <pre>    Let pointC = Fun ix -> Fun iy ->
        { x = ix;
          y = iy;
          mag = Fun this -> sqrt (sqr(this.x) + sqr(this.y));
          iszero = Fun this -> (this.mag this = 0)
        } In Let p = pointC 0 10 In p.iszero p
      </pre>

    This encoding is slightly different than the one in class in that it uses immutable fields, there is no "Ref" around the ix or iy values like in lecture. (We also have a null argument on the methods, and sqr and sqrt are squaring and square root functions not shown here; if you want to run the code you can assume they are identity functions).

    Using ideas of the records-as-variants encoding, re-write the above **FbR** `pointC` code as equivalent-functioning **FbV** code.  Note you don't need to write `sqr` or `sqrt`, you can assume they were previously `Let`-defined. If you want to make sure your code runs correctly, you can test it in the **AFbV** reference interpreter (put in something bogus like `Fun x -> x` for `sqr` and `sqrt` to allow the code to run.)

