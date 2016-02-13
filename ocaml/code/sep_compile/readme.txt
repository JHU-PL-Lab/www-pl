A super simple example of separate compilation coding methodology for OCaml.

The Makefile here should generally work on Linux/Mac/Cygwin.
You may need to explicitly list the full path to ocamlc if it is not finding it.

Just type make from the shell to build.

----------------------------------------------------------------------

Hand compilation with ocamlc

Its also very easy to hand compile:

ocamlc -c fSet.mli         # from fSet.mli make compiled interface file fSet.cmi
ocamlc -c fSet.ml          # from fSetml make compiled object file fSet.cmo; needs fSet.cmi
ocamlc -c main.ml          # as above but make main.cmo; note it needs previous two cm* files to compile
ocamlc -o main fSet.cmo main.cmo  # build the "binary" (its actually bytecode)

OR, to do all the above in one step,

ocamlc -o main fSet.mli fSet.ml main.ml 

Note that order is important, files on the left cannot depend on files on the
right; its just like the OCaml top loop in that regard.  For example,

$ ocamlc -o main fSet.mli main.ml fSet.ml 
File "fSet.ml", line 1:
Error: Error while linking main.cmo:
Reference to undefined global `FSet'

These commands produce an executable called main which can be run: on Linux/Mac 
it will run from a shell directly; under any OS you can type

ocamlrun main

to run it.  From Mac/Linux, the usual ./main will work.

Of course if you are using Eclipse you can run main directly from within Eclipse.
Runnable Caml files have a "B" on their icon in OCaIDE.

----------------------------------------------------------------------

Using ocamlbuild or corebuild

OCaml has its own build tool that comes with the standard binaries.  Type

ocamlbuild main.byte

and it will build an executable file main.byte which you can then run.
Note that it automatically looked into main.ml and calculated its dependencies and built all of them.
A _build/ directory contains all the built files.

There is also a frontend to ocamlbuild which makes it easier to use called corebuild.
You need opam to install it.  Type

opam install core

to install corebuild and then type

corebuild main.byte

to build the executable.
----------------------------------------------------------------------

Using Eclipse OCaIDE to build this small project


1) Make a new "OCaml Empty Makefile Project"
2) Add all the files; it may just work now but if not continue to 3) and 4) below.
3) under Properties/Makefile, 
   set make targets for rebuild to all, 
   set make targets for clean to clean, 
   under additional options you may need to put -f Makefile
4) Under the Eclipse preferences for OCaIDE, make sure the paths to all the
    executables are correct, including a path to the "make" command.
       

----------------------------------------------------------------------

Loading compiled modules into the interactive top-loop

The top loop can also load and run compiled files: from ocaml enter

#cd " ... "; (* the directory where the .cmo files are; skip if ocaml launched from that directory *)
#load "fSet.cmo";;
#load "main.cmo";;

 -- the effect of the above is the same as if those module definitions were
  typed into the top loop.
 
Note that the "#" above need to be typed, they are not the OCaml prompt.  
So, its the #load directive, not load     .

----------------------------------------------------------------------

The optimized compiler to native code

Use ocamlopt in place of ocamlc to generate native binary code.

opcamlopt makes cmo, cmi, cmx, and o files.


