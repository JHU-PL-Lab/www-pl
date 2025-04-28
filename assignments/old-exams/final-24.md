<meta http-equiv="content-type" content="text/html; charset=utf-8" />

## Programming Languages Final Exam Spring 2024

Your Name (please **print neatly** to help Gradescope automatically recognize it): ______________________________________

Note that for any *single* numbered question 1. - 5. below, the magical word "SHAZAM!" as your answer will get you full points on that question.  The magic backfires if you attempt to use it twice however: two SHAZAM!s is no SHAZAM.

1.  (18 points) This question concerns operational equivalence. 
    
    a. Give two equivalent Fb expressions which can be proved equivalent using the laws of β-Equivalence, transitivity, and congruence.  Your two expressions *must* require the use of *all  three of these laws* to be proven equivalent, in other words if any three of those laws were removed from the list of allowable laws to use the proof of equivalence of the two expressions would be impossible. Please show all the steps of your proof to convince us the laws are needed.  (Your proof can optionally use other laws as well if you want.)

    b. Diverging and stuck computations are all operationally equivalent, but none of the equivalence laws in the book allow us to prove that.  For this question, consider the particular example of `0 1 ~= (Fun x -> x x)(Fun x -> x x)`: expand the definition of operational equivalence and argue informally why this equivalence holds based on the definition.
    
    c. Now write a new true law we could add to our list of laws for `~=` which would allow any diverging or stuck computation to be equated.  It should allow any of the cases of two diverging, two stuck, or one diverging one stuck expressions to be equated.

    d. The definition of operational equivalence for **Fb** is odd in how the two runs can produce different values.  Suppose the definition of operational equivalence was instead as follows:  `e1 ~= e2` iff for all contexts `C` such that `C[e1]` and `C[e2]` are both closed expressions, `C[e1] ==> v` if and only if `C[e2] ==> v` (note the same value `v` here unlike the definition in the book).  Show that this would be a bad definition: it would either equate too many or too few things.  In particular, give two expressions which either should be equivalent under the correct definition and are not here, or vice-versa.

    <p style="page-break-after:always;"></p>


