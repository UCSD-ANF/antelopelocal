# Top level Makefile for Antelope Local Extenstions.
#
# This is intentionally NOT an ANTELOPEMAKE Makefile to avoid
# MACRO namespace polution for the 3rdparty tree
# We do however borrow the DIRS make rule for making subdirectories
#
DIRS=adm data 3rdparty

all install installMAN pf relink clean Include tags uninstall :: FORCED
	if [ ! -d ${ANTELOPE}/local ]; then \
	  for dirname in bin lib man data/pf; do \
	    mkdir -p /opt/antelope/${antver}/local/$dirname; \
	  done \
	fi
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
	true
