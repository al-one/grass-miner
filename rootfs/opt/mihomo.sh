#!/bin/bash

set -ex

if [ -z "$MIHOMO_CONFIG" ]; then
  echo "mihomo config not set ..."
  sleep infinity
  exit 1
fi

curl -L --noproxy "*" "$MIHOMO_CONFIG" -o /root/.config/mihomo/config.yaml
mihomo -ext-ctl "0.0.0.0:9090"