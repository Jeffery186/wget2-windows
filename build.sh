#!/bin/bash
sudo apt-get -qq update
sudo apt-get -y -qq install wget git tar autotools-dev rsync tar texinfo pkg-config doxygen pandoc gettext libiconv-hook-dev \
 libiconv-hook1 zlib1g liblzma5 libbz2-1.0 libbrotli1 brotli libbrotli-dev libzstd1 libgnutls28-dev libidn2-0 flex libpsl5 libnghttp2-14 \
 libmicrohttpd12 lzip clzip libgpgme-dev lcov libgpgme11 libpcre2-32-0 autopoint libzstd-dev libpsl-dev libnghttp2-dev

# build libhsts
wget https://gitlab.com/rockdaboot/libhsts/-/archive/master/libhsts-master.tar.gz && tar -xzf libhsts-master.tar.gz && cd libhsts-master && autoreconf -fi && ./configure && make && make check && sudo make install && cd ..

# build wget2
wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz
tar -xzf wget2-latest.tar.gz && cd wget2-2.0.0 && ./configure && make && make check && sudo make install && cd ..

sudo apt-get -y -qq install mingw-w64 mingw-w64-i686-dev mingw-w64-tools
sudo apt-get -y -qq install make m4 automake