#!/bin/bash

set -ex

if [ -f "/etc/sing-box/config.json" ]; then
  export http_proxy=http://$GRASS_PROXY
  export https_proxy=http://$GRASS_PROXY
  export all_proxy=socks5://$GRASS_PROXY
  echo $(curl -v api.ipify.org)
  echo $(curl -v ipinfo.io)
fi

grass