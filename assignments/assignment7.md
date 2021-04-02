## Assigment 7 - Actors

For this assignment you will want to consult the book chapter 7 and the [`afbv_examples.ml`](../ocaml/code/afbv_examples.ml) file of **AFbV** examples we ran during lecture.  (Note that the actor debug flags did not work correctly on the FbDK until recently, so grab a fresh copy of the zip file to run the **AFbV** interpreter with debug information.  The examples file contains instructions on how to run **AFbV**.)

1. (20 points) In the Actors lecture a simple example was used which included two actors and three messages.  After lecture I wrote out **AFbV** code for that example which is called `lecture_example` in [`afbv_examples.ml`](../ocaml/code/afbv_examples.ml).  Unfortunately, the example I gave in lecture proved to be not exactly programmable in **AFbV** -- it required actors `a1` and `a2` to each know about each other at the start, but this is something like mutual recursion: recall how in OCaml you cannot define mutual recursion without the special `.. and ..` syntax.

   So, the `lecture_example` is *nearly* the same as the example in class, but when `a1` receives its first message it *both* creates `a2` and sends it a message.

   a. Show the global progression of the actor system bootstrapped by `lecture_example` in the mathematical notation used in the book:  Give the *G0*-*G3* such that *G0 -> G1 -> G2 -> G3* where each *Gi* is a global set of actors and messages.  Note you don't need give the complete actor code in the set, you can write something like `<a1,Fun msg -> ... >` where you can use  `...` instead of writing out all the code.
   Hint: if you load in the AFbV interpreter into `utop` and set `show_states := true;;` and run `peu lecture_example;;` the debug information is mostly the answer to this question, just put it in set form in the book's notation.

2. (10 points) For this question, again for the same example you are to elaborate on how the operational semantics rules works for when `a1` receives and processes the ``a1 <- `hi(7)`` message -- this is the step from *G0* to *G1*.  Concretely, give the details of this step in terms of what `e =S=> v` is computed, giving the `e`, the `v`, and the `S`.  You don't need to write out the whole proof tree, it is large.


3. (25 points) One issue with actor messaging is it is *asynchronous* -- there is no waiting for a reply.  So, if you in fact needed the answer before proceeding, you would instead operate under a protocol where the receiver would send a `` `return(..)`` message back to you which was "just another message", and you would subsequently handle that.  And, in order for the receiving actor to know who to `` `return`` to, we must pass that actor name in the message itself; this name is called the "customer" in actor-speak.

   a. We first specify the behavior of a stack actor, and show how it is to be used.  Your job is then to define the stack actor behavior.

   The stack actor has a behavior (code) `stack_behavior` which is what you will need to write.  It needs to operate under the following protocol:

   - `Create(stack_behavior,...)` will create a new stack actor with an empty stack; the `...` can be anything, it is ignored.
   - If `as` was the result returned by the above `Create`, we can send it the following stack messages:

      `as <- push(a,v)` is customer `a` asking to push v on the `as` stack.  Note `(a,v)` is a pair which is legal syntax of **AFbV** (`Fst(e)` and `Snd(e)` access the first and second components).  The `as` should push value `v` on it's internal stack, and reply `` a <- `return(..anything..)`` -- the customer needs to know the stack push is finished.

      `as <- is_empty(a)` will reply `a <- True` to the customer `a` if the stack is empty, and `a <- False` otherwise.

      `as <- pop(a)` will pop the top element `v` from its stack, and will return `` `some(v)`` if the stack was not empty, and `` `none(0)`` otherwise.

   In order to make life easier for you, we have made a test harness which will push a few items on the stack and verify they come off.  See file [`assignment7-q3.ml`](assignment7-q3.ml) for this test.  You will also put your answer in the indicated spot in this file, and we will put up a separate code upload of this question for the autograder.

  4. (10 points) In the test harness code in the [`assignment7-q3.ml`](assignment7-q3.ml) file it awaited a reply before sending the next stack message.  Describe in terms of the actor system evolution why if we instead had the simpler test body below why this would not be an appropriate test.  You can use the **AFbV** interpreter to help you answer this question but your answer needs to be a *G0 -> G1 -> ..*  evolution as in question 1 above which will print "Fail".

```ocaml
    Let as = Create(stack_behavior,0) In
    (as <- `push(32,me));
    (as <- `push(22,me));
    (as <- `pop(me));
    (Fun msg -> Match msg With
           `some(x) -> If x = 22 Then Print \"Success\" Else Print \"Fail\") In..
```
