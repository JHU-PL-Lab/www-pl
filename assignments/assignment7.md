## Assigment 7: Actors

This homework focuses on the actor model and actor programming in **AFbV**.  The AFbV examples run in class may be found in the [`afbv_examples.ml`](../ocaml/code/afbv_examples.ml) file.

This file also contains instructions on how to run the reference interpreter and to set up utop for easy testing of your actor code.  As a warm-up, turn on some of the debugging flags in comments at the top and `peu` some of the examples in that file. (Note that the message debug flag was recently fixed so if you want to use that please grab a fresh copy of the zip file to get the latest reference implementation (only the file `./reference/AFbV/toplevel.exe` is changed).)


For this assignment you are going to write a set data structure in AFbV.   For all the questions, include the answers in a file `assignment7.ml` as let-defined strings (or as OCaml comments for the written questions).

   a. For your first implementation, the set actor should respond to the following messages:
   * `` `add(v)`` - add value `v` to the set (ignore if `v` is already in the set)
   * `` `delete(v)`` - delete value `v` from the set (ignore if `v` is not in the set)
   * `` `isempty(a) `` -  If the set is empty, send `a <- True`; if not, in the set send `a <- False`
   * `` `contains(v,a) `` - if `v` is in the set, send `a <- True`; if `v` is not in the set, send `a <- False`

 
   Note that **AFbV** has lists which can be used for implementing your set.  There is no pattern-matching on lists however, you must use `Head(..)` and `Tail(..)` to access the head and tail, and `..= []` to test for an empty list.  You can write lists as `[1;2;3]` and consing with `::` just like in OCaml.  AFbV also has pairs, as can be seen in the `` `contains`` message above.  `Fst` and `Snd` extract the first and second components of a pair, respectively.

   ```ocaml
   let a7a : string = (* YOUR SET BEHAVIOR HERE as a string *);;
   ```

   Here is a sample runner which will send a few messages to your set.
   ```ocaml
   let a7a_tester = 
   "Let set_beh = ("^a7a^")  In
   Let test_beh = Fun me -> Fun _ -> Fun _ ->  
     Let s = Create(set_beh,[]) (* The [] here is a dummy like () in OCaml *) In
       (s <- `add(1)); (s <- `delete(1)); (s <- `add(3)); (s <- `contains(3,me));
       Fun m -> (Print \"contains(3) returned \"); (Print (m))
   In Let test = Create(test_beh,0)
   In test <- []";;
   ```

   b. Unfortunately the above API we gave you is not a good one: it violates what you would expect out of set behavior since it can shuffle the order that messages are processed in.  One property of actors discussed in class was arrival order nondeterminism, namely messages need not arrive in the order they were sent (you need to set `deterministic_delivery := true;;` to make things deterministic; **AFbV** by default is non-deterministic).  Describe how the above set actor API may not work properly, by giving a sequence of global actor states G0 -> G1 -> G2 of a computation involving the above set actor such that it is not functioning correctly as a set (even if the adding/removing/etc code is all locally correct).  Include your answer as a comment of the form

   ```ocaml
   (* a7b. YOUR ANSWER *)
   ```
   in the `assignment7.ml` file.  Note that you can give your answer in the format `show_states := true` produces.  Please don't include any of the actor code in your answers, "..." will do in place of any code.


   c.  Another way to see why things may not work correctly is to consider how the initial `test <- []` message gets processed: processing this message will be performed by a `e =S=> v` relation as per the local actor stepping relation (defined in lecture and in 7.2.5 in the book).  Give what the `e`, `S`, and `v` will be in this case.  Answer this question in a comment again:

   ```ocaml
   (* a7c. YOUR ANSWER *)
   ```
   
   To solve this problem, actors often need to explicitly send some sort of `` `ack`` message to indicate a task has completed, and the next action of the user of the data structure must be to listen for this `` `ack`` before performing another operation on the data structure.  The `count_server_eg` example in the examples file illustrates this behavior.  

   d. For this part, we will fix the above set API.  Concretely, we will add an actor (the "customer") to which addition and deletion acknowledgements may be sent:

 * `` `add(v,a)`` - add value `v` to the set (ignore if `v` is already in the set), **and** send ``a <- `ack([])``
 * `` `delete(v,a)`` - delete value `v` from the set (ignore if `v` is not in the set), **and** send ``a <- `ack([])``
    
Concretely, add lines

```ocaml
let a7d : string = (* YOUR REVISED SET BEHAVIOR HERE as a string *);;
```

which is the behavior of this improved set data structure and

```ocaml
let a7d_tester : string = (* REVISED a7a_tester which tests a7d now *)";;
```

to the `assignment7.ml` file which is a modification of the tester in a7a to perform the same sequence of add/delete/contains but using the fixed protocol.  In this case we should be guaranteed to get the correct result of `True` printed.

### Submission

Upload your `assignment7.ml` file to Gradescope.  The OCaml code in your file should only define the indicated strings, it should not run anything (no `peu` etc in it.)