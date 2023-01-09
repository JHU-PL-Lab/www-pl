## Midterm 2021

You are to work without the consultation of any individuals other than Prof/CAs on this exam.  This includes posting questions on the Internet (other than our Campuswire), etc. Please include at the top of your exam 

> I pledge I worked without consultation with any individuals other than Prof/CAs on this exam

certifying this.  You are free to use any non-human resources, e.g. the course text, lectures, Wikipedia, etc.

You are free to ask questions on Campuswire or in office hours, but please ask all Campuswire questions to "TAs and instructors only".  If it is a good issue to clarify we will make your question public.


1.  (15 points)  Recall **FbV** from lecture and Section 3.3 of the book.  For each of these **FbV** programs prove it has a value (by building the operational semantics proof tree) **or** argue that the program has no value.  The **FbV** operational semantics rules are in the book and are an extension of the **Fb** rules.

     a. ``(Fun yn -> Match yn With `Yes(x) -> 3 | `No(y) -> y) (`No(3))``

     b. `If 0 = 1 Then Not(0) Else Not(False)` (note this program is in fact just an **Fb** program)

     c. ``Match `Yes(3) With `No(z) -> z - 1``

2.  (20 points) This question also concerns **FbV**.

     a. We only defined substitution _e_[*v*/*x*] in the book for **Fb** in Definition 2.10.  Make a similar definition for substitution for **FbV**.  You don't need to repeat the clauses of **Fb**, just give the clauses for the new **FbV** syntax not found in **FbV**.  Note you must give a mathematical definition of substitution, not OCaml code.

     b. The book contains the operational semantics rules for **FbV** but does not outline how an interpreter for **FbV** would be implemented. For this question outline the OCaml `eval` function for **FbV**.  Since this extension is pure functional you only need to give the new clauses not in the **Fb** `eval` function.  You don't need to write the complete code, just the new OCaml `match` clauses, and you can also assume there is a substitution function which implements the _e_[*v*/*x*] specified in part a. above.  If you are not sure what we mean by "just the new clauses", see Section 3.1 of the book which extends the **Fb** `eval` for pairs, that is the idea of what you need to do.

     (Note: if you want to be super duper sure you are right you are welcome to implement the full `eval` for **FbV**.  Use the `AFbV/` directory in the FbDK in place of `Fb/`, and code `eval` in `afbvinterp.ml`.  The **AFbV** AST (in `AFbV/afbvast.ml`) contains many other features besides variants in the AST, just `failwith "unimplemented"` on those.  You can also use the solution **AFbV** interpreter in the FbDK to test how **FbV**'s `Match` etc should work.)

3. (15+2 points) For each of the following potential operational equivalences for **Fb**, either state that it holds, or present a counterexample context C invalidating it.  If it holds, either give a proof using the principles found in the book (make sure to download a fresh copy of the book as a few principles were recently added), or state that more principles are needed to prove it (even though it is true).

     a. `Let x = x In x ~= Let y = y In y`

     b. `Let x = y In x ~= Let y = y In y`

     c. `((Fun b -> If b Then (Fun x -> x + z) Else (Fun x -> x - z)) True) 1 ~= 1 + z`

     d. (harder bonus question, +2) `(ycomb f) ~= f (ycomb f)` where `f` here is a variable and `ycomb` is the Y combinator defined in the book and in the `fb_examples.ml` file.


4. (15 points) The **Fb** operational semantics defines a relation *e* => *v* over proof *trees*.  Consider a very similar definition of a relation *e* ≡> *v* which has the rules as Fb just replacing => with ≡>, and *in addition* has one more rule, the alias rule:

<pre>
  -------------
      e ≡> v
</pre>

This rule it first glance looks like anything is provable, but ≡> *also* has a different definition of a valid proof tree: it is the same as the Fb proof trees, but the alias rule can *only* be used to prove e ≡> v in the tree if on a *different path* in the tree there is a non-alias proof of e ≡> v.  Intuitively, the idea of an alias is you already proved it somewhere else in the tree so no need to prove it again.

For example here is a proof tree showing `(3 + 2) + (3 + 2) ≡> 10`:

<pre>
 (value) -------  ------ (value)
         3 ≡> 3  2 ≡> 2  
(plus) ------------------      -------------- (alias)
         3 + 2 ≡> 5              3 + 2 ≡> 5
---------------------------------------------------
              (3 + 2) + (3 + 2) ≡> 10
</pre>

-- We already proved `3 + 2 ≡> 5` in the left subtree and the alias rule lets us re-use that proof in the right subtree.  What you *cannot* do is
<pre>
   ---------------------------------- (alias)
      (Fun x -> x x)(Fun x -> x x) ≡> 727
  ------------------------------------------ (application (cheap version for simplicity here))
     (Fun x -> x x)(Fun x -> x x) ≡> 727
</pre>

-- this uses alias on the same tree path.  Obviously you can see why that is a bad thing, it proves a diverging program returns 727!


  a. Argue that *e* => *v* if and only if *e* ≡> *v* -- we did not change the underlying **Fb** semantics with ≡>.  You don't need to give a formal proof but give a convincing line of reasoning.

  b. The alias rule could be implemented in a variation on `eval` function for **Fb** which would also avoid repeating the same computations, e.g. on the above example it would only need to add `3` and `2` once (this is a simple example but it would e.g. make an exponential fibbonici run in polynomial time).  Describe how such an `eval` would be implemented.  You don't need to give a full implementation, just high-level pseudo-code.