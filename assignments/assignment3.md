This is a short homework giving you some practice with operational semantics before starting on writing your Fb interpreter. Please consult [Chapter 2 of the book](http://pl.cs.jhu.edu/pl/book/book.pdf) for the full details on various definitions, and for more examples beyond those in lecture, if you have any questions.

1.  [5 points] Compute the following substitutions. Note that the substitution function is defined formally in Section 2.3.2 of the book.

    a.  `(Fun y -> x + 1) [3/x]`

    b.  `(Fun x -> Fun y -> x And y) [True/z]`

    c.  `(Fun x -> Fun z -> x And y) [True/y]`

    d.  `(Fun z -> Fun y -> x And z) [True/z]`

    e.  `((Fun x -> x) (Fun y -> x)) [2/x]`

    f.  `(Let y = x + 1 In y + 2) [5/y]`

    g.  `(Let f = Fun z -> z + 1 In f z) [5/z]`

2. [9 points] The following Fb proof trees contain errors.  Describe why the proof tree is not valid (i.e. why the last line is in fact not a theorem).

    <img src="a3q2.png" width=500>

3.  [15 points] Write operational semantics proofs (i.e., proof trees) showing what the following expressions evaluate to in the Fb operational semantics. Please give the whole proof trees, using the rules in Chapter 2.  You may reference one proof tree in another like a "proof tree macro" to make your answer more readable if you want (in other words, you can re-use any one proof tree in another, just like how proofs of Lemmas can be used in Theorems in math).  Note it is not a bad idea to start by running them in the reference interpreter to make sure you are on the right path.

    a.  `Let f = (Fun y -> y + 1) In Fun z -> (f z) + 1`

    b.  `(Let f = (Fun y -> y + 1) In Fun z -> (f z) + 1) 4`

    c.  `(Fun x -> (If x = 2 Then Fun x -> x Else 1)) 2 4`

4.  [10 points] Fb currently lacks multiplication and division.  For this question we are going to define a new language **FbMD** which adds infix multiplication `*` and division `/` to Fb.

    a. Define the BNF for FbMD.  Note you can write "... Fb's ..." to indicate a copy/paste of the Fb clauses.

    b. Write new proof rules, in the spirit of the existing `+` and `-` rules.  Make sure to make a clear definition for division by zero.


### Submission and Grading

Upload your homework as a pdf to Gradescope. Feel free to write by hand and scan it in, just verify your scan is fully legible before submitting!