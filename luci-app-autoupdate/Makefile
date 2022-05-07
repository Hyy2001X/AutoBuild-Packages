# Copyright (C) 2020-2022 Hyy2001X <https://github.com/Hyy2001X>

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-autoupdate
PKG_VERSION:=2.5
PKG_RELEASE:=4

LUCI_TITLE:=LuCI Support for autoupdate Script
LUCI_DEPENDS:=+bash +jq
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/conffiles
/etc/autoupdate/custom
/etc/autoupdate/default
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
