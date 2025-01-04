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
sed -i '/http/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/18.06/d' package/lean/default-settings/files/zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -d "$(rdate -n -4 -p ntp.aliyun.com)" +'%Y-%m-%d')
sed -i "s/${orig_version}/SUPER-DHDAXCW ${orig_version} (${date_version})/g" zzz-default-settings
