# Copyright (C) 2020-2022 Hyy2001X <https://github.com/Hyy2001X>

include $(TOPDIR)/rules.mk

PKG_NAME:=natter
PKG_VERSION=1.0
PKG_RELEASE:=$(AUTORELEASE)
PKG_SOURCE_VERSION:=384cea0e84cb37c7d6d1d7f57e4f0c885b7888de

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/MikeWang000000/Natter/tar.gz/$(PKG_SOURCE_VERSION)?
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Open TCP Port under FullCone NAT (NAT 1)
	URL:=https://github.com/MikeWang000000/Natter
	DEPENDS:=+python3 +iptables-mod-fullconenat
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	tar -zxvf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Natter-$(PKG_SOURCE_VERSION)/natter.py $(1)/usr/share/$(PKG_NAME)/natter.py
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
