## Assigment 7: Actors

This homework focuses on the actor model and actor programming in **AFbV**.  The AFbV examples run in class may be found in the [`afbv_examples.ml`](https://pl.cs.jhu.edu/pl/ocaml/afbv_examples.ml) file.

That file also contains instructions on how to run the reference interpreter and to set up `utop` for easy testing of your actor code.  As a warm-up, turn on some of the debugging flags in comments at the top and `peu` some of the examples in that file. (Note that the state dump debug mode was recently cleaned up so if you want to use that please grab a fresh copy of the zip file to get the latest reference implementation (only the file `./reference/AFbV/toplevel.exe` is changed).)

Note that **AFbV** has lists and pairs which can be used for your implementation.  There is no pattern-matching on lists however, you must use `Head(..)` and `Tail(..)` to access the head and tail, and `..= []` to test for an empty list.  You can write lists as `[1;2;3]` and cons with `::` just like in OCaml. Pairs are simply `(a, b)` as in OCaml. However, you need to use `Fst` and `Snd` to extract the first and second components of a pair, respectively. Lastly, **AFbV** is equipped with polymorphic equality, so you can even compare the equality of actors if necessary.

For all the questions, include the answers in a file `assignment7.ml` as let-defined strings which `peu` will run (or, as OCaml comments for the written questions).

For this assignment you are going to write a simple producer - consumer in AFbV. To start with we will just spec the producer.  The producer will start with an initial stock of items, and will be able to produce more products if demand exceeds the supply. 

   a. For your implementation, the producer should meet the following requirements:
   * `` `Create(producer_behavior, n)`` should return a producer actor with an initial stock of `n` products. Furthermore, it should respond to these messages:
   * `` `produce(_)`` - add a product to its internal stock.
   * `` `consume(a)`` - if the stock is not empty, send ``a <- `delivered(0)`` and remove one item from the internal stock; if empty, send `` a <- `wait(0) `` and `` `me <- `produce(0)``.  This is a somewhat artificial model of production, the producer can make more stock by simply sending `produce` messages to itself.  The consumer will also need to re-request to get an item delivered.


   ```ocaml
    let producer_behavior = "(0 0)";;
   ```

   Here is a simple tester for the producer.  The producer will start with one item, and a consumer will get an item the first time and the second time will get a `wait` and will need to re-request.
   ```ocaml
    let producer_tester = "
    Let producer_behavior = ("^producer_behavior^") In
    Let producer = Create(producer_behavior, 1) In
    Let consumer_behavior = Fun me -> Fun _ -> 
      (Fun _ ->  
        producer <- `consume(me);
        (Fun msg -> 
            Match msg With 
            `delivered(_) -> 
                producer <- `consume(me);
                    (Fun msg -> 
                        Match msg With 
                        `wait(_) -> producer <- `consume(me);
                            (Fun msg -> 
                                Match msg With 
                                `delivered(_) -> Print \"It worked!\"))))
    In
    Let consumer = Create(consumer_behavior, 0) In
    consumer <- 0
    ";;
   ```

   This is in fact not a very good test, the producer is both getting its own `` `produce `` message as well as the `` `consume `` message and since arrival order is nondeterministic by default the test will only work half the time.  Our suggestion in debugging is to use the `deterministic_delivery := true;;` option so the former earlier message will beat the latter.  

   b. It is not too hard to fix this test even for nondeterministic execution: eventually the producer will get the `` `produce `` message since actors are fair, and so after some number of `` `wait `` messages the `` `consume `` will succeed.  Modify the above code so it even works in nondeterministic mode.  Note that solving question c. below could help you figure out how to solve this question.


 ```ocaml
    let fixed_producer_tester = "(0 0)";;
   ```

   c. We can use the theory to help us understand why the consumer tester here needs to repeat its requests.  For this question, give a sequence of global actor states G0 -> G1 -> G2 -> ... of a computation of the the producer and your fixed tester which shows how an arbitrary number of `` `wait `` messages could be sent back to the consumer before its `` `consume `` message is finally processed.  Put some "..." in your sequence for the part that could repeat.

   ```ocaml
  (* a7c. ... YOUR ANSWER HERE ... *)
   ```
   Note that you can give your answer in the format `show_states := true` produces.  Please don't include any of the actor code in your answers, "..." will do in place of any code.



   d. Now lets make a protocol for the consumer as well. The consumer should meet the following requirements:
   * `` `Create(consumer_behavior, (producer, n))`` should return a consumer actor with a demand for `n` products from the `producer` actor. You can assume consumer actor will always start with demand greater than `0`. Furthermore, it should respond to these messages:
   * `` `purchase(_) `` - send `` `consume(me) `` to the producer.
   * `` `wait(_) `` - send another `` `consume(me) `` request to the producer.
   * `` `delivered(_) `` - check whether the demand is met; if so, finish the execution. If not, send `` me <- `purchase(_) ``, and update the demand. 


   ```ocaml
    let consumer_behavior = "(0 0)";;
   ```

   Here is a sample runner which will simulate the transactions between a producer with initial stock of zero products, and two consumers with demand of one and two products respectively. Since the demands exceed the supply in this example, the two consumers will have to wait at least one and two times each before getting their products delivered. You can insert `Print` in your handling code for `wait` in the consumer actor to check for this behavior.
   ```ocaml
    let pc_tester = "
    Let producer_behavior = ("^producer_behavior^") In
    Let consumer_behavior = ("^consumer_behavior^") In
    Let producer = Create(producer_behavior, 0) In
    Let user = Create(consumer_behavior, (producer, 1)) In
    Let user2 = Create(consumer_behavior, (producer, 2)) In
    user <- `purchase(00);
    user2 <- `purchase(00) 
    ";;
   ```
### Submission

Upload your `assignment7.ml` file to Gradescope.  The OCaml code in your file should only define the indicated strings, it should not run anything (no `peu` etc in it.)