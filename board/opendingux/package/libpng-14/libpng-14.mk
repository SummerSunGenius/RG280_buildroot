################################################################################
#
# libpng 1.4 - older version, provided for backwards binary compatibility
#
################################################################################

LIBPNG_14_VERSION = 1.4.13
LIBPNG_14_SERIES = 14
LIBPNG_14_SOURCE = libpng-$(LIBPNG_14_VERSION).tar.bz2
LIBPNG_14_SITE = http://downloads.sourceforge.net/project/libpng/libpng${LIBPNG_14_SERIES}/older-releases/$(LIBPNG_14_VERSION)
LIBPNG_14_LICENSE = libpng license
LIBPNG_14_LICENSE_FILES = LICENSE
LIBPNG_14_INSTALL_STAGING = YES
LIBPNG_14_DEPENDENCIES = host-pkgconf zlib
LIBPNG_14_CONFIG_SCRIPTS = libpng$(LIBPNG_14_SERIES)-config libpng-config

# There can be only one version of the static library and we want it to be the newest libjpeg
LIBPNG_14_CONF_OPTS = --disable-static

$(eval $(autotools-package))
$(eval $(host-autotools-package))
