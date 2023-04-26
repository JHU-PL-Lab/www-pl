<meta http-equiv="content-type" content="text/html; charset=utf-8" />

## Programming Languages Final Exam 2022

Your Name (please **print very neatly** to help Gradescope recognize it): _________________________________

1.  (20 points) For this question we will consider **FbAb**, **Fb** with in addition an `Abort` expression which will abort the current computation and just return `Abort` as the final value.  So for example `5 + Abort ⇒ Abort`, `If True Then Abort Else 0 ⇒ Abort`, etc.  Note that `If False Then Abort Else 0 ⇒ 0`, the `Abort` in this case did not run.  The grammar for **FbAb** is the same as for **Fb**, but in addition there is the extra expression `Abort`.

    a. Define the operational semantics rules for **FbAb**.  Feel free to use shorthand to reference the existing rules without writing down all the details.

    b. Is `Abort` a side effecting operation, or not?  Briefly justify your answer.

    c. Define a reasonable notion of operational equivalence `~=` for **FbAb** following how we defined `~=` for **Fb**.  Some reasonable equations and inequations that should hold include e.g. `1 + 2 ~= 3`, `Abort + Abort ~= Abort`, `0 ~= 1` should fail, etc.

    d. Do any of the **Fb** `~=` laws in the book fail to hold for **FbAb**?  If, so list them.  If not, just write "no laws in the book fail".

    <p style="page-break-after:always;"></p>

2.  (12 points) OCaml supports limits on mutation, for example built-in `list`s are immutable.  For this question we will consider degrees of mutability of different types of lists in OCaml.

    a. Recall that in lecture we noted that lists could in fact be implemented in existing OCaml as  `type 'a list = Mt | Cons of 'a * 'a list`.  For this question, define an OCaml type `'a mut_list` similar to this type but where individual elements of the list can be mutated.  Only individual elements should mutate in your type, we can't e.g. change the length of the list by mutation.

    b. A different form of mutation that could be added to lists is allowing the list structure itself to change.  This would allow e.g. list `append` to be defined in-place, i.e. two lists could be "glued" together directly without copying one of them (i.e. like how linked lists work in C).  Define an OCaml type `'a linked_list` which would support such an operation, again as a variant of the above type.

    c. Use your `linked_list` type in b. to write an OCaml implementation of in-place `append : 'a linked_list -> 'a linked_list -> 'a linked_list` as referenced in that question. You don't need to be perfect in your OCaml syntax, we are only looking for the spirit of the answer, a list append that performs no copying.

    <p style="page-break-after:always;"></p>

3.  (6 points) This question concerns **AFbV**.  When actors are created, they are told about their own address.

    a. Write out the actor operational semantics `Create` rule and point out where this in fact happens.

    b. Why do we need to tell actors about their own address?  In other words, why is this extra self-notice necessary for actor programming?

    <p style="page-break-after:always;"></p>

4.  (15 points) We defined type inference for **EFb** which included only **Fb** syntax, but the principles there naturally extend to the other language features such as records, state, variants and the like.  For this question we will consider **EFbS**, an extension of **EFb** to include the syntax of **FbS**: `Ref e`, `!e`, and `e := e`.  We will only need to add the clause `τ Ref` to the type grammar.  Note that these reference types are the same as the `τ ref` types of OCaml and the `τ Ref` of **TFbSRX**, the `τ` is the (fixed) type of the contents of the cell.

    a. Give the new type inference rules `Γ ⊢ e : τ \ E` needed for this syntax.  Make sure your rules are *inference* rules, they should assume nothing about what is above the line, and all (closed) programs should produce derivations using the rules.  Any constraining needs to be done in the equations `E` alone.

    b. Give new `E` set closure rules needed if any, describing what constraints in `E` imply what new constraints we need to add to `E`.

    c. Add any new clauses needed for the consistency check, in particular listing any new immediately inconsistent constraints which will be considered type errors.

    <p style="page-break-after:always;"></p>

5.  (8 points) Administrative Normal Form (ANF) is an equivalent form for expressions which makes the order of evaluation more explicit.  For example, **Fb** expression `(f (x + 5)) - 2` in ANF would be `Let x1 = x + 5 In Let x2 = f x1 In Let x3 = x2 - 2 In x3`.  These two expressions are doing the same operations in the same order, and are operationally equivalent.  Prove this fact step-by-step either using only the `~=` laws in the book, or with the laws plus an additional (sound) law you propose to add.  Don't add a law unless it is absolutely needed.

    <p style="page-break-after:always;"></p>

6.  (10 points) We didn't mention anything about the **STFbR** operational semantics, but it is exactly the same as **FbR**'s operational semantics if you remove the type declarations from expressions. Now, suppose we extended the **STFbR** operational semantics to **STFbR++** which allows records to overload as integers, the number being the count of how many fields the record has (note this is just a silly idea for this question, it is not anything we would actually want to do in a real programming language).  So in **STFbR++** operational semantics it would be the case that `4 + {a = 5; b = True} ⇒ 6` since this record has two fields; the values of the fields are irrelevant.  Records would also still work as usual for projections so this is a strict extension to the run-time capability.

    a. Modify the **STFbR** subtype rules (*only*) by adding one or more rules such that this example and others will in fact type-check in the **STFbR++** type system.

    b. Write out the proof that the above program typechecks to confirm your new subtype rule(s) work.


  
    <p style="page-break-after:always;"></p>

(Blank page one, if you run out of room on any question say "see blank one" and write here)


<p style="page-break-after:always;"></p>

(Blank page two, if you run out of room on any question say "see blank two" and write here)