#!/bin/bash
sudo apt-get update
sudo apt-get install -y autotools-dev rsync tar texinfo pkg-config doxygen pandoc gettext libiconv-hook-dev \
 libiconv-hook1 zlib1g liblzma5 libbz2-1.0 libbrotli1 libzstd1 libgnutls30 libidn2-0 flex libpsl5 libnghttp2-14 \
 libmicrohttpd12 lzip lcov libgpgme11 libpcre2-32-0 libwolfssl24

# build libhsts
git clone https://gitlab.com/rockdaboot/libhsts && cd libhsts && autoreconf -fi && ./configure && make && make check && cd ..

# build wget2
wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz
tar -xzvf wget2-latest.tar.gz && cd wget2-2.0.0 && ./configure && make && make check && sudo make install && cd ..

sudo apt-get install -y mingw-w64 mingw-w64-i686-dev mingw-w64-tools
sudo apt-get install -y make m4 automake