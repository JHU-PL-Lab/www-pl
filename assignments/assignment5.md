## Assignment 5: Operational Equivalance, Records, Variants, State


1.  (10 points) Write an **Fb** function `cheapY` which works like the `Y`-combinator but only supports ten levels deep of recursive call. So for example

    ```ocaml
    cheapY (Function this -> Function x -> If x = 1 then 1 Else x + this (x-1)) 10
    ```

    returns `55` but if the `10` was replaced with `11` it diverges since the recursion tried to go 11 levels deep. This behavior is the same as a recursive function invocation with a runtime stack depth of at most 10 in e.g. the C language. Hint: you don't actually need a counter to count the number of recursive calls, it is easier than that.


2. (25 points) For each of the following potential operational equivalences for Fb, either prove that it holds by using the principles in Section 2.4.2 (using only a sequence of those principles and explicitly mentioning which principle is used in each step of the sequence -- like a geometry proof), or present a counterexample context C invalidating it by the definition of ~= in Section 2.4.1.

     a. `Fun x -> x + 1` =~ `Fun a -> (fun y -> y + 1) a`

     b. `Let x = f 1 + 2 In 0` ~= `1 - 1`

     c. `f 1` ~= `((Fun x -> x x) (Fun x -> x x))`

     d. `(Fun b -> True And b)` ~= `(Fun x -> Fun y -> x And y) True`

     e. `Fun x -> (Fun a -> a + 2) 3` ~= `Fun x -> 5`

    (Note that when you fill in the hole in a context *C*[*e*] for a counterexample, you should not change the parse precedence; in other words,  *C*[*e*] is always the same as *C*[`(`*e*`)`].)
  
3. (10 points) Consider **FbG**, an Fb extension with a very simple notion of mutable state: there is only one fixed, global memory location. Here is the new syntax.
        
        ```ocaml
        e ::= (* all Fb clauses *) | Stash e | Unstash
	    ```

    And here is a very simple program to hopefully make clear how it works.

	```ocaml
    (Let _ = Stash 5 In Unstash) + Unstash => 10
	```
    
    If you try to `Unstash` before having stashed anything you will get stuck.  `Stash`'s only purpose is the side effect it has on the global store, and this informal specification is silent on what actual value it returns.

    (a) Write the operational semantics rules for **FbG**.  Give rules for the two new operations as well as what the `+` rule will now look like in **FbG** (all the rules will need to change a bit due to the side effects, just as with **FbS**).
	
    (b) Write out the derivation for the above example with your rules (you didn't write out the `Let` rule but use the expected rule in your derivation).

4.  (10 points) Although **FbR** doesn't have built-in lists, we can encode lists and their operations in **FbR** using records. For this question, the goal is to take a program with list syntax `[]`, `::`, `Head`, and `Tail` (but no pattern matching on lists), such as

    ```ocaml
    Let l = 1 :: 2 :: 3 :: [] In
    (Head (Tail l)) = 2
    ```

    and to define an equivalent (i.e. returning the same result) **FbR** program which uses records to encode list structures.

    (a) Define empty list, Cons (equivalent to (::)), Head, and Tail as macros using records.  Note you will need to use records to encode lists, don't just use the list encoding in the book which did not use records.

    (b) Translate the above program to **FbR** using your record encoding from (a).  Your encoding should be such that the concept should work for any program using these list operations, don't just make something working for this example.

5. (10 points) Make operational semantics rules for the freeze and thaw macros we defined for **Fb**. This means we are making a new programming language, **FbFT** (**Fb** extended with freeze and thaw).  You _must_ write a rule that actually does the "work" of the construct; don't just make a rule which is just expanding like a macro.  Concretely, your rule(s) *cannot* have any `Fun ..` or applications in them either above or below the line.  To help you get going, the grammar for **FbFT** is as follows:

    ```ocaml
    v ::= (* all Fb clauses *) | Freeze(e) 
    e ::= (* all Fb clauses *) | Thaw(e)
    ```
    You don't need to write out all the existing Fb rules, it is OK to state (* insert all Fb rules here *).


### Submission and Grading

Upload your homework pdf to Gradescope as was done in HW 3. *Please remember to list any collaborators at the top of your submission as was done in assignments 1-4*.