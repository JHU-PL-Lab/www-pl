# This file contains the instructions to compile the existing interpreters in
# the FbDK.

# Global aliases
srcdir = src
builddir = _build

# Determine a list of interpreters
interpreter_dirs = $(sort $(dir $(wildcard $(srcdir)/*/*)))
interpreters = \
	$(subst /,,\
		$(subst $(srcdir)/,,$(interpreter_dirs))\
	)

# The version file used by the toploop for display purposes.
$(srcdir)/version.ml: version.txt
	echo "let version = \""$(shell cat version.txt)"\"" > $(srcdir)/version.ml
	echo "let date = \""$(shell date)"\"" >> $(srcdir)/version.ml

# A build for a single interpreter
%.byte: phony $(srcdir)/version.ml
	ocamlbuild -use-menhir -I $(srcdir) -Is "$(interpreter_dirs)" -r $@

# Build all interpreters
.PHONY: all
all: $(addsuffix .byte,$(call lowercase,$(interpreters)))

# Clean all interpreters
.PHONY: clean
clean:
	ocamlbuild -clean
