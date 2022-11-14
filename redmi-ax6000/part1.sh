#!/bin/bash

svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
sed -i 'N;24a\tools-y += ucl upx' tools/Makefile
sed -i 'N;40a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile



#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a
sed -i '$a src-git mosdns https://github.com/sbwml/luci-app-mosdns' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install -a -f -p kenzo
./scripts/feeds install -a -f -p small

./scripts/feeds uninstall luci-app-mosdns mosdns v2ray-geodata luci-app-argon-config luci-theme-argon
./scripts/feeds install -f -p mosdns mosdns luci-app-mosdns
find ./ -name v2ray-geodata | xargs rm -rf
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
svn export https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-vlmcsd package/luci-app-vlmcsd
svn export https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/vlmcsd  package/vlmcsd
svn export https://github.com/sbwml/luci-theme-argon/trunk/luci-theme-argon  package/luci-theme-argon
svn export https://github.com/sbwml/luci-theme-argon/trunk/luci-app-argon-config  package/luci-app-argon-config
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' ./package/*/Makefile
./scripts/feeds update -i && ./scripts/feeds install -a
