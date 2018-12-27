#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y python3-dev  python-dev zip

#1. Download source from github.
wget https://github.com/ossrs/srs/archive/v2.0-r5.tar.gz
tar -xvf v2.0-r5.tar.gz

#2. Patch a compiler flag in a Makefile in a 3rdparty dependency which is throwing build errors.
cd srs-2.0-r5/trunk/3rdparty/
unzip http-parser-2.1.zip && cd http-parser-2.1/
sed -i '10s/.*/CFLAGS += -Wall/' Makefile
cd ..
rm http-parser-2.1.zip
zip -r http-parser-2.1.zip http-parser-2.1/
cd ..

#3.
./configure --with-http-callback && \
make