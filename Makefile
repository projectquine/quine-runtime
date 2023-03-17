# TERMUX_PREFIX is environment variable, but if it is not set, then set default value
ifeq ($(TERMUX_PREFIX),)
    TERMUX_PREFIX := /data/data/com.termux/files/usr
endif

# if TERMUX_PKG_SRCDIR doesn't exist use pwd
ifeq ($(TERMUX_PKG_SRCDIR),)
    TERMUX_PKG_SRCDIR := $(shell pwd)
endif

install:
    echo "installing first-boot script to /etc/profile.d/"
     install -Dm 777 ${TERMUX_PKG_SRCDIR}/scripts/first-boot.sh ${TERMUX_PREFIX}/etc/profile.d/first-boot.sh