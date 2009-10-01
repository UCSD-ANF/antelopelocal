#
# Note: this is not an Antelope Makefile, as it builds 3rd party software 
# Do not include $(ANTELOPEMAKE) here
#

RRD_VERSION=1.3.8
RRD_SOURCE_ARCHIVE=files/rrdtool-$(RRD_VERSION).tar.gz
BUILD_ROOT=build
RRD_BUILD_DIR=$(BUILD_ROOT)/rrdtool-$(RRD_VERSION)
RRD_INSTALL_DIR=${ANTELOPE}
RRD_CONFIG_OPTS=--prefix=${RRD_INSTALL_DIR} \
		--disable-libintl \
		--disable-python \
		--enable-ruby \
		--enable-perl \
		--enable-perl-site-install

LDFLAGS ="-R/opt/csw/lib -R$(RRD_INSTALL_DIR)/lib"
#CFLAGS = "-x03 -xcode=pic13"
CFLAGS=""

## This is needed by rrdtool's configure unfortunately, and is very solaris-specific
PKG_CONFIG_PATH=/usr/lib/pkgconfig:/opt/csw/lib/pkgconfig

all: extract configure fixlibtool compile

extract: $(RRD_BUILD_DIR)

$(RRD_BUILD_DIR): 
	@echo "Extracting $(RRD_SOURCE_ARCHIVE) to build/$(RRD_BUILD_DIR)"
	cd $(BUILD_ROOT) && \
	  gzip -dc ../$(RRD_SOURCE_ARCHIVE) | tar xvf -

compile: configure
	cd $(RRD_BUILD_DIR) && LDFLAGS=$(LDFLAGS) make

configure: $(RRD_BUILD_DIR)/Makefile

$(RRD_BUILD_DIR)/Makefile: $(RRD_BUILD_DIR)
	cd $(RRD_BUILD_DIR) && LDFLAGS=$(LDFLAGS) PKG_CONFIG_PATH=${PKG_CONFIG_PATH} ./configure $(RRD_CONFIG_OPTS)

# Several of the libraries shiped by OpenCSW on Solaris have libtool files distributed with them. These files break the build process on Solaris, so the fixlibtool.sh (borrowed from OpenCSW.org's GAR build tool) does a fixup on the makefiles and libtool files. Again solaris-specific, and CSW specific
fixlibtool: configure
	files/fixlibtool.sh $(RRD_BUILD_DIR)

install: compile
	cd ${RRD_BUILD_DIR} && LDFLAGS=$(LDFLAGS) make install

clean:: 
	rm -rf $(RRD_BUILD_DIR)

#clean:: 
#	rm -f patch-makefile.pl.state

.DUMMY:
	true
