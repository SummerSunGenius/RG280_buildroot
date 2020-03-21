################################################################################
#
# tiff
#
################################################################################

TIFF_VERSION = 4.1.0
TIFF_SITE = http://download.osgeo.org/libtiff
TIFF_LICENSE = tiff license
TIFF_LICENSE_FILES = COPYRIGHT
TIFF_INSTALL_STAGING = YES
TIFF_CONF_OPT = \
	--disable-cxx \
	--without-x

TIFF_DEPENDENCIES = host-pkgconf

HOST_TIFF_CONF_OPT = \
	--disable-cxx \
	--without-x \
	--disable-zlib \
	--disable-lzma \
	--disable-jpeg
HOST_TIFF_DEPENDENCIES = host-pkgconf

ifneq ($(BR2_PACKAGE_TIFF_CCITT),y)
TIFF_CONF_OPT += --disable-ccitt
endif

ifneq ($(BR2_PACKAGE_TIFF_PACKBITS),y)
TIFF_CONF_OPT += --disable-packbits
endif

ifneq ($(BR2_PACKAGE_TIFF_LZW),y)
TIFF_CONF_OPT += --disable-lzw
endif

ifneq ($(BR2_PACKAGE_TIFF_THUNDER),y)
TIFF_CONF_OPT += --disable-thunder
endif

ifneq ($(BR2_PACKAGE_TIFF_NEXT),y)
TIFF_CONF_OPT += --disable-next
endif

ifneq ($(BR2_PACKAGE_TIFF_LOGLUV),y)
TIFF_CONF_OPT += --disable-logluv
endif

ifneq ($(BR2_PACKAGE_TIFF_MDI),y)
TIFF_CONF_OPT += --disable-mdi
endif

ifneq ($(BR2_PACKAGE_TIFF_ZLIB),y)
TIFF_CONF_OPT += --disable-zlib
else
TIFF_DEPENDENCIES += zlib
endif

ifneq ($(BR2_PACKAGE_TIFF_XZ),y)
TIFF_CONF_OPT += --disable-lzma
else
TIFF_DEPENDENCIES += xz
endif

ifneq ($(BR2_PACKAGE_TIFF_PIXARLOG),y)
TIFF_CONF_OPT += --disable-pixarlog
endif

ifneq ($(BR2_PACKAGE_TIFF_JPEG),y)
TIFF_CONF_OPT += --disable-jpeg
else
TIFF_DEPENDENCIES += jpeg
endif

ifneq ($(BR2_PACKAGE_TIFF_OLD_JPEG),y)
TIFF_CONF_OPT += --disable-old-jpeg
endif

ifneq ($(BR2_PACKAGE_TIFF_JBIG),y)
TIFF_CONF_OPT += --disable-jbig
endif

TIFF_SUBDIRS = port libtiff
ifeq ($(BR2_PACKAGE_TIFF_UTILITIES),y)
TIFF_SUBDIRS += tools
endif

TIFF_MAKE = $(MAKE) SUBDIRS="$(TIFF_SUBDIRS)"

$(eval $(autotools-package))
$(eval $(host-autotools-package))
