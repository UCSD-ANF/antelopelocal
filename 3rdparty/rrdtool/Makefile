#
# Note: this is not an Antelope Makefile, as it builds 3rd party software 
# Do not include $(ANTELOPEMAKE) here
#

RRD_VERSION=1.3.8
RRD_SOURCE_ARCHIVE=files/rrdtool-$(RRD_VERSION).tar.gz
BUILD_ROOT=build
RRD_BUILD_DIR=$(BUILD_ROOT)/rrdtool-$(RRD_VERSION)
RRD_BINDING_DIR=$(RRD_BUILD_DIR)/bindings/perl-shared

all: patch compile

extract: $(RRD_BUILD_DIR)

$(RRD_BUILD_DIR): 
	@echo "Extracting $(RRD_SOURCE_ARCHIVE) to build/$(RRD_BUILD_DIR)"
	cd $(BUILD_ROOT) && \
	  gzip -dc ../$(RRD_SOURCE_ARCHIVE) | tar xvf -

#patch: extract patch-makefile.pl

#patch-makefile.pl: patch-makefile.pl.state

#patch-makefile.pl.state: files/rrdtool-perl-shared-csw.diff $(RRD_BINDING_DIR)/Makefile.PL
#	patch -i $^
#	touch $@

patch: $(RRD_BINDING_DIR)/Makefile.PL

$(RRD_BINDING_DIR)/Makefile.PL: files/rrdtool-perl-shared-csw.diff $(RRD_BUILD_DIR)
	patch -i files/rrdtool-perl-shared-csw.diff $@

$(RRD_BINDING_DIR)/makefile: $(RRD_BINDING_DIR)/Makefile.PL
	cd $(RRD_BINDING_DIR) && perl Makefile.PL

compile: $(RRD_BINDING_DIR)/makefile
	cd $(RRD_BINDING_DIR) && make

install: compile

clean:: 
	rm -rf $(RRD_BUILD_DIR)

#clean:: 
#	rm -f patch-makefile.pl.state

.DUMMY:
	true
