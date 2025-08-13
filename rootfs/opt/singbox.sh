#!/bin/bash

set -ex

if [ -f "/etc/sing-box/config.json" ]; then
  sing-box -D /var/lib/sing-box -C /etc/sing-box/ run
fi

echo "sing-box config not set ..."
sleep infinity
exit 1