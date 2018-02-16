# This file contains the instructions to create a student distribution of the
# FbDK.  The resulting distribution has none of the implementations of the
# interpreters or typecheckers.

distdir = _dist
fbdkrawdir = fbdk
fbdkdir = $(distdir)/$(fbdkrawdir)
fbdkbindir = $(fbdkdir)/binaries
fbdkmoddir = $(fbdkbindir)/libraries
overlaydir = dist_overlay
debugscriptdir = debugscript

base_files = \
	version.txt \
	COPYING \
	.merlin \
    _tags

.PHONY: dist
dist: distclean all
	mkdir -p $(fbdkdir)
	mkdir -p $(fbdkdir)/$(srcdir)
	mkdir -p $(fbdkdir)/$(debugscriptdir)
	# Copy base files and source code
	cp $(base_files) $(fbdkdir)/
	cp -r $(srcdir)/* $(fbdkdir)/$(srcdir)
	cp -r $(debugscriptdir)/* $(fbdkdir)/$(debugscriptdir)
	# Copy existing binaries
	mkdir -p $(fbdkbindir)
	cp *.byte $(fbdkbindir)
	# Copy modules for debugging
	mkdir -p $(fbdkmoddir)
	cp $(shell find $(builddir) -name '*.cmo') $(fbdkmoddir)
	cp $(shell find $(builddir) -name '*.cmi') $(fbdkmoddir)
	# Overlay existing files with dist_overlay contents
	rsync -rL $(overlaydir)/* $(fbdkdir)/
	# Build distribution tarball
	cd $(distdir); \
		tar cvzf $(fbdkrawdir).tgz $(fbdkrawdir)
	cd $(distdir); \
		ln -s $(fbdkrawdir).tgz $(fbdkrawdir)-$(shell cat version.txt).tgz

.PHONY: distclean
distclean:
	rm -rf $(distdir)
