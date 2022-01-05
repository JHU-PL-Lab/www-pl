### OCaml Lecture Information

*   [lecture.html](lecture.html), the file we work through interactively in class.
*   For the separate compilation topic we cover [this example (zipped)](set-example.zip)

### Our ML Dialect

We will use [OCaml](http://ocaml.org), version 4.13.1.

### Installing OCaml 4.13.1=

We require that you use the [opam packaging system](https://opam.ocaml.org) for installing OCaml and its extensions.  Once you get `opam` installed and working, everything else should be easy to install .. so the only hard part is the first step.

-   For Linux or Mac see [The OPAM install page](https://opam.ocaml.org/doc/Install.html) for install instructions. 
-  For Mac users, the above requires [Homebrew](https://brew.sh) (a package manager for Linux-ish libraries) so here is a more detailed suggestion of some copy/paste that should work.
	- Mac without homebrew installed:`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` will install Homebrew 
	- Mac with Homebrew (make sure you first do a `brew update` before this): `brew install gpatch; brew install opam`
- You will then need to run some terminal commands to set up the basics:
    1.  `opam init` to initialize OPAM;
    2.  `opam switch create 4.13.1` (this will take awhile) to build OCaml version 4.13.1 (the initial install is usually a slightly outdated version; also, if you already had an OPAM install you need to `opam update` before this `switch` to make sure OPAM is aware of the latest version);
	3.  `eval $(opam env)` to let your shell know where the OPAM files are (use ``eval `opam env` `` instead if you are using `zsh` on a Mac); and
    4.  Also add the very same line, `eval $(opam env)`, to your`.profile`/`.bashrc` shell init file as you would need to do that in every new terminal window otherwise. (for `.zshrc` on macs, add line ``eval `opam env` `` instead)
    
- If you already have an earlier version of OCaml installed via `opam`, start on step 2. above to update to 4.13.1.  Make sure to do the `opam update` step first or your install won't know that 4.13.1 even exists.

-   Windows Windows Windows.. the OCaml toolchain is unfortunately not good in straight Windows.
    -   If you are running a recent Windows install, we recommend installing [WSL 2](https://docs.microsoft.com/en-us/windows/wsl/) which once you have set up will allow you to follow the Linux Ubuntu install instructions above to get `opam`. 
       - Note that your Ubuntu needs the C compiler and tools for the `opam` install to work; the following Linux shell command will get you those: `sudo apt install make m4 gcc unzip`.
       - [More WSL2 for OCaml tips here](https://www.cs.princeton.edu/courses/archive/fall20/cos326/WindowsSemiNative.php).  
    -   Option 2 is to set up a Linux VM on your Windows box, and then set up a Linux install of OCaml within the VM.  There are many good tutorials on how to build a Linux VM, [here is one of them](https://www.lifewire.com/run-ubuntu-within-windows-virtualbox-2202098).  Once your virtual Linux box is set up, you can follow the `opam` Linux install instructions.

### Configuring OCaml 

Once you have OCaml 4.13.1 installed, run the following `opam` command in the terminal to install additional necessary packages used in the class:
```bash
opam install merlin ocp-indent menhir utop ppx_deriving ounit2
```

Lastly, edit the file `~/.ocamlinit` to add the line 
```ocaml
#use "topfind";;
```
if it is not already in the file.  The contents of this file are entered in the top loop when it starts.  Here is an easy one-liner you can copy/paste into your terminal to set that file up:
```sh
echo '#use "topfind";;'  > ~/.ocamlinit
```

### OCaml with the PL Book FbDK

See the [FbDK README](../book/dist/fbdk/README.md) for information on how to use the FbDK.  We will not use it on the first several assignments.

### The Official OCaml Manual

The OCaml manual is [here](https://ocaml.org/manual/).
* We will cover most of the topics in Part I Chapters 1 and 2 from the manual.
* Manual Chapter 7 is the language reference where you can look up details if needed. 
* Part III of the manual documents the tools, we will not be using much of this because third parties have improved on many of the tools and we will instead use those versions.
* Part IV describes the standard libraries, which we will make some use of. 
   -  The [Core Library](https://ocaml.org/manual/core.html) chapter describes standard types and exceptions built into OCaml, and the [Stdlib module](https://ocaml.org/api/Stdlib.html) referenced there includes all basic int/bool/float/string/etc operations such as `<`, `mod`, etc which are always available.
   -  The [Standard Library](https://ocaml.org/manual/stdlib.html) chapter includes standard data structures such as hashtables and stacks as well as library operations for lists, arrays, strings, printing, etc.

### Our OCaml Toolbox

Here are all the tools we will be using.  You are required to have a build for which all these tools work, and the above `opam` one-liner should install them all.

* [`opam`](https://opam.ocaml.org) is the package management system.  See above for install and setup instructions.
* [`ocamlc`](http://caml.inria.fr/pub/docs/manual-ocaml/comp.html) is the standalone compiler which we will be invoking via the `dune` build tool.  You don't really need to know much about it as you will not need to invoke it directly.
* [`utop`](https://opam.ocaml.org/blog/about-utop/) is the read/eval/print loop we will be using.  It is a replacement for the original [`ocaml`](http://caml.inria.fr/pub/docs/manual-ocaml/toplevel.html) command, with many more features such as command history, replay, etc.
* [`dune`](https://dune.build) is the build tool (think `make`) that we will be using.
* [OUnit](https://github.com/gildor478/ounit) is the unit tester for OCaml.  The opam package is called `ounit2` for obscure reasons.

### Development Environments for OCaml

**[Visual Studio Code](https://code.visualstudio.com)**

VSCode has very good OCaml support and is the "officially recommended editor". 

* We recommend you use the plugin called **OCaml Platform** for OCaml support in VSCode.   To install it, first run `opam install ocaml-lsp-server` from a terminal.  Then from the `View` menu in VSCode select `Extensions`, then type in OCaml in the search box and this extension will show up: select **OCaml Platform** from the list.

* (If you are having problems with installing OCaml Platform you could try to install the **OCaml and Reason IDE** extension instead (it has fewer features however): from the `View` menu select `Extensions`, then type in OCaml in the search box and this extension will show up; install it.)

* You can easily run a `utop` shell from within VSCode, just open up a new terminal from the `Terminal` menu and type `utop`.

* If you are on Windows and using WSL2, you should run Visual Studio "in WSL2 space" so you get OCaml syntax highlighting and other nice features; see [this blog post](https://code.visualstudio.com/blogs/2019/09/03/wsl2) for how you can set it up.

**vim**: If you use `vim`, my condolances as it is woefully behind the times in spite of many band-aids added over the years.  Still, if you have been brainwashed to believe it is good, type shell commands `opam install user-setup` and `opam user-setup install` after doing the above  default `opam` install to set up syntax highlighting, tab completion, displaying types, etc. See [here](https://github.com/ocaml/merlin/blob/master/vim/merlin/doc/merlin.txt) for some dense documentation.

**emacs**: See vim.  Confession: I still use emacs a bit but have managed to mostly wean myself.  40-year habits die hard.  Note you will need to also `opam install tuareg` to get emacs to work, and follow the instructions the install prints out.

### Coding Style

* The [FPSE Style Guide](http://pl.cs.jhu.edu/fpse/style-guide.html) is the standard we will adhere to in the class; it follows general best practices for modern OCaml.

### Example Worked OCaml Exercises
Looking at other people's code is a good way to learn good coding practices.

* [Exercism OCaml Track](https://exercism.io/tracks/ocaml/exercises) has a large set of programming problems to solve which have solutions by many other programmers as well.
* [99 problems](https://ocaml.org/learn/tutorials/99problems.html) solves 99 basic OCaml tasks.
* [Learn OCaml](https://ocaml-sf.org/learn-ocaml-public/#activity%3Dexercises) has a large number of exercises to solve.  The [solutions are online](https://github.com/ocaml-sf/learn-ocaml-corpus/tree/master/exercises).

### Other Resources

* [Cornell cs3110 book](https://www.cs.cornell.edu/courses/cs3110/2020sp/textbook/) is another course which uses OCaml; it is more focused on programming and less on PL theory than this class is.
* [ocaml.org](http://ocaml.org) is the home of OCaml for finding downloads, documentation, etc. The [tutorials](http://ocaml.org/learn/tutorials/) are also very good and there is a page of [books](http://ocaml.org/learn/books.html).
* The [OCaml Youtube Tutorial](https://www.youtube.com/playlist?list=PLea0WJq13cnCef-3KSU3qWFge9OGUlKx1) if you like watching videos to learn things.

