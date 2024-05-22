#!/bin/sh
set -e

# Build and install libtacplus-map dependency
git clone https://github.com/vyos/libtacplus-map.git
cd libtacplus-map
git reset --hard fe47203
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"
# Make it buildable for newer gcc version:
# https://stackoverflow.com/questions/47185819/building-debian-ubuntu-packages-with-old-gcc-cflag-adjustment
# map_tacplus_user.c:388:31: error: the comparison will always evaluate as 'true' for the address of 'tac_mappedname' will never be NULL [-Werror=address]
# man 1 dpkg-buildflags
export DEB_CFLAGS_APPEND="-Wno-address -Wno-stringop-truncation"
dpkg-buildpackage -uc -us -tc -b
cd ../

sudo dpkg -i *.deb

# Build and install libpam-tacplus dependency
git clone https://github.com/vyos/libpam-tacplus.git
cd libpam-tacplus
git reset --hard 0d38f9b
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"
dpkg-buildpackage -uc -us -tc -b
cd ../

sudo dpkg -i *.deb

# Finally build libnss-tacplus
git clone https://github.com/vyos/libnss-tacplus.git
cd libnss-tacplus
git reset --hard 049d284
sudo mk-build-deps --install --tool "apt-get --yes --no-install-recommends"
dpkg-buildpackage -uc -us -tc -b
