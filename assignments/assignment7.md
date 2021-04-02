## Assigment 7 - Actors

For this assignment you will want to consult the book chapter 7 and the [`afbv_examples.ml`](../ocaml/code/afbv_examples.ml) file of **AFbV** examples we ran during lecture.  (Note that the actor debug flags did not work correctly on the FbDK until recently, so grab a fresh copy of the zip file to run the **AFbV** interpreter with debug information.  The examples file contains instructions on how to run **AFbV**.)

1. In the Actors lecture a simple example was used which included two actors and three messages.  After lecture I wrote out **AFbV** code for that example which is called `lecture_example` in [`afbv_examples.ml`](../ocaml/code/afbv_examples.ml).  Unfortunately, the example I gave in lecture proved to be not exactly programmable in **AFbV** -- it required actors `a1` and `a2` to each know about each other at the start, but this is something like mutual recursion: recall how in OCaml you cannot define mutual recursion without the special `.. and ..` syntax.

   So, the `lecture_example` is *nearly* the same as the example in class, but when `a1` receives its first message it *both* creates `a2` and sends it a message.

   a. Show the global progression of the actor system bootstrapped by `lecture_example` in the mathematical notation used in the book:  Give the *G0*-*G3* such that *G0 -> G1 -> G2 -> G3* where each *Gi* is a global set of actors and messages.  Note you don't need give the complete actor code in the set, you can write something like `<a1,Fun msg -> ... >` where you can use  `...` instead of writing out all the code.
   Hint: if you load in the AFbV interpreter into `utop` and set `show_states := true;;` and run `peu lecture_example;;` the debug information is mostly the answer to this question, just put it in set form in the book's notation.

2. For this question, again for the same example you are to elaborate on how the operational semantics rules works for when `a1` receives and processes the ``a1 <- `hi(7)`` message -- this is the step from *G0* to *G1*.  Concretely, give the details of this step in terms of what `e =S=> v` is computed, giving the `e`, the `v`, and the `S`.  You don't need to write out the whole proof tree, it is large.


3. For this question we are going to develop some improved syntax (and semantics) to solve the  problem of mutual reference between actors.

   Consider an extension to **AFbV** called **AFbV2** which adds the new syntax `Create2(e1,e2; e1',e2')` that is similar to the existing `Create(e1,e2)` to create an actor with code `e1` and initial data `e2`, but it is creating *two* actors instead of one: `e1` and `e1'` are the code portions of the two actors, and `e2` and `e2'` are their initial data values.  And, to allow mutual reference each actor will get passed *both* its own address (as with the current `Create`) *and* the *other* actor's address for the pair.

   First, write out a proposed operational semantics rule for `Create2` which can be added to the existing **AFbV** rules to make the **AFbV2** rules.  Note that **AFbV** as implemented includes pairs, and you are welcome to use those pairs as part of your new operational semantics: pairing `(e1, e2)` and operations `Fst(e)` and `Snd(e)` to get out the first and second components of a pair.  

   Then, copy the `lecture_example` code from the file and re-write it so that the boostrap code `Let a1 = Create(a1_behavior,0)` is replaced with code using `Create2` that creates *both* `a1` and `a2` who will know about each other, meaning that `a1` no longer needs to create `a2`.  (Note that you will not be able to run it since `Create2` is not implemented.)

