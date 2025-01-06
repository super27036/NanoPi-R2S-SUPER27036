#!/bin/bash
uci set openclash.config.enable='0'
uci commit openclash
/etc/init.d/openclash stop
