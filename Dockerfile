FROM debian:buster

LABEL maintainer "Tim Rühsen <tim.ruehsen@gmx.de>"

WORKDIR /usr/local

RUN apt-get update && apt-get install --no-install-recommends -y \
	git \
	autoconf \
	autoconf-archive \
	autopoint \
	automake \
	autogen \
	libtool \
	make \
	python \
	wine \
	wine-development \
	flex \
	bison \
	gettext \
	gperf \
	mingw-w64 \
	pkg-config-mingw-w64-x86-64 \
	ca-certificates \
	wget \
	patch \
	texinfo \
	gengetopt \
	curl \
	lzip \
	pandoc \
	rsync \
	ccache \
	libhttp-daemon-perl \
	libio-socket-ssl-perl \
	python3 \
	binfmt-support


ENV PREFIX="x86_64-w64-mingw32"
ENV INSTALLDIR="/usr/local/$PREFIX"
ENV PKG_CONFIG_PATH="$INSTALLDIR/lib/pkgconfig:/usr/$PREFIX/lib/pkgconfig" \
    PKG_CONFIG_LIBDIR="$INSTALLDIR/lib/pkgconfig" \
    PKG_CONFIG="/usr/bin/${PREFIX}-pkg-config" \
    CPPFLAGS="-I$INSTALLDIR/include" \
    LDFLAGS="-L$INSTALLDIR/lib" \
    CFLAGS="-O2 -Wall -Wno-format" \
    WINEPATH="$INSTALLDIR/bin;$INSTALLDIR/lib;/usr/$PREFIX/bin;/usr/$PREFIX/lib"

RUN git clone --recursive https://gitlab.com/gnuwget/gnulib-mirror.git gnulib
ENV GNULIB_SRCDIR /usr/local/gnulib
ENV GNULIB_TOOL /usr/local/gnulib/gnulib-tool

RUN wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz && tar xf libiconv-1.15.tar.gz
RUN cd libiconv-1.15 && \
	./configure --build=x86_64-pc-linux-gnu --host=$PREFIX --enable-shared --prefix=$INSTALLDIR && \
	make -j$(nproc) && make install

RUN git clone https://git.savannah.gnu.org/git/libunistring.git
RUN cd libunistring && \
	./autogen.sh && \
	./configure --build=x86_64-pc-linux-gnu --host=$PREFIX --enable-shared --prefix=$INSTALLDIR && \
	make -j$(nproc) && make install

RUN git clone https://gitlab.com/libidn/libidn2.git
RUN cd libidn2 && \
	./bootstrap && \
	./configure --build=x86_64-pc-linux-gnu --host=$PREFIX --enable-shared --disable-doc --disable-gcc-warnings --prefix=$INSTALLDIR && \
	make -j$(nproc) && make install

RUN git clone https://git.lysator.liu.se/nettle/nettle.git
RUN cd nettle && \
	bash .bootstrap && \
	./configure --build=x86_64-pc-linux-gnu --host=$PREFIX --enable-mini-gmp --enable-shared --disable-documentation --prefix=$INSTALLDIR && \
	make -j$(nproc) && make install

RUN git clone --depth=1 https://gitlab.com/gnutls/gnutls.git
RUN cd gnutls && \
	SKIP_PO=1 ./bootstrap && \
	./configure --build=x86_64-pc-linux-gnu --host=$PREFIX \
		--with-nettle-mini --enable-gcc-warnings --enable-shared --disable-static --with-included-libtasn1 \
		--with-included-unistring --without-p11-kit --disable-doc --disable-tests --disable-tools --disable-cxx \
		--disable-maintainer-mode --disable-libdane --prefix=$INSTALLDIR --disable-hardware-acceleration \
		--disable-full-test-suite && \
	make -j$(nproc) && make install

RUN git clone --depth=1 https://github.com/dlfcn-win32/dlfcn-win32.git
RUN cd dlfcn-win32 && \
	./configure --prefix=$PREFIX --cc=$PREFIX-gcc && \
	make && \
	cp -p libdl.a $INSTALLDIR/lib/ && \
	cp -p src/dlfcn.h $INSTALLDIR/include/

RUN git clone --recursive https://gnunet.org/git/libmicrohttpd.git
RUN cd libmicrohttpd && git checkout `git tag|tail -1` && \
	./bootstrap && \
	./configure --build=x86_64-pc-linux-gnu \
		--host=$PREFIX \
		--prefix=$INSTALLDIR \
		--disable-doc \
		--disable-examples \
		--enable-shared && \
	make -j$(nproc) && make install
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]