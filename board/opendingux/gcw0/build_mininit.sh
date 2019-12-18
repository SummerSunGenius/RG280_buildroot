#!/usr/bin/env bash

set -euo pipefail

BUILD_DIR=/tmp/_opendingux_mininit_build_

set -x

rm -rf "$BUILD_DIR"
git clone --depth 1 https://github.com/OpenDingux/mininit.git "$BUILD_DIR"
make -C "$BUILD_DIR" CC="${PWD}/output/host/usr/bin/mipsel-linux-gcc"
cp "${BUILD_DIR}/mininit-syspart" output/images/mininit-syspart
sha1sum -b output/images/mininit-syspart | cut -d' ' -f1 > output/images/mininit-syspart.sha1
rm -rf "$BUILD_DIR"
