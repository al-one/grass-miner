#!/bin/bash

set -ex

if [ -n "$GRASS_PROXY" ]; then
  export http_proxy=http://$GRASS_PROXY
  export https_proxy=http://$GRASS_PROXY
  export all_proxy=socks5://$GRASS_PROXY
  curl -v -o - ip.sb
  curl -v -o - ipinfo.io
fi

grass