# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
sed -i 's/OpenWrt/SUPERouter/g' package/base-files/files/bin/config_generate

# Password change
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/$1$S2TRFyMU$E8fE0RRKR0jNadn3YLrSQ0:18690:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

# Disable IPv6
sed -i 's/def_bool y/def_bool n/g' config/Config-build.in

# Modify zzz-default-settings
#!/bin/bash

# 切换到目标目录
if ! pushd package/lean/default-settings/files &>/dev/null; then
    echo "Error: Directory package/lean/default-settings/files not found."
    exit 1
fi

# 确保在脚本退出时返回原路径
trap 'popd' EXIT

# 检查 zzz-default-settings 文件是否存在
if [ ! -f "zzz-default-settings" ]; then
    echo "Error: zzz-default-settings not found in $(pwd)."
    exit 1
fi

# 删除包含 'http' 和 '18.06' 的行
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings

# 获取原始版本信息
export orig_version=$(grep DISTRIB_REVISION= "zzz-default-settings" | awk -F "'" '{print $2}')
if [ -z "$orig_version" ]; then
    echo "Error: DISTRIB_REVISION not found in zzz-default-settings."
    exit 1
fi

# 检查 rdate 命令是否存在
if ! command -v rdate &>/dev/null; then
    echo "Warning: rdate not found. Using local date."
    export date_version=$(date +'%Y-%m-%d')
else
    export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
fi

# 替换版本信息
sed -i "s/${orig_version}/SUPER-DHDAXCW ${orig_version} (${date_version})/g" zzz-default-settings

echo "Modification completed successfully!"
