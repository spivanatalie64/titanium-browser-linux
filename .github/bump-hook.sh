#!/bin/bash
set -euxo pipefail

PLATFORM_DIR="$PWD"
HELIUM_DIR="$PLATFORM_DIR/titanium-chromium"
SPEC="$PLATFORM_DIR/package/titanium-bin.spec"
METAINFO="$PLATFORM_DIR/package/net.imput.titanium.metainfo.xml"

# version_after is exported by `bump-platform` action
sed -Ei "s/^(%define version ).*/\1$version_after/" "$SPEC"

RELEASE_DATE=$(date +%Y-%m-%d)
sed -Ei 's/(<release version=")(.*)(" date=")(.*)(" \/>)/'"\1$version_after\3$RELEASE_DATE\5/" "$METAINFO"

git add -u "$SPEC" "$METAINFO"
