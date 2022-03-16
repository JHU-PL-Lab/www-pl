## PL Midterm 2022

You are to work without the consultation of any individuals other than Prof/TA/CAs on this exam.  This includes posting questions on the Internet (other than Courselore), etc. Please include at the top of your exam 

> I pledge I worked without consultation with any individuals other than course staff on this exam

certifying this.  You are free to use any non-human resources, e.g. the course text, lectures, Wikipedia, etc.

You are free to ask questions on Courselore or in office hours, but please ask all Courselore questions to Staff only.  If it is a good issue to clarify we will make your question public.

The exam is due Friday 11:59PM.  You can use up to one late day on this exam so with a late day it would be due Saturday 11:59PM.

1. (10 points) Using the **Fb** operational semantics show `(Fun z -> Let x = 3 + 4 In x - z) 4 ==> 3`

2. (10 points) Show that `Fun z -> Let x = 3 + 4 In x - z ~= Fun q -> 7 - q` using only the laws 2.17-2.27 in the book.

3. (30 points) For this question we will study **FbValt**, an alternative syntax for **FbV**.  Here is the grammar.

   ```
     v ::= ... Fb grammar ... | n(v)
     e ::= ... Fb grammar ... | e @ n | e has n | n(e)
     n ::= a named variant tag, notated `a `b etc (i.e., the same as FbV)
   ```

   The new operator `@` extracts the underlying `n`-wrapped data, so e.g. ``(`hello(5) @ `hello) ==> 5``.  Note that if the tag does not map the argument `n` here the computation gets stuck, i.e. it has no value and so e.g. ``(`hello(5) @ `byebye) ==> v`` fails for any `v`.  In order to write general programs we also need to include the `e has n` operator, which returns `True` if `e` is a variant `n(v)` for some `v`, and returns `False` if it is some other variant.  The operator is undefined if `e` is not a variant value.  So, for example the function 

   ```ocaml
   Let f = Fun x -> If x has `Some Then (x @ `Some) - 1 Else If x has `None then 0
   ```

   would have the behavior of `f(Some(4)) ==> 3` and `f(None(33)) ==> 0`

   a. Write the operational semantics rules for **FbValt**.  You may use shorthand to borrow all or some of the **Fb** rules.

   b. We could alternatively have defined the above notation as *macros* for **FbV**.  Concretely, propose **FbV** macros `e @ n =def= ...` and `e has n =def= ...` (fill in the ..)  which would use the **FbV** syntax to implement these operations.

   c. It is in fact also possible to do the opposite as well: show how the general `Match` syntax of **FbV** can be expressed as a macro in **FbValt**.  Give the general case, not just an example.

4. (20 points) We can also define operational equivalence `~=` on **FbV**.  The definition is identical to Definition 2.16, except use **FbV** expressions `e` and **FbV** contexts `C` in place of **Fb** expressions/contexts.

    a. Prove that `` `Yes(0) ~= `Yes(1)`` fails in **FbV** by using the definition of `~=` for **FbV** outlined above.

    b. All of the laws in the book for **Fb** (2.17-2.27) in fact hold for **FbV** as well, and in addition some new laws are needed if we want to prove useful equivalences from the laws.  Propose one useful general law of the form `e ~= e'` which will let us prove the **FbV** equivalence 
    ``(Fun x -> Match `Yes(x) With `Yes(x) -> 1 | `No(y) -> 0) ~= Fun x -> 1``.  Note you do not need to verify your law holds, but do make sure that it makes sense and is a general principle useful for much more than this one particular program equivalence.  

    c. Now, use your new law plus the 2.17-2.27 analogues for **FbV** to in fact prove this above example.

   

5. (10 points) Prove the symmetry of the operational equivalence relation `~=` (see Definition 2.18). Prove this by using Definition 2.16 to expand what `~=` means.

6. (15 points) Recall our definition of the Y combinator `ycomb` from `fb_examples.ml`:

    ```ocaml
    (Fun code -> 
           Let repl = Fun self -> Fun x -> code (self self) x 
           In repl repl)
    ```

    It looks like we are doing something like an η rule expansion (Def 2.22) on the body here:  we have `Fun x -> code (self self) x` which takes in `x` as an argument and just forwards it to the function `(code (self self))` (extra parens added only for clarity here) which seems like a no-op.  If the η rule could apply we could collapse this forwarding and end up with an alternate Y combinator like this (let us call it `y_alt`):

    ```ocaml
    (Fun code -> 
           Let repl = Fun self -> code (self self)
           In repl repl)
    ```

    a. The η rule in fact *cannot* be used to equate the two expressions `ycomb ~= y_alt` above; why does it not apply?
    
    b. This is a good thing in fact: `y_alt` cannot be used to write recursive functions like `ycomb` can (feel try try it out in the **Fb** interpreter, e.g. `peu y_alt^code^" 5";;` for `code` defined in `fb_examples.ml`).  For this question you need to use the operational semantics of **Fb** to justify why this is not working. You don't need to write a whole proof tree but argue why there is no operational semantics proof that `y_alt^code^" 5" ==> 15`.
