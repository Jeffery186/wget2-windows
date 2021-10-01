#!/bin/bash
mkdir install
export PWD_WORK_PATH=$PWD
export INSTALL_PATH=$PWD/install
sudo apt-get -qq update
sudo apt-get -y -qq install tree wget git tar gcc cmake autotools-dev rsync tar texinfo pkg-config doxygen pandoc gettext \
 libiconv-hook-dev libiconv-hook1 zlib1g liblzma5 libbz2-1.0 libbrotli1 brotli libbrotli-dev libzstd1 libgnutls28-dev \
 libidn2-0 flex libpsl5 libnghttp2-14 libmicrohttpd-dev lzip clzip libgpgme-dev lcov libgpgme11 libpcre2-32-0 autopoint \
 libzstd-dev libpsl-dev libnghttp2-dev

# build libhsts
wget https://gitlab.com/rockdaboot/libhsts/-/archive/master/libhsts-master.tar.gz \
 && tar -xzf libhsts-master.tar.gz && cd libhsts-master && autoreconf -fi \
 && ./configure && make && make check && sudo make install

# build wget2
cd "$PWD_WORK_PATH" && wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz \
 && tar -xzf wget2-latest.tar.gz && cd wget2-2.0.0 && ./configure && make && sudo make install
# && make check

sudo apt-get -y -qq install mingw-w64 mingw-w64-x86-64-dev mingw-w64-i686-dev mingw-w64-tools make m4 automake

cd "$PWD_WORK_PATH" && wget https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz && tar -xf gmp-6.2.1.tar.xz && cd gmp-6.2.1 \
 ./configure \
 --host=x86_64-w64-mingw32 \
 --disable-shared \
 --prefix="$INSTALL_PATH"

cd "$PWD_WORK_PATH" && wget https://ftp.gnu.org/gnu/nettle/nettle-3.7.3.tar.gz && tar -xf nettle-3.7.3.tar.gz && cd nettle-3.7.3 \
 CFLAGS="-I$INSTALL_PATH/include" \
 LDFLAGS="-L$INSTALL_PATH/lib" \
 ./configure \
 --host=x86_64-w64-mingw32 \
 --disable-shared \
 --disable-documentation \
 --prefix=$INSTALL_PATH

cd "$PWD_WORK_PATH/wget2-2.0.0" && ./configure \
 --target=x86_64-w64-mingw32 \
 --host=x86_64-w64-mingw32 \
 --prefix="$INSTALL_PATH"
make
sudo make install
#mkdir $INSTALL_PATH/wget-gnutls
#ls $INSTALL_PATH/
#cp $INSTALL_PATH/bin/wget2.exe $INSTALL_PATH/wget-gnutls
#x86_64-w64-mingw32-strip $INSTALL_PATH/wget-gnutls/wget2.exe