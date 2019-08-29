#!/bin/bash

if [ -n "$MACOSX_DEPLOYMENT_TARGET" ]; then
    # darwin/jni_*.h headers aren't found
    export CFLAGS="$CFLAGS -I$PREFIX/include/darwin"
fi

# 5.3 Only works with JDK 7
# http://lists.linuxfromscratch.org/pipermail/blfs-dev/2015-May/030132.html
cd build_unix
../dist/configure --prefix=$PREFIX \
                  --enable-java \
                  --enable-shared \
                  --disable-static \
                  --enable-cxx \
                  JAVACFLAGS='-source 1.7 -target 1.7'

make -j$CPU_COUNT
make check -j$CPU_COUNT
make install -j$CPU_COUNT

cd $PREFIX
find . -type f -name "*.la" -exec rm -rf '{}' \; -print
