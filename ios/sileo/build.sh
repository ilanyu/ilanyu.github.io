#!/usr/bin/env bash
set -euo pipefail

dpkg-scanpackages -m ./debs > Packages
bzip2 -c9 Packages > Packages.bz2
xz -c9 Packages > Packages.xz
gzip -c9 Packages > Packages.gz

cat > Release <<EOF
Origin: yu Repo
Label: yu Repo
Suite: stable
Version: 1.0
Codename: ios
Architectures: iphoneos-arm iphoneos-arm64
Components: main
Description: yu Sileo repository
Date: $(date -Ru)
MD5Sum:
EOF
for f in Packages Packages.bz2 Packages.gz Packages.xz; do
  printf ' %s %s %s\n' "$(md5sum "$f" | awk '{print $1}')" "$(wc -c < "$f" | tr -d ' ')" "$f" >> Release
done
printf 'SHA1:\n' >> Release
for f in Packages Packages.bz2 Packages.gz Packages.xz; do
  printf ' %s %s %s\n' "$(sha1sum "$f" | awk '{print $1}')" "$(wc -c < "$f" | tr -d ' ')" "$f" >> Release
done
printf 'SHA256:\n' >> Release
for f in Packages Packages.bz2 Packages.gz Packages.xz; do
  printf ' %s %s %s\n' "$(sha256sum "$f" | awk '{print $1}')" "$(wc -c < "$f" | tr -d ' ')" "$f" >> Release
done