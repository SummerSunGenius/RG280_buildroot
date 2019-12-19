################################################################################
#
# jsoncpp
#
################################################################################

JSONCPP_VERSION = 1.9.2
JSONCPP_SITE = $(call github,open-source-parsers,jsoncpp,$(JSONCPP_VERSION))
JSONCPP_LICENSE = Public Domain or MIT
JSONCPP_LICENSE_FILES = LICENSE
JSONCPP_INSTALL_STAGING = YES

JSONCPP_DEPENDENCIES += host-python

JSONCPP_SO_VERSION = 22

# jsoncpp has cmake and meson builds
# We do not use CMake because jsoncpp is a dependency of CMake.
# We do not use Meson because the old buildroot doesn't support it.
define JSONCPP_CONFIGURE_CMDS
	cd $(@D) && $(HOST_DIR)/usr/bin/python amalgamate.py
endef

define JSONCPP_BUILD_CMDS
	cd $(@D)/dist && $(TARGET_CXX) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS) \
	  -std=c++11 -I. -fPIC -shared -c jsoncpp.cpp -o libjsoncpp.so
endef

define JSONCPP_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/json/
	$(INSTALL) $(@D)/include/json/*.h $(STAGING_DIR)/usr/include/json/
	$(INSTALL) -D $(@D)/dist/libjsoncpp.so $(STAGING_DIR)/usr/lib/libjsoncpp.so.$(JSONCPP_SO_VERSION)
	ln -sf $(STAGING_DIR)/usr/lib/libjsoncpp.so.$(JSONCPP_SO_VERSION) $(STAGING_DIR)/usr/lib/libjsoncpp.so
endef

define JSONCPP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/include/json/
	$(INSTALL) $(@D)/include/json/*.h $(TARGET_DIR)/usr/include/json/
	$(INSTALL) -D $(@D)/dist/libjsoncpp.so $(TARGET_DIR)/usr/lib/libjsoncpp.so.$(JSONCPP_SO_VERSION)
	ln -sf $(TARGET_DIR)/usr/lib/libjsoncpp.so.$(JSONCPP_SO_VERSION) $(TARGET_DIR)/usr/lib/libjsoncpp.so
endef

define HOST_JSONCPP_BUILD_CMDS
	cd $(@D) && $(HOST_DIR)/usr/bin/python amalgamate.py
	cd $(@D)/dist && $(HOSTCXX) $(HOST_CXXFLAGS) $(HOST_LDFLAGS) \
	  -std=c++11 -I. -c jsoncpp.cpp -o libjsoncpp.o
	cd $(@D)/dist && $(HOSTAR) rcs libjsoncpp.a libjsoncpp.o
endef

define HOST_JSONCPP_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/usr/include/json/
	$(INSTALL) $(@D)/include/json/*.h $(HOST_DIR)/usr/include/json/
	$(INSTALL) -D $(@D)/dist/libjsoncpp.a $(HOST_DIR)/usr/lib/libjsoncpp.a
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
