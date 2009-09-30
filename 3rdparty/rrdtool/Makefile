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
		--disable-ruby \
		--enable-perl \
		--enable-perl-site-install

all: patch compile

extract: $(RRD_BUILD_DIR)

$(RRD_BUILD_DIR): 
	@echo "Extracting $(RRD_SOURCE_ARCHIVE) to build/$(RRD_BUILD_DIR)"
	cd $(BUILD_ROOT) && \
	  gzip -dc ../$(RRD_SOURCE_ARCHIVE) | tar xvf -

compile: configure
	cd $(RRD_BUILD_DIR) && make

configure: $(RRD_BUILD_DIR)/makefile

$(RRD_BUILD_DIR)/makefile:
	cd $(RRD_BUILD_DIR) && ./configure $(RRD_CONFIG_OPTS)
	files/fixlibtool.sh $(RRD_BUILD_DIR)

install: compile
	cd ${RRD_BUILD_DIR} && make install

clean:: 
	rm -rf $(RRD_BUILD_DIR)

#clean:: 
#	rm -f patch-makefile.pl.state

.DUMMY:
	true
