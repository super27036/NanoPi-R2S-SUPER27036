#这个脚本是额外添加一些应用，分别保存到新创建的luci和package里面，然后将feeds.conf.default里面含luci和package的两行都替换到这两个新建的源。
#feeds.conf.default 这个文件夹在这里： https://github.com/DHDAXCW/lede-rockchip/blob/stable/feeds.conf.default
#注意的是，feeds.conf.default里面的luci和package已经在上一步执行了
#!/bin/bash

# Svn checkout packages from immortalwrt's repository
pushd customfeeds

# Add luci-app-passwall
#git clone https://github.com/xiaorouji/openwrt-passwall luci/applications/passwall #这里特意要把它的保存地址放在luci下面，和下面Set to local feeds的命令相呼应
#git clone https://github.com/xiaorouji/openwrt-passwall2 luci/applications/passwall2 #这里特意要把它的保存地址放在luci下面，和下面Set to local feeds的命令相呼应
#git clone https://github.com/xiaorouji/openwrt-passwall-packages packages/passwall-packages #这里特意要把它的保存地址放在packages下面，和下面Set to local feeds的命令相呼应

# Add luci-app-eqos
# svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-eqos luci/applications/luci-app-eqos

# Add luci-proto-modemmanager
# svn co https://github.com/immortalwrt/luci/trunk/protocols/luci-proto-modemmanager luci/protocols/luci-proto-modemmanager

# Add luci-app-gowebdav
# svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-gowebdav luci/applications/luci-app-gowebdav
# svn co https://github.com/immortalwrt/packages/trunk/net/gowebdav packages/net/gowebdav

# Add tmate
# git clone --depth=1 https://github.com/immortalwrt/openwrt-tmate

# Add gotop
# svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/admin/gotop packages/admin/gotop

# Add minieap
# svn co https://github.com/immortalwrt/packages/trunk/net/minieap packages/net/minieap

# Replace smartdns with the official version
# rm -rf packages/net/smartdns
# svn co https://github.com/openwrt/packages/trunk/net/smartdns packages/net/smartdns
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
