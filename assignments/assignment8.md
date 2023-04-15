## Assignment 8: More Types


#### Part A

Here are some written questions on typing.

1. For each of these expressions, either construct a typing proof in **TFb**, **or** show exactly why they cannot typecheck (i.e. no derivation tree could ever be built; don't just informally describe it, use the formal system rules).

    a.  `If True Then 0 Else False`

    b.  `(If True Then (Fun x:Int -> x + 1) Else (Fun x:Int -> x)) 0`

    c.  `Not((Fun x:(Bool -> Int) -> x False))`

1.  Consider type inference for **TFbR**. If we only infer equations on types like we did for **EFb**, it is in fact quite difficult to infer reasonable types without any type declarations present (and, it is why OCaml requires record types to be declared). Take for example a program like `(Fun r -> r.x + r.y) {x = 4; y = 7}` and argue why it would be difficult to infer local equations and check for inconsistency like we did for **EFb**. Concretely, propose some reasonable equations that could be added but then show why they would not work.
2.  Of the following pairs of types, is the left type a subtype of the right type, a supertype, or neither? Justify your answer by showing the proofs in the subtype proof system of the book; if neither holds describe why in words.  Pay close attention to the rules, it is easy for intuitions to fail on these examples.  Just build a proof tree based on the rules and you know you are correct.
    1.  `{ x : Int; y : { z : Bool } }` and `{ x : Int; y : {}; w : Int }`,
    2.  `{ x : Int } -> { }` and `{ } -> { x : Int }`
    3.  `({ x : Int } -> { }) -> { }` and `({ } -> { x : Int }) -> { }`
3.  Type the following program in **STFbR** (note this program is not showing the type declarations on `r1/r2`, you need to find types to fill in there such that the program is typeable):
        
              Function n:Int -> Function r1:{...} -> Function r2:{...}->
                 {x = r1.x + 1; y = (If n = 0 Then r1.y - 1 Else r2.y +1); z =  r2.z + 2} 
        


#### Part B

Write a type checker for **TFbSRX**. The language was described in lecture and is in section 6.4 of the book. The `TFbSRX/` directory of the FbDK contains the relevant parser and OCaml data type, all you have to do is fill in the file tfbsrxtype.ml with a correct implemention of the typecheck function there. Note that you _don't_ have to write an interpreter, only the typechecker.

*   The file [tfbsrx_examples.ml](http://pl.cs.jhu.edu/pl/ocaml/tfbsrx_examples.ml) contains quite a few examples for you to test the typechecker with.
*   The AST for the language, in file [TFbSRX/tfbsrxast.ml](https://pl.cs.jhu.edu/pl/book/dist/fbdk/TFbSRX/tfbsrxast.ml), is slightly different from the one at the top of Section 6.4 in the textbook, it is a bit simpler.
*   As with the other languages in the FbDK you can use our reference implementations.  The above file `tfbsrx_examples.ml` contains information on how you can invoke the typechecker in testing.
*   Notice that `Raise ..` evaluates to "arbitrary tau" in the rule in the book. As we mentioned in lecture, this is usually handled by introducing an "anything type \*" - a type that is equal to every other type in the system. A new type `TBottom` has been added to the type fbtype for this purpose.
*   Type checking exceptions can be somewhat tricky; especially their interactions with _other_ expressions and type rules. You need to consider each rule carefully.  
      
    For example:  
    ```
    |- (Function x:Int -> x = 1) (Raise #Exn@Bool False) : Bool     
       Because by function rule     |- (Function x:Int -> x = 1) : Int -> Bool     
       and by exception rule     |- (Raise #Exn@Bool False) : Bottom (arbitrary tau)   
       And because Int and Bottom can be equated, 
       by application rule we have   |- (Function x:Int -> x = 1) (Raise #Exn@Bool False) : Bool   `
    ```    


### Submission

For Part A, the upload is as for the other written assignments.  For Part B, upload (only) your file `tfbsrxtype.ml` which will (hopefully) contain your fully functioning type checker.