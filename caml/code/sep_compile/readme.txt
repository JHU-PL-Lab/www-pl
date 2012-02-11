The Makefile here should work with Eclipse OCaIDE on Linux/Mac/Cygwin if you add these files 
to an OCaml Empty Makefile Project.

On the other hand its very easy to hand compile:

ocamlc -c fSet.mli
ocamlc -c fSet.ml
ocamlc -c main.ml
ocamlc -o main fSet.cmo main.cmo

OR, to to all the above in one step,

ocamlc -o main fSet.mli fSet.ml main.ml 

Note that order is important, files on the left cannot depend on files on the right; like the top loop.

