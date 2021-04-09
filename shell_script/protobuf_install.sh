#!/usr/bin/env bash

set -x
set -e

dirname=~/programe/protobuf
if [ ! -d $dirname  ];then
  mkdir -vp $dirname
else
  echo $dirname exist
fi

cd $dirname

# sudo apt install autoconf automake libtool curl make g++ unzip -y

# git clone https://github.com/google/protobuf.git


# sudo dd if=/dev/zero of=/swapfile bs=1M count=2048

# sudo mkswap /swapfile

# sudo swapon /swapfile 

./autogen.sh
./configure
make
sudo make install
sudo ldconfig # refresh shared library cache.

go get google.golang.org/protobuf/cmd/protoc-gen-go \
         google.golang.org/grpc/cmd/protoc-gen-go-grpc


protoc --version