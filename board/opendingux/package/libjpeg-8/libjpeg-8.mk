################################################################################
#
# libjpeg 8 - older version, provided for backwards binary compatibility
#
################################################################################

LIBJPEG_8_VERSION = 8d
LIBJPEG_8_SITE = http://www.ijg.org/files
LIBJPEG_8_SOURCE = jpegsrc.v$(LIBJPEG_8_VERSION).tar.gz
LIBJPEG_8_LICENSE = jpeg-license (BSD-3c-like)
LIBJPEG_8_LICENSE_FILES = README
LIBJPEG_8_INSTALL_STAGING = YES

define LIBJPEG_8_REMOVE_USELESS_TOOLS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
endef

LIBJPEG_8_POST_INSTALL_TARGET_HOOKS += LIBJPEG_8_REMOVE_USELESS_TOOLS

# There can be only one version of the static library and we want it to be the newest libjpeg
LIBJPEG_8_CONF_OPTS = --disable-static

$(eval $(autotools-package))
$(eval $(host-autotools-package))
