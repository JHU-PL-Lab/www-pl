# Sample Eclipse OCaIDE Makefile for a small Caml project
#
#Builder to use:
OCAMLC= ocamlc
#Is it native?
OPT= no
#Generate type information?
ANNOT= yes
#Paths to include with each command:
INCLUDEDPATHS=
#Flags for the project:
PROJECTFLAGS= -g

default: all

#Source files list:
SRC= fSet.mli fSet.ml main.ml
#Find .ml files:
MLFILES= $(filter %.ml,$(SRC))
#Executables to produce:
EXEC= main.byte

#Find out which files to erase with clean:
ITFOBJ=$(MLFILES:.ml=.cmi)
ifeq ($(OPT),yes)
	OBJ=$(MLFILES:.ml=.cmx)
else
	OBJ=$(MLFILES:.ml=.cmo)
endif

ifeq ($(ANNOT),yes)
	TYPE=$(MLFILES:.ml=.annot)
endif

#Some cleaning rules :
clean:
	rm -rf $(OBJ) $(ITFOBJ) $(TYPE) $(EXEC)

mrproper: clean
	rm -rf $(EXEC)

#Rules to build project :

allExe: $(EXEC)

allSrc: $(OBJ)

all: allSrc allExe

main.cmi:

fSet.cmi: fSet.mli
	$(OCAMLC) $(INCLUDEDPATHS) $(PROJECTFLAGS) -c fSet.mli

fSet.cmo: fSet.cmi fSet.ml
	$(OCAMLC) $(INCLUDEDPATHS) $(PROJECTFLAGS) -c fSet.ml

main.cmo: fSet.cmi main.cmi main.ml
	$(OCAMLC) $(INCLUDEDPATHS) $(PROJECTFLAGS) -c main.ml

main.byte: main.cmo fSet.cmo fSet.cmi main.cmi $(MLFILES)
	$(OCAMLC) -o main.byte $(INCLUDEDPATHS) $(PROJECTFLAGS) fSet.cmo main.cmo
