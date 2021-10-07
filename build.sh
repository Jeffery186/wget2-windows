#!/bin/bash
wget https://gnuwget.gitlab.io/wget2/wget2-latest.tar.gz && tar -xf wget2-latest.tar.gz &&
  cd wget2-2.0.0 &&
  ./bootstrap
cp pthread_sigmask.c.mingw lib/pthread_sigmask.c
export GCCLIB=$(dirname $(find /usr/lib/gcc/$PREFIX -name libgcc_s_seh-1.dll | grep posix))
export WINEPATH="$WINEPATH;/usr/$PREFIX/bin;/usr/$PREFIX/lib;$PWD/libwget/.libs;$GCCLIB"
echo "WINEPATH=$WINEPATH"
./configure \
  --build=x86_64-pc-linux-gnu \
  --host=$PREFIX \
  --disable-shared &&
  make -j$(nproc) &&
  make install
pwd
cd /usr/local
tree
