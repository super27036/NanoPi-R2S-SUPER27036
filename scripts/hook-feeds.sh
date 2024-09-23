#!/bin/bash

# Git clone the entire luci repository from immortalwrt to a temporary directory
pushd customfeeds

# Clone luci repository into a temporary directory
mkdir -p tem
git clone https://github.com/immortalwrt/luci tem/luci

# Add luci-app-eqos
mv tem/luci/applications/luci-app-eqos ./luci/applications/

# Add luci-proto-modemmanager
mv tem/luci/protocols/luci-proto-modemmanager ./luci/protocols/

# Add luci-app-gowebdav
mv tem/luci/applications/luci-app-gowebdav ./luci/applications/

# Clean up: remove the temporary luci repository
rm -rf tem

# Add gowebdav package from packages repository
git clone https://github.com/immortalwrt/packages
mv packages/net/gowebdav ./packages/net/

# Add tmate
git clone --depth=1 https://github.com/immortalwrt/openwrt-tmate

# Add gotop
mv packages/admin/gotop ./packages/admin/

# Add minieap
mv packages/net/minieap ./packages/net/

# Replace smartdns with the official version
rm -rf packages/net/smartdns
git clone https://github.com/openwrt/packages
mv packages/net/smartdns ./packages/net/
rm -rf packages  # 删除不必要的部分

popd

# Set to local feeds
pushd customfeeds/packages
export packages_feed="$(pwd)"
popd
pushd customfeeds/luci
export luci_feed="$(pwd)"
popd
sed -i '/src-git packages/d' feeds.conf.default
echo "src-link packages $packages_feed" >> feeds.conf.default
sed -i '/src-git luci/d' feeds.conf.default
echo "src-link luci $luci_feed" >> feeds.conf.default

# Update feeds
./scripts/feeds update -a
