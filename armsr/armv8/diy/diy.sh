#!/bin/bash

# Adjust source code
patch -p1 -f < $(dirname "$0")/luci.patch

# Clone packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
git clone https://github.com/sbwml/luci-app-mosdns -b v5 --single-branch --depth=1 clone/mosdns
git clone https://github.com/sbwml/packages_lang_golang -b 26.x --single-branch --depth=1 clone/golang
git clone https://github.com/sbwml/v2ray-geodata --depth=1 clone/v2ray-geodata
git clone https://github.com/Openwrt-Passwall/openwrt-passwall --depth=1 clone/passwall
git clone https://github.com/Zerogiven-OpenWRT-Packages/luci-app-podman --depth=1 feeds/luci/applications/luci-app-podman

# Adjust packages
rm -rf feeds/luci/applications/luci-app-passwall feeds/packages/lang/golang feeds/packages/net/mosdns feeds/packages/net/v2ray-geodata
cp -rf clone/amlogic/luci-app-amlogic clone/mosdns/luci-app-mosdns clone/passwall/luci-app-passwall feeds/luci/applications/
sed -i '/luci-app-attendedsysupgrade/d' feeds/luci/collections/luci/Makefile

# Clean packages
rm -rf clone