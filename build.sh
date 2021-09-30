#!/bin/bash
sudo apt-get -qq update
sudo apt-get -y -qq install autotools-dev rsync tar texinfo pkg-config doxygen pandoc gettext libiconv-hook-dev \
 libiconv-hook1 zlib1g liblzma5 libbz2-1.0 libbrotli1 libzstd1 libgnutls30 libidn2-0 flex libpsl5 libnghttp2-14 \
 libmicrohttpd12 lzip lcov libgpgme11 libpcre2-32-0 libwolfssl24 autopoint libzstd-dev libpsl-dev libnghttp2-dev

# build libhsts
#git clone https://gitlab.com/rockdaboot/libhsts && cd libhsts && autoreconf -fi && ./configure && make && make check && cd ..

# build wget2
wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz
tar -xzf wget2-latest.tar.gz && cd wget2-2.0.0 && ./configure -h && ./configure && make && make check && sudo make install && cd ..

sudo apt-get -y -qq install mingw-w64 mingw-w64-i686-dev mingw-w64-tools
sudo apt-get -y -qq install make m4 automake
