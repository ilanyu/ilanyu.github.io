dpkg-scanpackages -m ./debs > Packages

bzip2 -c9 Packages > Packages.bz2
xz -c9 Packages > Packages.xz
gzip -c9 Packages > Packages.gz