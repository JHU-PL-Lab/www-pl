FbDK
====

This is a distribution of the Fb ("F-flat") development kit (FbDK).  The FbDK is
a tool for learning programming language theory through the development of
interpreters and type systems.  Your course instructor will indicate how the kit
is to be used for class. The example commands listed here are intended to be run
from the root of the folder you extracted your fbdk distribution zip file into,
but can be generalized easily.

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

To force a rebuild, running `dune clean` first will remove all artifacts
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
function directly from the OCaml toploop. This is quite simple with `dune`,
for example to interactively debug or test your `Fb` interpreter, run:

    $ dune utop ./Fb

The compiled OCaml objects will be loaded into your toploop
session and you will be able to use the types and functions defined in your
source code. You will need to access the bindings from the correct module to use them, or
make sure they are visible in scope, for example by doing:
    
    # open Debugutils;;

or just by referencing the name:

    # Debugutils.parse "1 + 2";;

If you have opened the module, you will have the following operations available:
- `parse` / `unparse`

    These allow conversion between strings and Fbdk expressions.
    
- `parse_eval`

    This both parses an expression from a string, and evaluates it
    according to the currently loaded interpreter. The result is
    the evaluated Fbdk expression value.

- `parse_eval_unparse` / `peu`

    This performs parsing and evaluation as above, and finally converts
    the expression back to a string so it can easily be read or printed.
    The abbreviated form is for convenience, but is otherwise identical.

- `parse_eval_print`

    This performs parsing, evaluation, and then conversion back to a string,
    and finally prints out the value in human-readable form. 
    This is the the core operation which the interpreters perform when they are
    run outside of utop.

If you want to build Fbdk expressions in their AST form explicitly, then
you will probably want to add:

    # open Fbdk.Ast;;

Good luck!


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

...but with the reference, 'ground truth' implementation supplying the definitions.
The same Debugutils and Fbdk functions and modules are available.