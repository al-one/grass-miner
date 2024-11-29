#!/bin/bash

arch=$(uname -m)
if [ "$arch" = "arm64" ] || [ "$arch" = "aarch64" ]; then
  update-binfmts --enable qemu-x86_64
fi

exec "$@"
