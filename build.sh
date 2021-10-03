#!/bin/bash
mkdir install
export INSTALL_PATH=$PWD/install
export TARGET=x86_64-w64-mingw32
export BUILDDIR=$PWD/mingw64-cross
export GCC_VERSION=11.2.0
export MINGW_VERSION=9.0.0
sudo apt-get -qq update
sudo apt-get -y -qq install tree wget git make rsync tar libtool python texinfo pkg-config doxygen pandoc gettext \
  flex autopoint autoconf automake valgrind

wget -q https://ftp.gnu.org/gnu/gcc/gcc-11.2.0/gcc-$GCC_VERSION.tar.gz
wget https://udomain.dl.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v$MINGW_VERSION.zip
wget https://www.mpfr.org/mpfr-4.1.0/mpfr-4.1.0.tar.gz
wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz
wget https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.gz

#-----------------------------------------------------------------------------------------------------------------------
#build libhsts
cd "$PWD_WORK_PATH" && wget https://gitlab.com/rockdaboot/libhsts/-/archive/master/libhsts-master.tar.gz &&
  tar -xf libhsts-master.tar.gz && cd libhsts-master && autoreconf -fi && ./configure
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#install mingw-w64
sudo apt-get -y -qq install mingw-w64 m4

#-----------------------------------------------------------------------------------------------------------------------
#build gmp
cd "$PWD_WORK_PATH" && wget https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz && tar -xf gmp-6.2.1.tar.xz && cd gmp-6.2.1 &&
  ./configure \
    --host=$TARGET \
    --disable-shared \
    --prefix="$INSTALL_PATH"
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build nettle
cd "$PWD_WORK_PATH" && wget https://ftp.gnu.org/gnu/nettle/nettle-3.7.3.tar.gz && tar -xf nettle-3.7.3.tar.gz
cd nettle-3.7.3
bash .bootstrap
CFLAGS="-I$INSTALL_PATH/include" \
  LDFLAGS="-L$INSTALL_PATH/lib" \
  ./configure \
  --host=$TARGET \
  --enable-shared \
  --disable-documentation \
  --prefix="$INSTALL_PATH"
make clean
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build tasn
cd "$PWD_WORK_PATH" && wget https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.17.0.tar.gz && tar -xf libtasn1-4.17.0.tar.gz
cd libtasn1-4.17.0
./configure \
  --host=$TARGET \
  --disable-shared \
  --disable-doc \
  --prefix=$INSTALL_PATH
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build libidn2
cd "$PWD_WORK_PATH" && wget https://ftp.gnu.org/gnu/libidn/libidn2-2.3.2.tar.gz && tar -xf libidn2-2.3.2.tar.gz
cd libidn2-2.3.2
./bootstrap
./configure \
  --host=$TARGET \
  --enable-shared \
  --disable-doc \
  --prefix=$INSTALL_PATH
make clean
make -j$(nproc)
sudo make install

#-----------------------------------------------------------------------------------------------------------------------
#build libunistring
cd "$PWD_WORK_PATH" && wget https://ftp.gnu.org/gnu/libunistring/libunistring-0.9.10.tar.gz && tar -xf libunistring-0.9.10.tar.gz
cd libunistring-0.9.10
./autogen.sh
./configure \
  --host=$TARGET \
  --enable-shared \
  --prefix=$INSTALL_PATH
make clean
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build gnutls
cd "$PWD_WORK_PATH" && wget https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.2.tar.xz && tar -xf gnutls-3.7.2.tar.xz
cd gnutls-3.7.2
./bootstrap
PKG_CONFIG_PATH="$INSTALL_PATH/lib/pkgconfig" \
  CFLAGS="-I$INSTALL_PATH/include" \
  LDFLAGS="-L$INSTALL_PATH/lib" \
  GMP_LIBS="-L$INSTALL_PATH/lib -lgmp" \
  NETTLE_LIBS="-L$INSTALL_PATH/lib -lnettle -lgmp" \
  HOGWEED_LIBS="-L$INSTALL_PATH/lib -lhogweed -lnettle -lgmp" \
  LIBTASN1_LIBS="-L$INSTALL_PATH/lib -ltasn1" \
  LIBIDN2_LIBS="-L$INSTALL_PATH/lib -lidn2" \
  GMP_CFLAGS=$CFLAGS \
  LIBTASN1_CFLAGS=$CFLAGS \
  NETTLE_CFLAGS=$CFLAGS \
  HOGWEED_CFLAGS=$CFLAGS \
  LIBIDN2_CFLAGS=$CFLAGS \
  ./configure \
  --host=$TARGET \
  --prefix=$INSTALL_PATH \
  --with-included-unistring \
  --disable-openssl-compatibility \
  --without-p11-kit \
  --disable-tests \
  --disable-doc \
  --enable-shared \
  --enable-static \
  --disable-maintainer-mode \
  --disable-libdane \
  --disable-hardware-acceleration \
  --disable-guile
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build c-ares
cd "$PWD_WORK_PATH" && wget https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.17.2.tar.gz && tar -xf c-ares-1.17.2.tar.gz
cd c-ares-1.17.2
CPPFLAGS="-DCARES_STATICLIB=1" \
  ./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --disable-tests \
  --disable-debug
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build libiconv
cd "$PWD_WORK_PATH" && wget https://ftp.gnu.org/gnu/libiconv/libiconv-1.16.tar.gz && tar -xf libiconv-1.16.tar.gz
cd libiconv-1.16
./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build libpsl
cd "$PWD_WORK_PATH" && wget https://github.com/rockdaboot/libpsl/releases/download/0.21.1/libpsl-0.21.1.tar.gz && tar -xf libpsl-0.21.1.tar.gz
cd libpsl-0.21.1
./autogen.sh
CFLAGS="-I$INSTALL_PATH/include" \
  LIBS="-L$INSTALL_PATH/lib -lunistring -lidn2" \
  LIBIDN2_CFLAGS="-I$INSTALL_PATH/include" \
  LIBIDN2_LIBS="-L$INSTALL_PATH/lib -lunistring -lidn2" \
  ./configure \
  --host=$TARGET \
  --enable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --disable-gtk-doc \
  --enable-builtin=libidn2 \
  --enable-runtime=libidn2 \
  --with-libiconv-prefix=$INSTALL_PATH
