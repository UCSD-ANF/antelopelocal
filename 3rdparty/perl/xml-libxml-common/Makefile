#
# Note: this is not an Antelope Makefile, as it builds 3rd party software 
# Do not include $(ANTELOPEMAKE) here
#

PKG_VERSION=0.13
#PKG_SUBREV=10
PKG_SOURCE_ARCHIVE=files/XML-LibXML-Common-$(PKG_VERSION).tar.gz
BUILD_ROOT=build
PKG_BUILD_DIR_PREFIX=XML-LibXML-Common-
PKG_BUILD_DIR=$(BUILD_ROOT)/$(PKG_BUILD_DIR_PREFIX)$(PKG_VERSION)
PKG_BINDING_DIR=$(PKG_BUILD_DIR)

# Variables needed for compilation process
XMLPREFIX=/opt/csw
XSLTPREFIX=/opt/csw

PERLLIBS='-L/opt/csw/lib -lxml2 -lm'
PERLINC='-I/opt/csw/include/libxml2'

all: compile

Include: install

extract: $(PKG_BUILD_DIR)

$(PKG_BUILD_DIR): 
	@echo "Extracting $(PKG_SOURCE_ARCHIVE) to build/$(PKG_BUILD_DIR)"
	cd $(BUILD_ROOT) && \
	  gzip -dc ../$(PKG_SOURCE_ARCHIVE) | tar xvf -

$(PKG_BINDING_DIR)/Makefile.PL: extract

$(PKG_BINDING_DIR)/Makefile: $(PKG_BINDING_DIR)/Makefile.PL
	cd $(PKG_BINDING_DIR) && XMLPREFIX=$(XMLPREFIX) XSLTPREFIX=$(XSLTPREFIX) perl Makefile.PL LIBS=$(PERLLIBS) INC=$(PERLINC)

compile: $(PKG_BINDING_DIR)/Makefile
	cd $(PKG_BINDING_DIR) && XMLPREFIX=$(XMLPREFIX) XSLTPREFIX=$(XSLTPREFIX) $(MAKE)

install: compile
	cd $(PKG_BINDING_DIR) && XMLPREFIX=$(XMLPREFIX) XSLTPREFIX=$(XSLTPREFIX) $(MAKE) $@

uninstall: $(PKG_BINDING_DIR)/Makefile
	cd $(PKG_BINDING_DIR) && XMLPREFIX=$(XMLPREFIX) XSLTPREFIX=$(XSLTPREFIX) $(MAKE) $@

archive-clean:
	if [ -d $(PKG_BINDING_DIR) ] ; then \
	  cd $(PKG_BINDING_DIR) && $(MAKE) clean ; \
	fi
# Remove any build products
clean:: 
	@rm -rf $(BUILD_ROOT)/$(PKG_BUILD_DIR_PREFIX)*

relink: archive-clean compile

.DUMMY:
	true
