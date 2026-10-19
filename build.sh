#!/bin/bash
# Makes the two zips from package/ (rebuild package/TailSizeFix/TailSizeFix.pck first with pack.gd, see the README):
#   out/TailSizeFix-mod.zip         the TailSizeFix folder to drop into GDWeave/mods
#   out/TailSizeFix-<version>.zip   the Thunderstore upload
set -e
cd "$(dirname "$0")"
mkdir -p out
V=$(python3 -c "import json;print(json.load(open('thunderstore/manifest.json'))['version_number'])")
rm -f out/TailSizeFix-mod.zip out/TailSizeFix-$V.zip
(cd package && zip -qr ../out/TailSizeFix-mod.zip TailSizeFix)
T=$(mktemp -d)
cp thunderstore/manifest.json thunderstore/README.md thunderstore/CHANGELOG.md thunderstore/icon.png $T/
cp LICENSE $T/
mkdir -p $T/GDWeave/mods/TailSizeFix
cp package/TailSizeFix/manifest.json package/TailSizeFix/TailSizeFix.pck $T/GDWeave/mods/TailSizeFix/
(cd $T && zip -qr - .) > out/TailSizeFix-$V.zip
rm -rf $T
echo "out/TailSizeFix-mod.zip"
echo "out/TailSizeFix-$V.zip"
