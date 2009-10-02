#
# Note: this is not an Antelope Makefile, as it builds 3rd party software 
# Do not include $(ANTELOPEMAKE) here
#

IM_VERSION=6.5.2
IM_SUBREV=10
IM_SOURCE_ARCHIVE=files/ImageMagick-$(IM_VERSION)-$(IM_SUBREV).tar.gz
BUILD_ROOT=build
IM_BUILD_DIR=$(BUILD_ROOT)/ImageMagick-$(IM_VERSION)-$(IM_SUBREV)
IM_BINDING_DIR=$(IM_BUILD_DIR)/PerlMagick

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

PATCHFILE=files/perlmagick-makefile-solaris-csw.diff
$(IM_BINDING_DIR)/Makefile.PL: $(PATCHFILE) $(IM_BUILD_DIR)
	patch -i $(PATCHFILE) $@

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
