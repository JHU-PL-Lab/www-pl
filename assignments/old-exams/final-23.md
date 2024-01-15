<meta http-equiv="content-type" content="text/html; charset=utf-8" />

## Programming Languages Final Exam Spring 2023

Your Name (please **print neatly** to help Gradescope automatically recognize it): ______________________________________

Note that for any *single* numbered question 1. - 5. below, the word "freebie" as your answer will get you full points on that question.

1.  (12 points) This question concerns some key mathematical relations defined and used in the course, and how they relate to (OCaml) implementations of those relations.  For each mathematical relation state what parameters are naturally inputs and what parameters are naturally outputs in the implementation of that relation. All of the parameters are naturally inputs or outputs.

    a. For **Fb**, the e ==> v relation

    b. For **TFb**, the &Gamma; &#124;- e : &tau; relation

    c. For **AFbV**, the e =S=> v relation

    d. For **EFb**, the &Gamma; &#124;- e : &tau; \ E relation

    <p style="page-break-after:always;"></p>


2.  (15 points) The book listed some laws for opertional equivalence ~= for **Fb**.  Let us consider some other possible laws.  Consider each of the following statements and categorize it as 1) true but not provable with the existing laws (so it would be good as a new law), 2) true *and* provable with the existing laws (give the proof in such a case, including all the laws used in the proof), or 3) false (prove that it is false in such a case).  Recall that in all laws, e, v, and x denote arbitrary expressions, value expressions, and variables, respectively.

    a. Not(Not(x)) ~= x

    b. (Fun x -> x) e ~= e

    c. e + x ~= x + e

    d. x e ~= x e' if e ~= e'

    e. Let x = e1 in e2 ~= e2[e1/x]

    <p style="page-break-after:always;"></p>

3.  (10 points) Consider the language **FbLog**, **Fb** with logging. Additional expression `Log("logging this",e)` will dump the log string plus the value of `e` in a log and will also return the result of `e` as its value. 

    a. Logging is a side effect like state and actors; propose a side-effecting operational semantics for **FbLog**, and write the operational semantics rules for the new `Log` statement rule, the new value rule plus the rule for `Let` (the other rules will be similar so no need to write them out).  Make sure your relation keeps the logging messages preserved in the same order they were issues in the program run.

    b. Recall that Leibnizian equivalence is based on the philosophy that two things are considered equivalent if "no observations can tell them apart".  For **Fb** operational equivalence ~= we used equi-termination in all contexts C as the notion of "all observations".  There are two potentially different notions of operational equivalence for **FbLog** programs.  One is to just view logging as irrelevant debugging information that is not an "observable" as far as Leibniz is concerned.  The other is to consider expressions to be equivalent only if they also have the same logging output.  Define these two notions of equivalence for **FbLog** programs, notate the first one just ~= and the second one ~==.

    <p style="page-break-after:always;"></p>

4.  (15 points) We studied two ways that object-like behavior could be achieved in languages without official objects per se.  One was in **FbSR** where we showed that records sufficed to express object coding patterns.  The other was in the Actor language **AFbV** where variants were used to encode objects.

    Let us compare these two encodings on examples.  Consider a (functional) object which has a field that is a number `n`, as well as method `flip` which returns the negation of `n` (not an object holding the negation, just the raw number) as well as method `is_zero` which you *must* to implement by sending a message to self checking if `flip` of field `n`  returns the same value as `n` which means `n` must be zero (yes this is very artificial, directly checking if `n` is zero is the way it would be done in practice). 

    a. For this question, first encode this simple object in **FbR** -- complete the following code:
    ```ocaml
    Let flipper_class = ..your code for a factory making flipper objects when passed a number n .. In 
    Let flipper = flipper_class 4 In 
      flipper.iszero flipper {} (* pass the object itself as a parameter as in our encoding *)
    ```
    -- The `iszero` call should invoke `flip` in turn and return `False` since `flip(4) = 4` should fail

    b. Now repeat this simple object example but using a *variant* encoding for the object roughly following how the **AFbV** examples worked: messages are variants.  So fill in the code
    ```ocaml
    Let flipper_class = ..your code for a factory making variant-style flipper objects when passed a number n .. In 
    Let flipper = flipper_class 4 In 
      flipper flipper `iszero({})  (* observe how we pass the self here before the message, make your code meet this interface *)
    ```

    <p style="page-break-after:always;"></p>

5.  (20 points) This question concerns subtyping and **STFbR**.

    a. The intuition for subtyping can be unintuitive, and to help in understanding what is a subtype of what we gave an interpretation of types in terms of sets in lecture: subtypes are subsets in the set interpretation of types.  For the example types `{ m : {}; b : Bool }` vs `{ b : Bool }` draw a Venn diagram showing the elements of the two types as sets, and use the diagram to clarify which is a subset (and thus subtype) of which.  Note you only need to show value elements, for example `{ b = Not (Not False) }` is an element of the second type but you need not show that one.

    b. Now, verify you got the subset relation correct in a. by either proving subtyping `{ m : {}; b : Bool } <: { b : Bool }` or `{  b : Bool } <: { m : {}; b : Bool }` using the **STFbR** subtyping rules.

    c. Now repeat a. but for the two types `{ m : {}; b : Bool } -> Bool` vs `{ b : Bool } -> Bool`.  You need not list all elements in your diagram, only some representative ones.

    d. Repeat b. but for the two types of c.

    e. Now give *any* legal proof &empty; &#124;- e : &tau; in the **STFbR** proof rules for *any* particualar e and &tau; which **requires** the use of the subtyping proof in b. to be proved.

    <p style="page-break-after:always;"></p>

<p style="page-break-after:always;"></p>

(Blank page, if you run out of room on any question say "see blank" and write here)
