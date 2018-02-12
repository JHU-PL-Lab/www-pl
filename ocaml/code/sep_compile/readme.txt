A simple example of separate compilation coding methodology for OCaml.

----------------------------------------------------------------------
In practice you should use ocamlbuild or a Makefile to compile.

But, lets first do it "by hand" to understand the process.

ocamlc is the actual compiler, it works similarly to cc etc.

ocamlc -c fSet.mli         # from fSet.mli make compiled interface file fSet.cmi
ocamlc -c fSet.ml          # from fSet.ml make compiled object file fSet.cmo; needs fSet.cmi
ocamlc -c main.ml          # as above but make main.cmo; note it needs previous two cm* files to compile
ocamlc -o main fSet.cmo main.cmo  # build the "binary" (its actually bytecode)

OR, to do all the above in one step,

ocamlc -o main fSet.mli fSet.ml main.ml

Note that order is important, files on the left cannot depend
on files on the right; its just like the OCaml top loop in
that regard (and is NOT like cc etc).  For example,

$ ocamlc -o main fSet.mli main.ml fSet.ml
File "fSet.ml", line 1:
Error: Error while linking main.cmo:
Reference to undefined global `FSet'

These commands produce an executable called main which can be run:
on Linux/Mac it will run from a shell directly via e.g.

./main

and under any OS you can type

ocamlrun main

----------------------------------------------------------------------

Using ocamlbuild to automatically build simple projects

OCaml has its own build tool that comes with the standard binaries.  Type

ocamlbuild main.byte

and it will build an executable file main.byte which you can then run.
Note that it automatically looked into main.ml and calculated its dependencies and built all of them.

A _build/ directory contains all the built files.
----------------------------------------------------------------------
Building with a Makefile

As with C code a Makefile can be constructed for ocamlc.
We include such a file here as an example (we will not cover it).


----------------------------------------------------------------------

Loading compiled modules into the interactive top-loop

The top loop can also load and run compiled files: from ocaml enter

#cd " ... "; (* the directory where the .cmo files are; skip if ocaml launched from that directory *)
#load "fSet.cmo";;
#load "main.cmo";;

 -- the effect of the above is the same as if those module definitions were
  typed into the top loop.

Note that the "#" above need to be typed, they are not the OCaml prompt.
So, its the #load directive, not load.

----------------------------------------------------------------------

The optimized compiler to native code: ocamlopt

Use ocamlopt in place of ocamlc to generate native binary code.

opcamlopt makes cmo, cmi, cmx, and o files.
