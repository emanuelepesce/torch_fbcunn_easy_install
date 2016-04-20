#!/bin/bash -e
#
#	Script (second part) for installing torch with fbcunn libraries  
#	
#	Assume that cuda7.5 and libboost1.55 are already installed on the machine 
#
#  	Authors: Emanuele Pesce, Nicolo' Savioli
# 
#	Last edit: 19/04/2016

##### settings
set -e
set -x

extra_packages=libiberty-dev # because ubuntu 14.04

##### set directories
launch_path=$PWD	# where this script is launched
dir=$HOME/torch 	# where torch will be installed

echo Installing Torch libraries
luarocks install image
luarocks install nn
luarocks install cudnn


##### Install torch dependencies
curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash -e


##### Install other dependencies
sudo apt-get install -y \
    git \
    curl \
    wget \
    g++ \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    $extra_packages \
    flex \
    bison \
    libkrb5-dev \
    libsasl2-dev \
    libnuma-dev \
    pkg-config \
    libssl-dev \
    libedit-dev \
    libmatio-dev \
    libpython-dev \
    libpython3-dev \
	python-numpy \
    libelf-dev \
    libdwarf-dev \
	libiberty-dev

    # libboost-all-dev \
    # libunwind8-dev


##### Install Folly
echo
echo Installing Folly
echo

cd $dir
git clone -b v0.35.0  --depth 1 https://github.com/facebook/folly.git
cp -R $launch_path/gtest-1.7.0 $dir/folly/folly/test
cd $dir/folly/folly/
autoreconf -ivf
./configure
make
make check
sudo make install
sudo ldconfig # reload the lib paths after freshly installed folly. fbthrift needs it.


##### Install fbthrift
echo
echo Installing fbthrift
echo

cd $dir
git clone -b v0.24.0  --depth 1 https://github.com/facebook/fbthrift.git
cd $dir/fbthrift/thrift
autoreconf -ivf
./configure
make
sudo make install


##### Install thpp
echo
echo Installing thpp
echo

cp -r $launch_path/thpp-1.0 $dir/thpp
cp -r $launch_path/gtest-1.7.0 $dir/thpp/thpp
cd $dir/thpp/thpp
cmake .
make 
sudo make install


#### fblualib
cp -r $launch_path/fblualib-1.0 $dir/fblualib
cd $dir/fblualib/fblualib
./build.sh


#### Install fbcunn
echo
echo Installing fbcunn
echo

cd $dir

git clone https://github.com/torch/nn && ( cd nn && git checkout getParamsByDevice && luarocks make rocks/nn-scm-1.rockspec )
git clone https://github.com/facebook/fbtorch.git && ( cd fbtorch && luarocks make rocks/fbtorch-scm-1.rockspec )
git clone https://github.com/facebook/fbnn.git && ( cd fbnn && luarocks make rocks/fbnn-scm-1.rockspec )
git clone https://github.com/facebook/fbcunn.git && ( cd fbcunn && luarocks make rocks/fbcunn-scm-1.rockspec )

##### bug fixing
luarocks install nn

cp $launch_path/Optim.lua $dir/install/share/lua/5.1/fbnn

##### test
th test_multiple_gpu.lua

echo 
echo Installation Complete.
