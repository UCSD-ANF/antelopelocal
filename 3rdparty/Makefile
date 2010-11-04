# Makefile for 3rdpary Antelope Local Extenstions.
#
# Software in this directory will be installed in the $ANTELOPE tree for use
# by the contrib archive.
#
# This is intentionally NOT an ANTELOPEMAKE Makefile to avoid
# MACRO namespace polution for the 3rdparty tree
# We do however borrow the DIRS make rule for making subdirectories
#
DIRS=perl

all install installMAN pf relink clean Include tags uninstall :: FORCED
	@-DIRS="$(DIRS)" ;\
	for i in $$DIRS ; do \
	  printf "+    %-40s  %s\n" $$i "`date`" ; \
	  if [ -f $$i/Makefile -o \
	       -f $$i/makefile -o -f $$i/GNUmakefile ] ; \
	  then \
	    ( cd $$i && $(MAKE) $@ ; ) ; \
	  else \
	    if [ -d $$i ] ; then \
	      echo Error: no Makefile in `pwd`/$$i ;\
	    fi \
	  fi \
	done

FORCED :
