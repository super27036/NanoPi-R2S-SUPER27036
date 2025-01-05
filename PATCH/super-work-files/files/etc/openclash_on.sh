#!/bin/bash
uci set openclash.config.enable='1'
uci commit openclash
/etc/init.d/openclash start
