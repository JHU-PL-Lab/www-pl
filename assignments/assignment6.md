## Assignment 6: State, Exceptions, Objects

1.  (6 points) Let us consider the language **FbSE**: **Fb** with state and a new feature we will call "state erasure". This language has all of the syntax and semantics of **FbS** as well as a new expression form: `Erase`. `Erase` always evaluates to `0`, but it has a side effect of throwing away all existing state information. As a result, any dereference (such as `!x`) immediately after an `Erase` will get stuck (not evaluate to any value) since the state lookup will not succeed; only cells allocated after an `Erase` will be able to be dereferenced. For this question you are to extend the **FbS** rules by writing an operational semantics rule(s) for this new `Erase` expression.

2. (10 points) For this question we want to develop a stateful language with "state snapback" -- its syntax is **FbS** but with two additional pieces of syntax, `Checkpoint` and `Snapback`, which are expressions (not values). Executing `Checkpoint` makes a full checkpoint of the current state; later on if `Snapback` is ever executed it *rolls back* all of the values that were checkpointed to their previously checkpointed values. We will call this new language **FbSnap**. For this question you are to write the operational semantics rules for **FbSnap**. Since there are many rules you only need to give the rules for function application, assignment `:=`, `Checkpoint`, and `Snapback`. 

   Here are answers to a few questions you may have. First, start with the **FbS** operational semantics as your basis. Note that any newly allocated locations should still be kept around at snapback -- new memory locations could have been allocated since the previous checkpoint and variables could reference them, so only snap back for the things that existed back then. The checkpoint is global in the sense that a second checkpointing just overwrites any previous checkpoint if any. (Hint: the operational semantics execution state should be a triple here, not a pair as was the case in **FbS**.) Here are a few examples of evaluations (only showing the initial and final values, not the full state).

* `Let x = Ref 5 In (Checkpoint; x := 3; Snapback; !x)` returns `5`
*  `Checkpoint; Let x = Ref 5 In (Snapback; !x)` returns `5` (only values checkpointed are snapped back)
* `Let x = Ref 5 In (Snapback; !x)` returns `5` (no checkpoint so nothing to snapback)
* `Let x = Ref 5 In (Checkpoint; x := 3; Checkpoint; x := 6; Snapback; !x)` returns `3`

3.  (12 points) We can define operational equivalence for a hypothetical language **FbSRX** that combines both state and exceptions, using an analogous notion as with **Fb**: they equi-terminate in all **FbSRX** program contexts.  

    a. Write out this definition using mathematical notation, analogous to Definition 2.16 in the book but for **FbSRX** instead of **Fb**.  Note that **FbSRX** operational semantics will need to look like **FbS** in terms of having the state S as part of the operational semantics configuration.  We did not cover this explicit system but for this question you can just think of it as a union of **FbS** and **FbX**.

    Which of these potential **FbSRX** operational equivalences in fact hold? Give a *counterexample FbSRX context C* for the ones that are false to demonstrate that fact.  For the ones you believe to be true, just mention that fact, no supporting evidence is needed.

    b. `Try True with #wipeout(x) -> False ~= False`

    c. `(Raise #wipeout(4)) + 4 =~ 7 - (Raise #wipeout(5))`

    d. `Let x = Ref 5 in 5 =~ 5`

    e. `(Let c = Ref 0 In c := c; !c) =~ (Let c = Ref 0 In c := c; c)`

4.  (8 points) This question addresses the gap in **Fb** when run-time type errors occur: expressions such as `4 + True` or `4 3` do not evaluate to anything, which is the same as a nonterminating computation. In this question we consider adding an extension to **FbX**, to have some exception mechanism that can raise exceptions for these dynamic type errors (we are using **FbX** just because it has exceptions, and that is what we need to raise when one of these errors is hit). Let us call this language **FbDX** for Dynamic **FbX**. Our desire is to have **FbDX** raise an exception, `Raise #TypeErr 0`, whenever one of these runtime type mismatch cases arise. `#TypeErr` will be the name of the special exception for (all) such type errors, and `0` is the required argument. This is a very simple form of exception, we would likely want a fancier form in a real language.  

     a. Write the additional **FbDX** operational semantics rules which would raise exceptions in the cases where **Fb** would have gotten stuck due to a run-time type mismatch on a `+` operation (all the other type mismatches for function application, etc are similar; for simplicity you only need to do "`+`" for this question). Make the rules clear and unambigous.  

     b. Now write a `Let safeadd = Fun x -> Fun y -> ...` function in **FbDX** itself which is "fault tolerant": `safeadd` will return `0` in the case that either argument was not a number, and do the addition otherwise.

5. (10 points) Recall the following encoding of a `point` object in **FbSR** that is in the book:
    
    ```ocaml
    Let point = { x = Ref 4; y = Ref 3;
       magnitude = Fun this -> Fun dummy ->  !(this.x) + !(this.y);
       iszero = Fun this -> Fun dummy -> (this.magnitude this {}) = 0;
       setx = Fun this -> Fun newx -> this.x := newx;
       sety = Fun this -> Fun newy -> this.y := newy } In
          point.magnitude point {}
    ```
    
    a.  One disadvantage of this encoding is how we can't just say simply `point.magnitude {}` to send a `magnitude` message -- we need to explicitly pass the self every time, cluttering the syntax. Provide an alternative encoding of this `point` object which has all the functionality but for which `point.magnitude {}` (and similarly for the other methods) is going to give the right answer, `7` here.

    b.  Now extend your encoding to also hide the fields `x` and `y`: make them behave like `private` fields in Java. Make sure the internal access to the fields still works.  
    
    In both of your answers to this question you can change how internal field access and internal messaging works if you want, but do keep your encoding general so it should be clear how it will encode any standard object.

### Submission

As usual, upload your pdf to the Assignment 6 target in Gradescope.