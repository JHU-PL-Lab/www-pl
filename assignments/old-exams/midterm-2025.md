<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<style> body { font-family: 'Arial', sans-serif; } </style> 

## Programming Languages Midterm Exam Spring 2025

Your Name (please **print neatly** to help Gradescope automatically recognize it): _______________________________________________________________


1. (12 points) For this question consider a very simple language **BL** with just booleans (`True` and `False`, plus `And`, `Or`, `Not` operators) and `Let`. No functions! So a sample program would be `Let x = True And False In x And Not x`.

    a.  Give the grammar definitions of expressions e and values v.

    b.  For each occurrence of a variable usage in some **BL** expression e, define when that variable is considered to be _bound_ and when it is considered to be _free_.

    c.  Define the complete substitution function for **BL** expressions: `e[v/x]`.  You can either give a mathematical definition like in the book, or write pseudocode -- as long as your answer is unambiguous in meaning it is fine.

    d.  Are all closed expressions e of **BL** normalizing, or not?  Briefly justify your answer.

    <p style="page-break-after:always;"></p>

2. (6 points) Its time to reverse engineer some operational semantics proofs. For each fragment below, build out a full instance of the application rule for Fb which has the indicated substitution above the line. Well, some are impossible - indicate which are impossible if no derivation can be built. (Recall that for e ==> v, both e and v must be closed.)

   Example question: `y[4/y] ==> ...`
   
   Example Answer:

   <pre>
   (Fun y -> y) ==> (Fun y -> y)    4 ==> 4    y[4/y] ==> 4
   ---------------------------------------------------------
          (Fun y -> y)(4) ==> 4
   </pre>
   a. `(x + y)[3/x]` ==> ...

   b. `x [(Function y -> y + y)/x]` ==> ...
    <p style="page-break-after:always;"></p>

3. (8 points) Write mutually recursive functions `is_even` and `is_odd` in **Fb** without using `Let Rec`. `is_even n` returns `true` if `n` is an even number, and `false` otherwise; similarly for `is_odd`. You can use the Y combinator, self-passing, or a variation on one of these, whatever gets the job done without `Let Rec`. Your functions need only work on non-negative numbers.

    <p style="page-break-after:always;"></p>


4.  (12 points) The book listed some laws for operational equivalence ~= for **Fb**.  Let us consider some other possible laws.  Consider each of the following statements and categorize it as 1) true but not provable with the existing laws (so it might be good as a new law), 2) true *and* provable with the existing laws (give the proof in such a case, including all the laws used in the proof), or 3) false (prove that it is false in such a case using the definition of ~=).

    a. `(Fun x -> 0) 1` ~= `0`

    b. `Let x = x In x ~= Let y = y In y`

    c. `((Fun b -> If b Then (Fun x -> x + z) Else (Fun x -> x - z)) True) 1 ~= 1 + z`

    <p style="page-break-after:always;"></p>



5. (12 points) In **FbV**, when evaluating a variant the payload will be eagerly evaluated, e.g. `` `Some(2+1)  ==> `Some(3) ``. Now consider **FbVl** in which a variant evaluates to itself like functions do: `` `Some(2+1)  => `Some(2+1) ``. The payload is only evaluated when the variant is pattern matched: `` Match `Some(2+1) With `Some(n) -> n+5 `` will compute `2+1 ==> 3` and substitute the `3` for `n` in `n+5` and then compute to `8`.  The variants in **FbV** are called *eager* since the payload is eagerly evaluated; the **FbVl** form is *lazy*.

    a. Define the expression and value grammars for **FbVl**.

    b. Write all **FbVl** operational semantics rules needed for variant creation and pattern matching, making sure their behavior matches the spec given above. All the other rules are the same as **Fb**'s and need not be given.

    <p style="page-break-after:always;"></p>


BLANK PAGE, IF YOU RUN OUT OF SPACE FOR ANY QUESTION WRITE "SEE BLANK PAGE" AND CONTINUE HERE