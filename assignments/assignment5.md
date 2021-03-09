## Assignment 5: Operational Equivalance, Records, Variants

1.  (10 points)  For each of the **FbR** programs prove it has a value (by building the operational semantics proof tree) **or** argue that the program has no value.  (Note that **FbR** includes records with 0,1,2,3,.. fields but we will here stick to the 2-field records covered in lecture)

     a. `Let r = { w = 5; h = True} In If r.h Then 0 else 1`

     b. `Let r = { w = 5; h = True} In Let r = { w = 7; p = True} In r.h`

2.  (30 points) Let us consider **FbPp**, **Fb** extended to have pairs.  This is similar to the **FbR** language as covered in lecture, pairs are like the 2-ary records but there are no field names so they are a bit simpler.  The book contains a language **FbP** in Section 3.1; here we are studying a minor variation **FbPp** which has *pattern matching* to destruct the data instead of the `Left`/`Right` projections in the book.  Here is the syntax of **FbPp**:

     _e_ ::= ( .. Fb grammar .. ) `|` `Let` `(`x`,`x`) = `*e* `In `*e* `|` `(`*e*`,`*e*`)`

     _v_ ::= ( .. Fb grammar .. ) `|` `(`*v*`,`*v*`)`

    The `Let` on pairs syntax here follows OCaml's, it takes apart a pair into its components.  For example `Let (a,b) = (1,2) In a + 3` will evaluate to `4`.

    a.  Write the operational semantics rules for **FbPp**. These rules must directly define the meaning, don't encode pairs in terms of records or functions.  You can just write "..Fb's rules.." to insert all of Fb's rules in your rules.

    b.  Write out the full proof derivation showing `(Fun p -> Let (x,y) = p in x)(2,3)` ⇒ `2`

    c.  It turns out **FbP** and **FbPp** are of equivalent expressive power: (1) write **FbPp** macros for **FbP**'s `Left` and `Right` pair projections, and (2) write an **FbP** macro for the **FbPp** pattern matching syntax.

3.  (10 points) Write an **Fb** function `cheapY` which works like the `Y`-combinator but only supports ten levels deep of recursive call. So for example

    `cheapY (Function this -> Function x -> If x = 1 then 1 Else x + this (x-1)) 10`

    returns `55` but if the `10` was replaced with `11` it diverges since the recursion tried to go 11 levels deep. This behavior is the same as a recursive function invocation with a runtime stack depth of at most 10 in e.g. the C language. Hint: you don't actually need a counter to count the number of recursive calls, it is easier than that.


4. (20 points) For each of the following potential operational equivalences for Fb, either state that it holds, or present a counterexample context C invalidating it.  Make sure to carefully review the definition of `~=` as presented in lecture and the book before starting.

     1. `x - y` =~ `y - x` (`x` and `y` are Fb variables here)
     2.  `x + y` =~ `y + x` (`x` and `y` are Fb variables here)
     3.  *e1* ` + ` *e2* =~ *e2* ` + ` *e1* (*e1* and *e2* are arbitrary expressions; it holds for *any* *e1* and *e2*)
     4.  *e* ` + 0` =~ *e* (where *e* is any arbitrary expression)
     5. `Let x = f 0 In 0` ~= `0`
     6. `(0 0)` ~= `(1 1)`

  Note that when you fill in the hole in a context *C*[*e*], you can assume you are not going to change the parse precedence; in other words, you can just as well think of it as *C*[`(`*e*`)`]
  