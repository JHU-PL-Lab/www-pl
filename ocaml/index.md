### OCaml Lecture Information

*   [lecture.html](code/lecture.html), the file we work through interactively in class.
*   For the separate compilation topic we cover [this example (zipped)](code/sep.zip)

### Our ML Dialect

We will use [OCaml](http://ocaml.org), version 4.11.1.

### Installing OCaml 4.11.1

We require that you use the [OPAM packaging system](https://opam.ocaml.org) for installing OCaml and its extensions.  Once you get `opam` installed and working, everything else should be easy to install .. so the only hard part is the first step.

-   For Linux or Mac see [The OPAM install page](https://opam.ocaml.org/doc/Install.html) for install instructions. 
-  For Mac users, the above requires Homebrew (a package manager for Linux-ish libraries) so here is a more detailed suggestion of some copy/paste that should work.
	- Mac without homebrew installed:`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"` will install Homebrew 
	- Mac with Homebrew (make sure you first do a `brew update` before this): `brew install gpatch; brew install opam`
- You will then need to run some terminal commands to set up the basics:
    1.  `opam init` to initialize OPAM;
    2.  `opam switch create 4.11.1` (this will take awhile) to build OCaml version 4.11.1 (the initial install is usually a slightly outdated version; also, if you already had an OPAM install you need to `opam update` before this `switch` to make sure OPAM is aware of the latest version);
	3.  `eval (opam env)` to let your shell know where the OPAM files are; and
    4.  Also add the very same line, `eval (opam env)`, to your`.profile`/`.bashrc` shell init file as you would need to do that in every new terminal window otherwise. (for `.zshrc` on macs, use ``eval `opam env` ``instead )
    5. Lastly, in order for the OCaml top loop to start up with some of these libraries already loaded, edit the file `~/.ocamlinit` to add the lines below (note `opam` might have created this file, just make sure the line below is in it).  The lines in this file are input to the top loop when it first starts.  `topfind` really should be built-in, it allows you to load libraries. 
```ocaml
#use "topfind";;
```


-   Windows Windows Windows.. the OCaml toolchain is unfortunately not good in straight Windows.
    -   If you are running a recent Windows install, we recommend installing [WSL 2](https://docs.microsoft.com/en-us/windows/wsl/) which once you have set up will allow you to follow the Linux Ubuntu install instructions to get `opam`. 
    -   Option 2 is to set up a Linux VM on your Windows box, and then set up a Linux install of OCaml within the VM.  There are many good tutorials on how to build a Linux VM, [here is one of them](https://www.lifewire.com/run-ubuntu-within-windows-virtualbox-2202098).  Once your virtual Linux box is set up, you can follow the `opam` Linux install instructions.


#### Required OPAM Standard packages

Once you have the basics installed, run the following shell command to install additional necessary packages used in the class:

```bash
opam install merlin ocp-indent menhir utop ppx_deriving ounit2
```


**For the course we will be implicitly assuming you installed all of these OPAM packages; some things will not work if these are not all installed.**

### OCaml with the PL Book FbDK

See the [FbDK README](../book/_dist/fbdk/) for information on how to use the FbDK.

#### The OCaml Manual

The OCaml manual is [here](http://caml.inria.fr/pub/docs/manual-ocaml/).
* We will cover most of the topics in Part I Chapters 1 and 2 from the manual.
* Manual Chapter 7 is the language reference where you can look up details if needed. 
* Part III of the manual documents the tools, we will not be using much of this because third parties have improved on many of the tools and we will instead use those versions.
* Part IV describes the standard libraries, which we will make some use of. 
   -  The [Core Library](http://caml.inria.fr/pub/docs/manual-ocaml/core.html) chapter describes standard types and exceptions built into OCaml, and the [Pervasives module](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html) referenced there includes all basic int/bool/float/string/etc operations such as `<`, `mod`, etc which are always available.
   -  The [Standard Library](http://caml.inria.fr/pub/docs/manual-ocaml/stdlib.html) chapter includes standard data structures such as hashtables and stacks as well as library operations for lists, arrays, strings, printing, etc.

### Our OCaml Toolbox

Here are all the tools we will be using.  You are required to have a build for which all these tools work, and the above `opam` one-liner should install them all.

* [`opam`](https://opam.ocaml.org) is the package management system.  See above for install and setup instructions.
* [`ocamlc`](http://caml.inria.fr/pub/docs/manual-ocaml/comp.html) is the standalone compiler which we will be invoking via the `dune` build tool.
* [`utop`](https://opam.ocaml.org/blog/about-utop/) is the read/eval/print loop we will be using.  It is a replacement for the original [`ocaml`](http://caml.inria.fr/pub/docs/manual-ocaml/toplevel.html) command, with many more features such as command history, replay, etc.
* [`dune`](https://dune.build) is the build tool (think `make`) that we will be using.  `ocamlbuild` is the standard build tool but it is not very flexible so we will not be using it.
* [OUnit](https://github.com/gildor478/ounit) is the unit tester for OCaml.  The opam package is called `ounit2` for obscure reasons.

### Development Environments for OCaml

You should use one of VSCode or Atom since they have OCaml-specific features such as syntax highliting, auto-indent, and lint analysis to make the coding process much smoother. If you are using a VM under Windows, you should aim to run one of these editors *within* the VM to take advantage of syntax highlighting and the like for OCaml.

**[Visual Studio Code](https://code.visualstudio.com)**: 
VSCode has very good OCaml support and is the "officially recommended editor". Install the **OCaml and Reason IDE** extension to get syntax highlighting, type information, etc: from the `View` menu select `Extensions`, then type in OCaml and this extension will show up; install it. You can also easily run a `utop` shell from within VSCode, just open up a shell from the `Terminal` menu and type `utop`.

[**Atom**](https://atom.io): 
Atom is very good with OCaml, but is unfortunately being slowly phased out after Microsoft bought Github.  So, it is probably a good time to switch from Atom to VSCode if you have not already.  To use Atom with OCaml install the `atom` and `apm` shell commands (see the **Atom..Install Shell Commands** menu option on Macs, or type shift-command-p(⇧⌘P) and then in the box type command `Window: Install Shell Commands`). With those commands installed, type into a terminal

        apm install language-ocaml linter ocaml-indent ocaml-merlin

to install the relevant OCaml packages. Here are some handy Atom keymaps for common operations these extensions support -- add this to your `.atom/keymap.cson` file:

        'atom-text-editor[data-grammar="source ocaml"]':
          'ctrl-shift-t': 'ocaml-merlin:show-type'
          'alt-shift-r': 'ocaml-merlin:rename-variable'
          'ctrl-shift-l': 'linter:lint'
          'ctrl-alt-f': 'ocaml-indent:file'

`linter:lint` will refresh the lint data based on the latest compiled version of your code. In addition, control-space should auto-complete.

**vim**: If you use `vim`, my condolances as it is woefully behind the times in spite of many band-aids added over the years.  Still, if you have been brainwashed to believe it is good, type shell command `opam install user-setup` followed by command `opam user-setup install` after doing the above  default `opam` install to set up syntax highlighting, tab completion, displaying types, etc. See [here](https://github.com/ocaml/merlin/blob/master/vim/merlin/doc/merlin.txt) for some dense documentation.

**emacs**: See vim for extra install commands needed.  Confession: I still use emacs a bit but am trying to wean myself.  35-year-old habits die hard.  Note you will need to also `opam install tuareg` to get emacs to work; follow the instructions the install prints out.

### Coding Style

* The [FPSE Style Guide](http://pl.cs.jhu.edu/fpse/style-guide.html) is the standard we will adhere to in the class; it follows general best practices for modern OCaml.

### Example Worked OCaml Exercises

* [Exercism OCaml Track](https://exercism.io/tracks/ocaml/exercises) has a large set of programming problems to solve which have solutions by many other programmers as well.  We will reference some of these examples in lecture.
* [Learn OCaml](https://ocaml-sf.org/learn-ocaml-public/#activity%3Dexercises) has a large number of exercises to solve.  The [solutions are online](https://github.com/ocaml-sf/learn-ocaml-corpus/tree/master/exercises).

### Other Resources

* [Cornell cs3110 book](https://www.cs.cornell.edu/courses/cs3110/2020sp/textbook/) is related to this course and was one of the main inspirations along with Real World OCaml.
* [ocaml.org](http://ocaml.org) is the home of OCaml for finding downloads, documentation, etc. The [tutorials](http://ocaml.org/learn/tutorials/) are also very good and there is a page of [books](http://ocaml.org/learn/books.html).
* The [OCaml Youtube Tutorial](https://www.youtube.com/playlist?list=PLea0WJq13cnCef-3KSU3qWFge9OGUlKx1) if you like watching videos to learn things.

