#!/bin/bash

set -ex

if [ -n "$GRASS_PROXY" ]; then
  export http_proxy=http://$PROXY_ADDR
  export https_proxy=http://$PROXY_ADDR
  export all_proxy=socks5://$PROXY_ADDR
  curl -v ipinfo.io
fi

grass