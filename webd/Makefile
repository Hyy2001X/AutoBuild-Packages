# Copyright (C) 2020-2021 Hyy2001X <https://github.com/Hyy2001X>
# See more information at https://webd.cf/

include $(TOPDIR)/rules.mk

PKG_NAME:=webd
PKG_VERSION:=20220110
PKG_RELEASE:=$(AUTORELESE)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A Lightweight self-hosted netdisk application
	DEPENDS:=@(arm||x86_64||mipsel||mips||aarch64)
	URL:=https://webd.cf/
endef

define Package/$(PKG_NAME)/description
	webd - A Lightweight self-hosted netdisk application [Closed Source]
	Maybe not safe
endef

ifeq ($(ARCH)-$(BOARD),arm-kirkwood)
	TARGET_ARCH:=arm_xscale.kirkwood
endif

ifeq ($(ARCH)-$(BOARD),arm-oxnas)
	TARGET_ARCH:=arm_mpcore.oxnas
endif

ifeq ($(ARCH)-$(CPU_TYPE),mvebu-cortexa9)
	TARGET_ARCH:=arm_cortex-a9.mvebu-cortexa9
endif

ifeq ($(ARCH)-$(BOARD),arm-bcm53xx)
	TARGET_ARCH:=arm_cortex-a9.bcm53xx
endif

ifeq ($(ARCH)-$(BOARD),arm-ipq40xx)
	TARGET_ARCH:=arm_cortex-a7.ipq40xx
endif

ifeq ($(ARCH)-$(BOARD),arm-ipq806x)
	TARGET_ARCH:=arm_cortex-a15.ipq806x
endif

ifeq ($(ARCH),rockchip)
	TARGET_ARCH:=aarch64_generic.rockchip-armv8
endif

ifeq ($(ARCH)-$(BOARD),arm-bcm27xx)
	TARGET_ARCH:=aarch64_cortex-a53.brcm2708-bcm2710
endif

ifeq ($(ARCH)-$(BOARD),mipsel-bcm47xx)
	TARGET_ARCH:=mipsel_74kc.brcm47xx-mips74k
endif

ifeq ($(ARCH),mipsel)
	TARGET_ARCH:=mipsel_24kc.ramips-mt7620
endif

ifeq ($(ARCH),mips)
	TARGET_ARCH:=mips_24kc.ath79
endif

ifeq ($(ARCH),x86_64)
	TARGET_ARCH:=x86-64
endif

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-openwrt-$(TARGET_ARCH).tar.gz
PKG_SOURCE_URL:=https://gwgw.ga/webd/$(PKG_VERSION)/
PKG_HASH:=skip

UNTAR_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

define Build/Prepare
	mkdir -p $(UNTAR_DIR)
	tar -zxvf $(DL_DIR)/$(PKG_SOURCE) -C $(UNTAR_DIR)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(UNTAR_DIR)/webd/webd $(1)/usr/bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
