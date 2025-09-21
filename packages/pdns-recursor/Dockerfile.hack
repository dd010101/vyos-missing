# Fix apt to use archive mirror
RUN sed -i -E 's~^deb http://(deb|security).debian.org~deb http://archive.debian.org~' /etc/apt/sources.list
