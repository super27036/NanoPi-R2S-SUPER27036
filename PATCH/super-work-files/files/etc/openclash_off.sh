#!/bin/bash
uci set openclash.config.enable='0'
uci commit openclash
/etc/init.d/openclash stop
echo "$(date): OpenClash 已关闭" >> /var/log/openclash.log
