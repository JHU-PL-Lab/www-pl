## PL Midterm 2024

You are to work without the consultation of any individuals other than Prof/CAs on this exam.  This includes posting questions on the Internet, etc. Please include at the top of your exam 

> I pledge I worked without consultation with any individuals other than Prof/CAs on this exam

certifying this.  You are free to use any non-human resources, e.g. the course text, lectures, Wikipedia, etc.

You are free to ask questions on Courselore or in office hours, but please address all Courselore questions to Staff.  If it is a good issue to clarify we will make your question public.

1. (10 points) The definition of substitution in the book, Definition 2.10, left out some clauses (e.g. for `If`, `Let Rec`, etc.)  For this question write the complete definition of substitution.  You can literally copy/paste the clauses already in the book, just add clauses for all the missing syntax, including `Let Rec` even if you didn't do the extra credit on Assignment 4.

2.  (15 points) The book listed some laws for operational equivalence ~= for **Fb**.  Let us consider some other possible laws.  Consider each of the following statements and categorize it as 1) true but not provable with the existing laws (so it would be good as a new law), 2) true *and* provable with the existing laws (give the proof in such a case, including all the laws used in the proof), or 3) false (prove that it is false in such a case using the definition of ~=).  Recall that in all laws, e, v, and x denote arbitrary expressions, value expressions, and variables, respectively.

    a. `Not(Not(x))` ~= `x`

    b. `(Fun x -> x) e` ~= `e`

    c. `e + x` ~= `x + e`

    d. `x e` ~= `x e'` if `e` ~= `e'`

    e. `Let x = e1 in e2` ~= `e2[e1/x]`

3. (10 points) Consider the **FbV** expression `e` defined as ``Let h = `Hi(2) In Match h With `Ho(x) -> x + 1``.  Using the operational semantics rules for **FbV** in the book (and covered in lecture), show that `e ==> v` fails for *any* `v`.  (Hint: you want to show that any attempt to build a proof tree is doomed to failure.)

4. (15 points) For this question, you are to extend the **Fb** interpreter function with clauses for **FbV** to make an **FbV** interpreter that realizes the operational semantics.  
     
   Note that the **AFbV** interpreter in the FbDK is largely a superset  of **FbV** so you can use it if you want to see how to parse or execute **FbV** programs. Just replace "fb" or "Fb" in any instructions with "afbv" or "AFbV", e.g. `./reference/AFbV/toplevel.exe` will start a `utop` with the reference interpreter loaded.  Then typing  e.g. ``open Debugutils;; peu "Match `Hi(2) With `Hi(x) -> x + 1";;`` will run the reference interpreter.

   The **FbV** interpreter is an extension of the **Fb** interpreter, and *all* you need to do for this question is to write is the new clauses needed in both the substitution function and in the main evaluator function.  Just put "..." for the other clauses as they are the same as the **Fb** ones.  In particular as can be seen from the AST above, `Variant` and `Match` are the two new match cases you need to address.  Note that the OCaml `name` type is a string representing variant names such as `` `Hi `` etc. 

   Here is an OCaml datatype for **FbV**. 

  ```ocaml
    type ident = Ident of string
    type name = Name of string
    type expr = 
    | Var of ident | Int of int | Bool of bool 
    | Plus of expr * expr | Minus of expr * expr | Equal of expr * expr
    | And of expr * expr | Or of expr * expr | Not of expr | If of expr * expr * expr
    | Function of ident * expr | Appl of expr * expr | Let of ident * expr * expr
    | Variant of name * expr 
    | Match of expr * (name * ident * expr) list
  ```

5. (25 points) In **FbR**, when evaluating a record, all the fields will be evaluated e.g. `{a = 1 + 1; b = 2 + 3} => {a = 2; b = 5}`. Now consider **FbRn** in which a record evaluates to itself like functions do: `{a = 1 + 1; b = 2 + 3} => {a = 1 + 1; b = 2 + 3}`. The field associated with label `lab` is only evaluated when the `lab` is selected: `{a = 1 + 1; b = 2 + 3}.a => 2`.  The records in **FbR** are called *eager* since the fields are eagerly evaluated; the **FbRn** form is *lazy*.

    a. Define the expression and value grammars for **FbRn**.

    b. Write the revised operational semantics rules for record and selection. All the other rules are the same as **Fb**'s and need not be given.

    c. One advantage of lazy records is it is possible to write infinite sequences without `fun () -> ..` to freeze values as we used in assignment 2: informally `Let s = {hd = 1; tl = s} In ((s.tl).tl).hd` expresses an `s` that is an infinite sequence of 1's (view the `hd` field as the head of the sequence and `tl` as the tail). The body `((s.tl).tl).hd` then shows how we can get the third `1` element from `s`.  The above definition is not going to work however, because it is cyclic (the `s` occurring in "`tl = s`" is a free variable so the program is ill-formed as written).  For this question, give a **FbRn** expression which fixes the above informal example to use recursion to represent an infinite list `s`.  However you define `s` make sure  `((s.tl).tl).hd` will return `1`, and in general any number of `tl` followed by `hd` will return `1`.

    d. In lecture and at the end of Section 3.3.2 in the textbook it covers how variants and records are duals of each other: one can encode the other. Discuss whether it's still possible to encode **FbRn**-style lazy records in **FbV**, or not. In particular give an encoding of an **FbRn** record `{l_1 = e_1; ... ; l_n = e_n}` and selection `e.l_i` into **FbV** which behaves as described above, or argue why it will not be possible.

