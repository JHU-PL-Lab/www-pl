### OCaml Lecture Information

*   [lecture.html](lecture.html), the file we work through interactively in class.
*   For the separate compilation topic we cover [this example (zipped)](set-example.zip)

### Our ML Dialect

We will use [OCaml](http://ocaml.org), version 5.1.1.

### Installing OCaml 5.1.1

We require that you use the [opam packaging system](https://opam.ocaml.org) for installing OCaml and its extensions.  Once you get `opam` installed and working, everything else should be easy to install .. so the only hard part is the first step.

-  For Linux or Mac see [The OPAM install page](https://opam.ocaml.org/doc/Install.html) for install instructions. 
-  For Mac users, the above requires [Homebrew](https://brew.sh) (a package manager for Linux-ish libraries) so here is a more detailed suggestion of some copy/paste that should work.
	- Mac without homebrew installed:
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ``` 
    will install Homebrew 
	- Mac with Homebrew (make sure you first do a `brew update` before this): `brew install gpatch; brew install opam`
-   For Windows you should use WSL2, the Windows Subsystem for Linux.  It creates a Linux-like system from within Windows.
    - Once you install [WSL 2](https://docs.microsoft.com/en-us/windows/wsl/) you will be able to follow the Linux Ubuntu install instructions linked above. 
       - Note that your WSL2 Ubuntu needs the C compiler and tools for the `opam` install to work; the following Linux shell command will get you those: `sudo apt update && sudo apt install make m4 gcc zip unzip bubblewrap`.
       - You can still use your Windows install of VSCode to edit files by using the [VSCode Remote WSL Extension](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode) -- it will connect the Windows editor to the underlying WSL2 subsystem.  See below where VSCode is described for details on how to set this up.
    -  WSL2 has been working well for most people, but another option is to set up a Linux VM on your Windows box, and then set up a Linux install of OCaml within the VM.  There are many good tutorials on how to build a Linux VM, [here is one of them](https://www.lifewire.com/run-ubuntu-within-windows-virtualbox-2202098).  Once your virtual Linux box is set up, you can follow the `opam` Linux install instructions.

### Initial setup of `opam`
- You will then need to run some terminal commands to set up the basics:
    1.  `opam init` to initialize OPAM (we suggest you answer `y` to the question `Do you want opam to modify ~/.profile? [N/y/f]`);
    2.  If you didn't get that question or said `N`, you will need to add line, `eval $(opam env)`, to your `~/.bash_profile` or `~/.profile` or `~/.bashrc` shell init file (add to the first one of these files that exists already) as you would need to do that in every new terminal window otherwise. If you are using `zsh` on macs, add line ``eval `opam env` `` instead to your `~/.zshrc` file. 
    3.  Type command `eval $(opam env)` to your shell to let it know where the opam files are (zsh users on Macs type ``eval `opam env` `` instead)       
    4. Type `opam update && opam switch create 5.1.1` (this will take awhile) to build OCaml version 5.1.1.
    5. At the end of the install it will likely suggest an `eval` command to type; do that.
- If you already have an earlier version of OCaml installed via `opam`, you should only need to run the 4th line. 

(Note if you took FPSE you need to make sure to switch to 5.1.1 and also follow all the configuration steps below as they are different and the OCaml version is different.   We are not using `Core` in this class so you need to make sure to also remove any reference to core in your `.ocamlinit` file.)

### Configuring OCaml 

Once you have OCaml 5.1.1 installed, run the following `opam` command in the terminal to install additional necessary packages used in the class:
```bash
opam install ocaml-lsp-server menhir utop ppx_deriving ounit2 ocamlformat
```

Lastly, edit the file `~/.ocamlinit` to consist of only the line 
```ocaml
#use "topfind";;
```
The contents of this file are entered in the top loop when it starts.  Here is an easy one-liner you can copy/paste into your terminal to set that file up:
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
* [`utop`](https://opam.ocaml.org/blog/about-utop/) is the read/eval/print loop we will be using.  It is a replacement for the original [`ocaml`](http://caml.inria.fr/pub/docs/manual-ocaml/toplevel.html) command, with many more features such as command history, replay, etc.
* [`dune`](https://dune.build) is the build tool (think `make`) that we will be using.
* [OUnit](https://github.com/gildor478/ounit) is the unit tester for OCaml.  The opam package is called `ounit2` for obscure reasons.

### Development Environments for OCaml

We strongly recommend VSCode since it has OCaml-specific features such as syntax highlighting, auto-indent, and lint analysis to make the coding process much smoother.

**[Visual Studio Code](https://code.visualstudio.com)**

* To make VSCode OCaml-aware you will need to install the **OCaml Platform**.   To install it, from the `View` menu select `Extensions`, and type OCaml in the search box and this extension will show up: select **OCaml Platform** from the list.

* You can easily run a `utop` shell from within VSCode, just open up a shell from the `Terminal` menu and type `utop`.

* If you are on Windows and using WSL2, you need to run Visual Studio "in WSL2 space" to get OCaml syntax highlighting and other nice features. See the [Remote WSL Extension Docs](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode) for details on how to set up the VSCode-WSL2 connection.  If you are having trouble look at the [Additional Resources](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode#additional-resources) on that page.  Once you have the above set up, install the OCaml Platform as described above and you should have syntax highlighting etc working.

**vim**: If you use `vim`, you really need to switch to VSCode..  `vim` is 1970's tech with 50 years of band-aids added to it (I was using its predecessor, `vi`, in 1979).  If you are having trouble switching to a modern editor, try `opam install merlin ocp-indent user-setup` and `opam user-setup install` after doing the above  default `opam` install to set up syntax highlighting, tab completion, displaying types, etc. for `vim`.  See [here](https://github.com/ocaml/merlin/blob/master/vim/merlin/doc/merlin.txt) for some dense documentation.

**emacs**: See vim. Note you will need to also `opam install tuareg` to get emacs to work, and follow the instructions the install prints out.

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
* [OCaml from the very beginning](https://johnwhitington.net/ocamlfromtheverybeginning/) is a free online book.
* The [OCaml Youtube Tutorial](https://www.youtube.com/playlist?list=PLea0WJq13cnCef-3KSU3qWFge9OGUlKx1) if you like watching videos to learn things.

