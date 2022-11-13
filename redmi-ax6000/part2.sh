#!/bin/bash

# replace default theme to argon
rm -rf feeds/luci/themes/luci-theme-bootstrap/
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci*/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