2.  (18 points) This question concerns records and variants.  **FbV** variants such as `` `foo(4) `` are not *too* different from a singleton **FbR** record `{ foo = 4 }` as far as *construction* of data goes: both have a label and a value.  But, if we attempted to use singleton records in place of variants we would not get far due to the difficulty of *destructing* data.

    a. Argue informally why the **FbV** `Match .. With` syntax cannot be encoded in **FbR** if we replaced all variant definitions with singleton records as described above.

    b. Consider an extension to **FbR** we will call **FbRHas** which includes additional expression syntax `e Has l` which returns `True` if `e` computes to a record that has an `l` field, returns `False` if it computes to a record without an `l` field, and implicitly gets stuck if `e` computes to a non-record.  For this question write out any new operational semantics rules needed to extend the **FbR** operational semantics to **FbRHas**.

    c. In **FbRHas** we *can* fully and faithfully encode variants as singleton records.  Show this is the case by manually translating the following simple **FbV** program to **FbRHas**

    `` Let w = `hi(4) In Match w With `ho(x) -> x + 1 | `hi(y) -> y - 1 ``

    Your answer should not try to simplify this program (yes it's equivalent to the program `3`), but instead implement the `Match` philosophy of the above example using the new `Has` syntax.  Your answer should start out `Let w = { hi = 4 } In ...`.  (Note that this encoding is totally different from the variants-as-records encoding covered in lecture.)

    d. Finally, write out a general translation function `toFbRHas(e)` which will take any **FbV** program `e` and turn it into an equivalent **FbRHas** program using the above ideas to encode variants as singleton records and `Match` using `Has`.

    <p style="page-break-after:always;"></p>

3.  (20 points) Many languages support implicit coercions of data, for example adding an integer and a floating point number is possible because the integer can be implicitly promoted to a float before adding. There is a flavor of subtyping to this: it can be viewed as using the subtyping `int <: float` along with the subsumption rule to promote an integer to a float.  

    For this question we will consider the simpler case of allowing integers to be viewed as booleans: `0` can be viewed as a `False` boolean, and any non-`0` integer can be viewed as a `True` boolean.  Consider the language **FbMasq** which supports this implicit coercion, so for example `3 And True ==> True`, and `Not(0) ==> True` in **FbMasq** since `3` masquerades as `True` and `0` masquerades as `False`.

    a. Write out any new operational semantics rules beyond those in **Fb** already needed to support this implicit coercion of integers to booleans in **FbMasq**.  Make sure you will allow an integer to always stand in whenever a boolean is normally needed.

    Next let us consider a typed version of **FbMasq**,  **STFbMasq**, which uses subtyping to allow us to typecheck such programs.  For example, `|- 3 And True : Bool` should hold in **STFbMasq**.  The **STFbMasq** typing rules are defined as those of **STFbR**, removing the record rules, and adding one new subtyping rule, the axiom `|- Int <: Bool`.  (We will keep the subsumption rule and all of the non-record subtyping rules of **STFbR**).

    b. Recall that we can interpret subtyping as subsetting.  Use this philosophy to draw a Venn diagram of how the `Int` and `Bool` types-as-sets should relate in **STFbMasq**; include a few representative examples in your diagram such as `3` and `False`.

    c. Now use the **STFbMasq** type and subtype rules to type our little example: `|- 3 And True : Bool`.  

    d. Show that the system didn't overdo it: argue that there is no proof possible for `|- 3 + True : Int` by showing any attempt to construct such a tree will fail.

    e. Is `|- (Int -> Int) -> Int <: (Bool -> Int) -> Bool` provable using the **STFbMasq** subtyping rules?  Either give the proof tree or argue why not.

    <p style="page-break-after:always;"></p>

4.  (15 points) **FbX** has a simpler `Try .. With` syntax in comparison with OCaml's: in OCaml you can match on multiple possible exceptions, for example in OCaml you can write `try ... with | Foo(x) -> x + 1 | Bar(y) -> y - 1` to potentially catch either `Foo` or `Bar` in one `try`.  In **FbX** we only allow for one `With` clause, so only `Try ... With #Foo(x) -> x + 1` in this case could be written and we would not be able to handle the `Bar` exception in this `Try` if it occurred in the `...`.

    a. **FbX** has this design because it is in fact not difficult to code something of the spirit of the above OCaml `try with` example using only **FbX** syntax.  Concretely, write a **FbX** expression which fully and faithfully captures the OCaml example above, assuming the `...` code could raise either `#Foo(..)` or `#Bar(..)` exceptions.

    b. Now, generalize this: show that there is a macro abbreviation for a more general `Try .. With` that can be defined in **FbX**.  Your macro should look like
    `Try e1 With | #xn1(x1) -> e1 | ... | #xnn(xn) -> en =def= ...` where the `...` is filled with **FbX** code that implements this n-ary exception catch.  You can use mathematical notation in writing out the macro, so "..." is fine.

    c. One other approach is to build in a multiple-clause `Try-With` into **FbX** itself.  Consider **FbXMultTry**, a modification of **FbX** to support multiple clauses as outlined above.  The syntax of **FbXMultTry** `Try With`  is that of the macro left hand side given in the previous question.  For this question, write the new operational semantics rule(s) for this new form of `Try`.

    <p style="page-break-after:always;"></p>

5.  (15 points) This question concerns actors.  One issue we did not address for actors is what happens with "garbage" actors, actors which are idle and are obviously never, ever going to receive any more messages.  In long-running systems that generate many actors these must be freed or we will run out of memory, similar to how a heap in any modern programming language can fill up if we don't either collect garbage or manually free memory to be re-used.

    a. One solution to this for actors is to take the C/C++ approach and extend **AFbV** to support a `Free(e)` syntax which for `e` evaluating to some actor name `a` will manually remove actor `a` from the global actor soup `G`.  For this question you are to modify the operational semantics of **AFbV** to support `Free`.  Here are a few hints which you are free to use.  First, modify the local actor stepping relation `e =S=> v` so that the set `S` of messages and newly created actors also can include elements `Free(a)` meaning actor `a` is to be freed.  Then modify the global stepping relation `G -> G'` to also remove any actor which has been demanded to be freed, as well as any messages to that actor as they are now also garbage since the actor has been terminated.

    b. The manual free approach above is chaotic as actors which have messages waiting for them, or which could get messages sent to them in the future, can be freed and this will then orphan those messages.  For this question, instead of adding `Free` syntax, let us just modify the global stepping relation so that it has an additional form of step it can take, a garbage collection step `G -> G'`.  If there is any actor whose name is not appearing anywhere other than in itself (i.e. its name occurs in the code of no other actor and in no queued message of `G`), such an actor can be removed from `G`, as well as any other actors now garbage based on that actor being removed.  For this question you are to write out this new garbage collection rule.


<p style="page-break-after:always;"></p>

(Blank page, if you run out of room on any question say "see blank one" and write here)

<p style="page-break-after:always;"></p>

(Blank page, if you run out of room on any question say "see blank two" and write here)

<p style="page-break-after:always;"></p>

(Blank page, if you run out of room on any question say "see blank three" and write here)
