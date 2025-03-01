#!/bin/bash
#=================================================
# System Required: Linux (系统要求：Linux)
# Version: 1.0
# License: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================

# Create package/community directory for custom packages (创建 package/community 目录用于存放自定义软件包)
mkdir -p package/community
pushd package/community  # 第一个 pushd：进入 package/community

# Add luci-theme-argon and luci-app-argon-config (添加 luci-theme-argon 和 luci-app-argon-config)
rm -rf ../../customfeeds/luci/themes/luci-theme-argon{,-mod}
rm -rf ../../customfeeds/luci/applications/luci-app-argon-config
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon ../../customfeeds/luci/themes/luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config ../../customfeeds/luci/applications/luci-app-argon-config

# Add luci-app-ssr-plus (添加 luci-app-ssr-plus)
git clone --depth=1 https://github.com/super27036/helloworld

# Add luci-app-vssr and dependencies (添加 luci-app-vssr 及其依赖)
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/super27035/luci-app-vssr

# Add OpenClash (添加 OpenClash)
git clone --depth=1 https://github.com/super27034/OpenClash.git

# Add luci-app-poweroff (添加 luci-app-poweroff)
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# Add luci-app-irqbalance (添加 luci-app-irqbalance)
git clone --depth=1 --filter=blob:none --sparse https://github.com/QiuSimons/OpenWrt-Add.git
pushd OpenWrt-Add  # 第二个 pushd：进入 OpenWrt-Add
git sparse-checkout set luci-app-irqbalance
popd  # 第一个 popd：从 OpenWrt-Add 返回到 package/community

popd  # 第二个 popd：从 package/community 返回到 OpenWrt 根目录

# Change default shell to zsh (更改默认 shell 为 zsh)
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Enable fan control for NanoPi R2S (启用 NanoPi R2S 风扇控制)
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
wget -P target/linux/rockchip/armv8/base-files/etc/init.d/ https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-pwmfan
wget -P target/linux/rockchip/armv8/base-files/usr/bin/ https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/usr/bin/start-rk3328-pwm-fan.sh
chmod +x target/linux/rockchip/armv8/base-files/etc/init.d/fa-rk3328-pwmfan target/linux/rockchip/armv8/base-files/usr/bin/start-rk3328-pwm-fan.sh