make clean
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build pcre2
cd "$PWD_WORK_PATH" && wget https://ftp.pcre.org/pub/pcre/pcre2-10.37.tar.gz && tar -xf pcre2-10.37.tar.gz
cd pcre2-10.37
./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build libgpg-error
cd "$PWD_WORK_PATH" && wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.42.tar.gz && tar -xf libgpg-error-1.42.tar.gz
cd libgpg-error-1.42
./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --disable-doc
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build libassuan-2.5.5
cd "$PWD_WORK_PATH" && wget https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2 && tar -xf libassuan-2.5.5.tar.bz2
cd libassuan-2.5.5
./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --disable-doc \
  --with-libgpg-error-prefix=$INSTALL_PATH
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build gpgme
cd "$PWD_WORK_PATH" && wget https://gnupg.org/ftp/gcrypt/gpgme/gpgme-1.16.0.tar.bz2 && tar -xf gpgme-1.16.0.tar.bz2
cd gpgme-1.16.0
./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --with-libgpg-error-prefix=$INSTALL_PATH \
  --disable-gpg-test \
  --disable-g13-test \
  --disable-gpgsm-test \
  --disable-gpgconf-test \
  --disable-glibtest \
  --with-libassuan-prefix=$INSTALL_PATH
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build expat
cd "$PWD_WORK_PATH" && wget https://github.com/libexpat/libexpat/releases/download/R_2_4_1/expat-2.4.1.tar.gz && tar -xf expat-2.4.1.tar.gz
cd expat-2.4.1
./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --without-docbook \
  --without-tests \
  --with-libgpg-error-prefix=$INSTALL_PATH
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build libmetalink
cd "$PWD_WORK_PATH" && wget https://github.com/metalink-dev/libmetalink/releases/download/release-0.1.3/libmetalink-0.1.3.tar.gz && tar -xf libmetalink-0.1.3.tar.gz
cd libmetalink-0.1.3
EXPAT_CFLAGS="-I$INSTALL_PATH/include" \
  EXPAT_LIBS="-L$INSTALL_PATH/lib -lexpat" \
  ./configure \
  --host=$TARGET \
  --disable-shared \
  --prefix=$INSTALL_PATH \
  --enable-static \
  --with-libgpg-error-prefix=$INSTALL_PATH \
  --with-libexpat
make -j$(nproc)
make install

#-----------------------------------------------------------------------------------------------------------------------
#build zlib
cd "$PWD_WORK_PATH" && wget https://zlib.net/zlib-1.2.11.tar.gz && tar -xf zlib-1.2.11.tar.gz
cd zlib-1.2.11
CC=x86_64-w64-mingw32-gcc ./configure --64 --static --prefix=$INSTALL_PATH
make -j$(nproc)
make install

