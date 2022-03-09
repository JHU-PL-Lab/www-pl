## Assignment 5: Operational Equivalance, Records, Variants


1.  (10 points) Write an **Fb** function `cheapY` which works like the `Y`-combinator but only supports ten levels deep of recursive call. So for example

    ```ocaml
    cheapY (Function this -> Function x -> If x = 1 then 1 Else x + this (x-1)) 10
    ```

    returns `55` but if the `10` was replaced with `11` it diverges since the recursion tried to go 11 levels deep. This behavior is the same as a recursive function invocation with a runtime stack depth of at most 10 in e.g. the C language. Hint: you don't actually need a counter to count the number of recursive calls, it is easier than that.


2. (20 points) For each of the following potential operational equivalences for Fb, either prove that it holds by using the principles in Section 2.4.2 (using only a sequence of those principles and explicitly mentioning which principle is used in each step of the sequence -- like a geometry proof), or present a counterexample context C invalidating it by the definition of ~= in Section 2.4.1.

     a. `Fun x -> (Fun y -> Not y) False` =~ `Fun x -> True`

     b. `Let x = f 0 In 0` ~= `0`

     c. `(0 1)` ~= `((Fun x -> 0) 1)`

     d. `(Fun x -> x = 0)` ~= `(Fun op -> Fun x -> op x 0)(Fun n1 -> Fun n2 -> n1 = n2)`

    (Note that when you fill in the hole in a context *C*[*e*] for a counterexample, you should not change the parse precedence; in other words,  *C*[*e*] is always the same as *C*[`(`*e*`)`].)
  
3.  (20 points)  In lecture we defined **FbR2**, a record language which for simplicity always has *two* fields only.  

     a. Generalize the grammar and rules given in lecture for **FbR2** to the case of full records, **FbR**: they can have from 0 to n fields in a given record.  Note that the book only gives an interpreter for **FbR** so it not much help.
     
     b. Use your rules to show 
     ```ocaml
     Let f = Fun x -> { w = x - 1} In (f 2).w ⇒ 1
     ```
     by building the full proof tree.

4.  (15 points) In lecture we outlined how records could be used to encode variants: every *definition* of a variant could be encoded by a *use* (projection) of a record, and every *use* of a variant could be encoded as a *definition* of a record.  The opposite is also possible, encoding records in terms of variants.  For this question, take the small example **FbR** program

    ```ocaml
    Let r = {w = 4; h = 6 + 5 } In r.h + 3
    ```

    and define an equivalent **FbV** program (i.e. returning the same result) which follows the  pattern of the record encoding of variants: encode record definitions as variant uses (`Match`es), and encodes record uses as variant definitions.  Your answer will need to look like this:

    ```ocaml
    Let r = (* ... some FbV code with a Match *) In (* Some FbV code with a variant definition *)+ 3
    ```

    Your encoding should be such that the concept should work for any record definition and use, so don't just make something working for this example.

5. (10 points) Make direct operational semantics rules for the freeze and thaw macros we defined for **Fb**. This means we are making a new programming language, **FbFT** (**Fb** extended with freeze and thaw).  You _must_ write a rule that actually does the "work" of the construct; don't just make a rule which is justr expanding like a macro.  Concretely, your rule(s) *cannot* have any `Fun ..` or applications in them either above or below the line.  To help you get going, the grammar for **FbFT** is as follows:

    ```ocaml
    v ::= (* all Fb clauses *) | Freeze(e) 
    e ::= (* all Fb clauses *) | Thaw(e)
    ```
    You don't need to write out all the existing Fb rules, it is OK to state (* insert all Fb rules here *).


### Submission and Grading

Upload your homework pdf to Gradescope as was done in HW 3. *Please remember to list any collaborators at the top of your submission as was done in assignments 1-4*.