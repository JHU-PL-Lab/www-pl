FbDK
====

This is a distribution of the Fb ("F-flat") development kit (FbDK).  The FbDK is
a tool for learning programming language theory through the development of
interpreters and type systems.  It contains all of the implementation of
interpreters and typecheckers for several different programming languages,
but lacks the "meaty part", the actual evaluation function and/or the actual type checking function -- those are left as exercises.

The example commands listed here are intended to be run from the root of the folder you extracted your fbdk distribution zip file into.

Please see the `COPYING` file in this directory for licensing information.

Prerequisites
-------------

The FbDK has the following requirements:

* A working OCaml compiler
* An installation of `dune`
* An installation of `menhir`, `ocamllex`, and `ppx_deriving`

Installing each from `opam` should work.


Building Interpreters
---------------------

To compile the interpreters, it is sufficient to run

    # dune build

from the top-level directory.  To force a rebuild, 
running `dune clean` first will remove all artifacts
so that dune does everything from scratch again.

An individual interpreter may be compiled by naming it directly, e.g.

    $ dune build ./Fb/interpreter.exe

The above command compiles the interpreter based on the `Fb`
implementation of the basic Fbdk interface.

Equally, an interpreter can be directly executed from dune:
    
    $ dune exec ./Fb/interpreter.exe


Running your FbDK Interpreter from the OCaml Toploop
----------------------------------------------------

As you develop your interpreters, you may wish to interact with your `eval`
function directly from the OCaml toploop. This is simple with `dune`.
For example to interactively debug or test your `Fb` interpreter, run:

    $ dune utop ./Fb

The compiled OCaml objects will be loaded into a toploop
session as modules and you will be able to use the types and functions defined in your source code.  

Here is an example:
```ocaml
$ dune utop ./Fb
...
utop # open Debugutils;;
utop # let ast = parse "2+3";;
val ast : Fbdk.Ast.expr = (Plus ((Int 2), (Int 3)))
utop # let result = eval ast;;
val result : Fbdk.Ast.expr = ((Int 5))
```
See the file `build_scripts/debugutils.ml` for the functions available in the `Debugutils` module.

Precompiled Interpreters
------------------------

To provide a basis of comparison, compiled versions of the completed
interpreters are provided in the `reference/` directory.  You may run those
binaries like so:

    $ ./reference/Fb/interpreter.exe

This will open the provided Fb interpreter.  The user may now enter code into the toploop, which will evaluate it:

```
$ ./reference/Fb/interpreter.exe
	Fb version 1.4.0		(typechecker disabled)

# 3 + 5;;
==> 8
# (Function x -> x + 1) 5;;
==> 6
# True Or False;;
==> True
#
```

Pressing Ctrl+C or Ctrl+D will exit the toploop.

The interpreters may also be used to run files directly rather than through a
toploop.  The interpreter may take a filename as an argument:

```
$ ./reference/Fb/interpreter.exe one_plus_three.fb
4
```

Any of the interpreters can provide more command-line usage information when passed the argument `--help`.

### Running the precompiled interpreters in the OCaml top loop

The precompiled binary interpreters may also be used in the OCaml top loop in the same spirit as "Running your FbDK Interpreter from the OCaml Toploop" above. This is a good way to test how they behave programmatically, if you prefer, and match
your own implementation to ours. You need only run the provided `toplevel.exe` for the desired interpreter, for example:

    $ ./reference/Fb/toplevel.exe
    
This will enter you into an environment identical to if you had run

    $ dune utop ./Fb

...but with the reference, 'ground truth' implementation supplying the `eval` function.