# build wget2
cd "$PWD_WORK_PATH" && wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz && tar -xf wget2-latest.tar.gz
# && ./configure && make && sudo make install
cd wget2-2.0.0
# CC=x86_64-w64-mingw32-gcc CFLAGS="-I$INSTALL_PATH/include -DGNUTLS_INTERNAL_BUILD=1 -DCARES_STATICLIB=1 -DPCRE2_STATIC=1 -DNDEBUG -O2 -march=x86-64 -mtune=generic" \
#   LDFLAGS="-L$INSTALL_PATH/lib -static -static-libgcc" \
#   GNUTLS_CFLAGS=$CFLAGS \
#   GNUTLS_LIBS="-L$INSTALL_PATH/lib -lgnutls" \
#   LIBPSL_CFLAGS=$CFLAGS \
#   LIBPSL_LIBS="-L$INSTALL_PATH/lib -lpsl" \
#   CARES_CFLAGS=$CFLAGS \
#   CARES_LIBS="-L$INSTALL_PATH/lib -lcares" \
#   PCRE2_CFLAGS=$CFLAGS \
#   PCRE2_LIBS="-L$INSTALL_PATH/lib -lpcre2-8" \
#   METALINK_CFLAGS="-I$INSTALL_PATH/include" \
#   METALINK_LIBS="-L$INSTALL_PATH/lib -lmetalink -lexpat" \
#   LIBS="-L$INSTALL_PATH/lib -lhogweed -lnettle -lgmp -ltasn1 -lidn2 -lpsl -lcares -lunistring -liconv -lpcre2-8 -lmetalink -lexpat -lgpgme -lassuan -lgpg-error -lz -lcrypt32" \
#   ./configure \
#   --host=$TARGET \
#   --enable-cross-guesses=conservative \
#   --prefix=$INSTALL_PATH \
#   --disable-valgrind-tests \
#   --with-ssl=gnutls \
#   --enable-threads=posix \
#   --with-gpgme-prefix=$INSTALL_PATH
# make
# sudo make install
# mkdir -p $INSTALL_PATH/wget-gnutls
# ls $INSTALL_PATH/
# cd $INSTALL_PATH
# tree
#cp $INSTALL_PATH/bin/wget2.exe $INSTALL_PATH/wget-gnutls
#x86_64-w64-mingw32-strip $INSTALL_PATH/wget-gnutls/wget2.exe

# CFLAGS="-I$INSTALL_PATH/include -DGNUTLS_INTERNAL_BUILD=1 -DPCRE2_STATIC=1 -DNDEBUG -O2 -march=x86-64 -mtune=generic" \
#   LDFLAGS="-L$INSTALL_PATH/lib -static -static-libgcc" \
#   GNUTLS_CFLAGS=$CFLAGS \
#   GNUTLS_LIBS="-L$INSTALL_PATH/lib -lgnutls" \
#   LIBPSL_CFLAGS=$CFLAGS \
#   LIBPSL_LIBS="-L$INSTALL_PATH/lib -lpsl" \
#   PCRE2_CFLAGS=$CFLAGS \
#   PCRE2_LIBS="-L$INSTALL_PATH/lib -lpcre2-8" \
#   METALINK_CFLAGS="-I$INSTALL_PATH/include" \
#   METALINK_LIBS="-L$INSTALL_PATH/lib -lmetalink -lexpat" \
#   LIBS="-L$INSTALL_PATH/lib -lhogweed -lnettle -lgmp -ltasn1 -lidn2 -lpsl -lunistring -liconv -lpcre2-8 -lmetalink -lexpat -lgpgme -lassuan -lgpg-error -lz -lcrypt32" \
#   ./configure \
#   --host=$TARGET \
#   --enable-cross-guesses=conservative \
#   --prefix=$INSTALL_PATH \
#   --with-ssl=gnutls \
#   --enable-threads=posix \
#   --with-gpgme-prefix=$INSTALL_PATH

CFLAGS="-I$INSTALL_PATH/include -DGNUTLS_INTERNAL_BUILD=1 -DCARES_STATICLIB=1 -DPCRE2_STATIC=1 -DNDEBUG -g -O2 -march=x86-64 -mtune=generic" \
  LDFLAGS="-I$INSTALL_PATH/include -L$INSTALL_PATH/lib -static -static-libgcc" \
  LIBS="-L$INSTALL_PATH/lib -lnettle -lgmp -lidn2 -lz -ltasn1 -liconv -lpsl -lgpgme -lassuan -lgpg-error -lpcre2-8 -lmetalink -lexpat -lhogweed -lunistring" \
  CPPFLAGS=$CFLAGS \
  PKG_CONFIG_PATH=$INSTALL_PATH/lib/pkgconfig \
  GNUTLS_CFLAGS=$CFLAGS \
  GNUTLS_LIBS="-L $INSTALL_PATH/lib -lgnutls" \
  NETTLE_CFLAGS=$CFLAGS \
  NETTLE_LIBS="-L $INSTALL_PATH/lib -lnettle" \
  LIBPSL_CFLAGS=$CFLAGS \
  LIBPSL_LIBS="-L $INSTALL_PATH/lib -lpsl" \
  GPGME_CFLAGS=$CFLAGS \
  GPGME_LIBS="-L $INSTALL_PATH/lib -lgpgme" \
  ZLIB_CFLAGS=$CFLAGS \
  ZLIB_LIBS="-L $INSTALL_PATH/lib -lz" \
  LIBIDN2_CFLAGS=$CFLAGS \
  LIBIDN2_LIBS="-L $INSTALL_PATH/lib -lidn2" \
  LIBPCRE2_CFLAGS=$CFLAGS \
  LIBPCRE2_LIBS="-L $INSTALL_PATH/lib -lpcre2-8" \
  ./configure \
  --host=$TARGET \
  --prefix=$INSTALL_PATH \
  --disable-shared \
  --with-libiconv-prefix=$INSTALL_PATH \
  --with-gpgme-prefix=$INSTALL_PATH \
  --disable-doc
make -j$(nproc)
make install
cd $INSTALL_PATH
tree
#export CFLAGS="$INSTALL_PATH/include"
#-I/usr/x86_64-w64-mingw32/include