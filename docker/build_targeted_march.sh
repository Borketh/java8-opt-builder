#!/bin/bash
make clean
./configure --with-extra-cflags="-march=${1} -O3" --with-extra-cxxflags="-march=${1} -O3" --with-boot-jdk="./zulu7.56.0.11-ca-jdk7.0.352-linux_x64" --with-vendor-name="AshleighHost Custom Build" --with-vendor-url="https://homesrv.ashleighhost.net/jdk" --with-vendor-bug-url="amoore@ashleighhost.net"
make JOBS=14 images
7zz a -ttar ../java-builds/java_8-$1.tar ./build/linux-x86_64-normal-server-release/images/j2sdk-image/*
make clean