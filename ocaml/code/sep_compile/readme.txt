The Makefile here should work with Eclipse OCaIDE on Linux/Mac/Cygwin.

Here are some detailed instructions to get this example working in Eclipse/OCaIDE:
1) Make a new "OCaml Empty Makefile Project"
2) Add all the files
3) under Properties/Makefile, 
   set make targets for rebuild to all, 
   set make targets for clean to clean, 
   under additional options you may need to put -f Makefile
4) Under the Eclipse preferences for OCaIDE, make sure the paths to all the
    executables are correct, including a path to the "make" command.
       

Its also very easy to hand compile:

ocamlc -c fSet.mli
ocamlc -c fSet.ml
ocamlc -c main.ml
ocamlc -o main fSet.cmo main.cmo

OR, to to all the above in one step,

ocamlc -o main fSet.mli fSet.ml main.ml 

Note that order is important, files on the left cannot depend on files on the right; like the top loop.

These commands produce an executable called main which can be run: on Linux/Mac it will run from a shell directly;
under any OS you can type

ocamlrun main

to run it.  

Of course if you are using Eclipse you can run main directly from within Eclipse.  Runnable Caml files
have a "B" on their icon in OCaIDE.


Note that the top loop can also load and run compiled files: enter

#cd " ... "; (* the directory where the .cmo files are; skip if ocaml launched from that directory *)
#load "fSet.cmo";;
#load "main.cmo";;

 -- the effect of the above is the same as if those module definitions were typed into the top loop.
 
Note that the "#" above need to be typed, they are not the caml prompt.  So, its the #load directive, not load.
