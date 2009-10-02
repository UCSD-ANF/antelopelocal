#
# Note: this is not an Antelope Makefile, as it builds 3rd party software 
# Do not include $(ANTELOPEMAKE) here
#

IM_VERSION=6.5.2
IM_SUBREV=10
IM_SOURCE_ARCHIVE=files/ImageMagick-$(IM_VERSION)-$(IM_SUBREV).tar.gz
BUILD_ROOT=build
IM_BUILD_DIR_PREFIX=ImageMagick-
IM_BUILD_DIR=$(BUILD_ROOT)/$(IM_BUILD_DIR_PREFIX)$(IM_VERSION)-$(IM_SUBREV)
IM_BINDING_DIR=$(IM_BUILD_DIR)/PerlMagick

all: compile

# PerlMagick is used by a bunch of contrib stuff as well as the ANF website so it should be installed when the AntelopeMake "Include" target is requested
Include: install

extract: $(IM_BUILD_DIR)

$(IM_BUILD_DIR): 
	@echo "Extracting $(IM_SOURCE_ARCHIVE) to build/$(IM_BUILD_DIR)"
	cd $(BUILD_ROOT) && \
	  gzip -dc ../$(IM_SOURCE_ARCHIVE) | tar xvf -

patch: $(IM_BINDING_DIR)/Makefile.PL

PATCHFILE=files/perlmagick-makefile-solaris-csw.diff
$(IM_BINDING_DIR)/Makefile.PL: $(PATCHFILE) $(IM_BUILD_DIR)
	patch -i $(PATCHFILE) $@

$(IM_BINDING_DIR)/Makefile: $(IM_BINDING_DIR)/Makefile.PL
	cd $(IM_BINDING_DIR) && perl Makefile.PL

compile: $(IM_BINDING_DIR)/Makefile patch
	cd $(IM_BINDING_DIR) && make

install: compile
	cd $(IM_BINDING_DIR) && $(MAKE) $@

uninstall: $(IM_BINDING_DIR)/Makefile
	cd $(IM_BINDING_DIR) && $(MAKE) $@

archive-clean:
	if [ -d $(IM_BINDING_DIR) ] ; then \
	  cd $(IM_BINDING_DIR) && $(MAKE) clean ; \
	fi
# Remove any build products
clean:: 
	@rm -rf $(BUILD_ROOT)/$(IM_BUILD_DIR_PREFIX)*

relink: archive-clean compile

.DUMMY:
	true
