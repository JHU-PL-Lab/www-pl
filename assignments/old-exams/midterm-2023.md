## Midterm 2023

You are to work without the consultation of any individuals other than Prof/CAs on this exam.  This includes posting questions on the Internet, etc. Please include at the top of your exam 

> I pledge I worked without consultation with any individuals other than Prof/CAs on this exam

certifying this.  You are free to use any non-human resources, e.g. the course text, lectures, Wikipedia, etc.

You are free to ask questions on Courselore or in office hours, but please address all Courselore questions to Staff.  If it is a good issue to clarify we will make your question public.

1. (15 Points) Let's fill out some _very_ sketchy operational semantics proofs.  For each fragment below, build out a full proof tree in Fb which has the indicated substitution invocation somewhere in the proof.  Well, some also may be impossible - indicate which are impossible if no derivation can be built.  (Recall that for `e ==> v`, both `e` and `v` must be closed.)

    Example question: `y[4/y] ==> ..`
    Example Answer:

    ```
    ----------------------------    ---------   ------------
    (Fun y -> y) ==> (Fun y -> y)    4 ==> 4    y[4/y] ==> 4
    ---------------------------------------------------------
           (Fun y -> y)(4) ==> 4
    ```

    Note there are many answers possible, just make sure you have the indicated pattern _somewhere_ in your proof tree.

      a.  `(Fun x -> x + y)[0/y] ==> ...`

      b.  `(x + y)[0/y] ==> ..` 

      c.  `(Fun x -> x + 1)[0/x] ==> ...`

      d.  `(x x)[(Fun x -> x)/x] ==> ...`

      e.  `(x x)[(Fun x -> x x x)/x] ==> ...`



2.  (15 points) We focused on operational equivalence for **Fb**, but the definition naturally generalizes to other languages we studied (and even to JavaScript, Python, etc).  For example for **FbR**, the definition of ~= will read identically and the only difference is the contexts `C` will be **FbR** contexts not **Fb** contexts, and the `==>` evaluation relation will also be **FbR**'s.

     a. For the theory of **FbR** operational equivalence, propose one or more more useful `~=` laws to add to the **Fb** laws we had such as beta, etc.  Your laws need to deal with the new record syntax.  You need at least one law, and also see the following question which means you may need more than one.  But, don't make any laws which are not strictly needed.  For example, `{} ~= {}` is already true by the existing reflexivity law so don't add that one.

     b. Use your new **FbR** laws and the existing **Fb** laws to prove 
        `(Let r = { a = z; b = (Fun x -> x) } In (r.b) 5) - 2 ~= ((Fun x -> x) 5) - 2`.  Show your steps and name any laws used.

     c. We can also use the definition of `~=` for **FbR** mentioned above to prove expressions are *not* equivalent.  Do this for the non-equivalence `z { a = 5; b = 7 } ~= z { a = 5 }`: give an **FbR** context `C` that distinguishes these two expressions.



3. (15 points) Currently in **FbV**, we only have `=` defined for integers. Yet in practice, it's nice to have a polymorphic equality that also works on other data types, such as booleans and variants. 

   a. Redefine the operational semantics of `FbV` so that `=` now works as expected for boolean and variant values as well.  You only need to give any new rules related to `=`.  Note that function equality tests can still get stuck as happens with **Fb** now.

   b. Write OCaml pseudocode reflecting the changes that would be needed to the **FbV** `eval` function to implement this new definition of `=`. There is no need to write other clauses of `eval`, you can just put `| ...` in your code for all the non-`Equal` `match` clauses.  

   c. The advantage of polymorphic equality is clear, more types of data can be directly compared. However, many modern languages opt not to include it as a feature. What are some potential downsides of polymorphic `=` that lead to this language design choice?

4. (10 points) Suppose we defined a new notion of operational equivalence `~~=` as follows:
   For arbitrary `e` and `e'`, we say `e ~~= e'` if and only if for all contexts `C` such that  `C[e]` and `C[e']` are closed, if `C[e] => True` then `C[e'] => True`, and vice-versa. Is this the same as the `~=` as was defined in the lecture/book, or not? Either argue why if so or find an example of two expressions which are equivalent in one but not in the other.

5. (10 points) Write mutually recursive functions `iseven` and `isodd` in **Fb** without using `Let Rec`. You can use the Y combinator, self-passing, or a variation on one of these, whatever gets the job done.