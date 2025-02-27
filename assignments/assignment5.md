## Assignment 5: Fb Programming, Y, Operational Equivalance, Records and Variants

This assignment has two parts.  Part I consists of some short Fb programs you will need to write, and the second part is some written questions.  There are two separate Gradescope submission points for the two parts.  

(Note that you can e.g. use one flex day to turn in *both* of them up to one day later -- consider it as one assignment when it comes to submission deadline and flex days.)

### Part I: Fb programming

Download [`assignment5.ml`](assignment5.ml) and code up the indicated Fb programs in this file.  

#### Part I Submission and Grading

Submit (only) the `assignment5.ml` file to the Assignment 5 Part I autograder.

### Part II: Y-Combinator, Operational Equivalance, Records, Variants

These are "paper" questions not coding questions, and you will submit a pdf solution.  Of course feel free to use the **Fb** interpreter to test any of your answers below.

1.  (10 points) Write an **Fb** function `cheapY` which works like the `Y`-combinator but only supports ten levels deep of recursive call. So for example

    ```ocaml
    cheapY (Function this -> Function x -> If x = 1 then 1 Else x + this (x-1)) 10
    ```

    returns `55` but if the `10` was replaced with `11` it diverges since the recursion tried to go 11 levels deep. This behavior is the same as a recursive function invocation with a runtime stack depth of at most 10 in e.g. the C language. Hint: you don't actually need a counter to count the number of recursive calls, it is easier than that.


2. (20 points) For each of the following potential operational equivalences for Fb, either prove that it holds by using the principles in Section 2.4.2 (using only a sequence of those principles and explicitly mentioning which principle is used in each step of the sequence -- like a geometry proof), or present a counterexample context C invalidating it by the definition of ~= in Section 2.4.1.

     a. `Fun x -> x + 1` =~ `Fun a -> (Fun y -> y + 1) a`
    
     b. `Let x = f 1 + 2 In 0` ~= `1 - 1`

     c. `Fun x -> If y Then Fun y -> x + y Else f x` ~= `Fun y -> If x Then Fun x -> y + x Else f y`

     d. `Fun a -> Fun b -> a + b` ~= `Fun b -> Fun a -> b + a`

    (Note that when you fill in the hole in a context *C*[*e*] for a counterexample, you should not change the parse precedence; in other words,  *C*[*e*] is always the same as *C*[`(`*e*`)`].)
  
3. (10 points) We primarily focused on operational equivalence for **Fb** during the course, but the definition naturally generalizes to other languages we studied (and even to JavaScript, Python, etc).  For example for **FbV**, the definition of ~= will read identically and the only difference is the contexts C will be **FbV** contexts not **Fb** contexts, and the ==> evaluation relation will also be **FbV**'s.

     a. For the theory of **FbV** operational equivalence, propose one useful ~= law to add to the **Fb** laws we had such as beta, etc.  Your law needs to deal with the new variant syntax and should be a useful and general law, not something vacuous like `n(v) ~= n(v)`.

     b. Use your new **FbV** law and the existing **Fb** laws to prove 
        `Match 'Red(Fun x -> x) With | 'Red f -> 'Green (f 5)  | 'Green m -> 'Red (Fun x -> x + y) ~= 'Green(5)`. Show your steps and name any laws used.

4.  (10 points) Although **FbR** doesn't have built-in pairs, we can encode pairs and their operations in **FbR** using records. For this question, the goal is to take a program with pairs syntax `(e1, e2)`, `Fst`, and `Snd` (but no pattern matching on pairs), such as

    ```ocaml
    Let p = (1, (2, 3)) In
    (Fst (Snd p)) = 2
    ```

    and to define an equivalent (i.e. returning the same result) **FbR** program which uses records to encode pairs.

    (a) Define the pair constructor, `Fst`, and `Snd` as macros using **FbR**. 

    (b) Translate the above program to **FbR** using your pair encoding from (a). Your encoding should be such that the concept should work for any program using these pair operations, don't just make something working for this example.

5. (10 points) For the following **FbR/FbV** programs, either prove it has a value (by building the operational semantics proof tree) **or** argue that the program has no value.  Both of these systems were presented in lecture, tne the **FbV** system is also in the book.

     a. **FbV**: ``(Fun yn -> Match yn With `Yes(x) -> 3 | `No(y) -> y) (`No(3))``

     b. **FbR**: ``(Fun r1 -> Fun r2 -> If r1.c Then r1.a Else {a = r2.c}) {a = 1; c = True} {a = False; c = 2}``

#### Part II Submission

Upload your homework pdf to the Gradescope Assignment 5 Part II submission point. *Please remember to list any collaborators at the top of your submission*.