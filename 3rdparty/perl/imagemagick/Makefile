#
# Note: this is not an Antelope Makefile, as it builds 3rd party software 
# Do not include $(ANTELOPEMAKE) here
#

IM_VERSION=1.3.8
IM_SOURCE_ARCHIVE=files/rrdtool-$(IM_VERSION).tar.gz
BUILD_ROOT=build
IM_BUILD_DIR=$(BUILD_ROOT)/rrdtool-$(IM_VERSION)
IM_BINDING_DIR=$(IM_BUILD_DIR)/bindings/perl-shared

all: patch compile

extract: $(IM_BUILD_DIR)

$(IM_BUILD_DIR): 
	@echo "Extracting $(IM_SOURCE_ARCHIVE) to build/$(IM_BUILD_DIR)"
	cd $(BUILD_ROOT) && \
	  gzip -dc ../$(IM_SOURCE_ARCHIVE) | tar xvf -

#patch: extract patch-makefile.pl

#patch-makefile.pl: patch-makefile.pl.state

#patch-makefile.pl.state: files/rrdtool-perl-shared-csw.diff $(IM_BINDING_DIR)/Makefile.PL
#	patch -i $^
#	touch $@

patch: $(IM_BINDING_DIR)/Makefile.PL

$(IM_BINDING_DIR)/Makefile.PL: files/rrdtool-perl-shared-csw.diff $(IM_BUILD_DIR)
	patch -i files/rrdtool-perl-shared-csw.diff $@

$(IM_BINDING_DIR)/makefile: $(IM_BINDING_DIR)/Makefile.PL
	cd $(IM_BINDING_DIR) && perl Makefile.PL

compile: $(IM_BINDING_DIR)/makefile
	cd $(IM_BINDING_DIR) && make

install: compile

clean:: 
	rm -rf $(IM_BUILD_DIR)

#clean:: 
#	rm -f patch-makefile.pl.state

.DUMMY:
	true
