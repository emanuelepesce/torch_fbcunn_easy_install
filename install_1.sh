#!/bin/bash -e
#
#	Script (first part) for installing torch with fbcunn libraries  
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

##### create installation folder
mkdir $dir

##### Installing torch
cd $dir
echo Installing Torch
git clone https://github.com/torch/distro.git $dir --recursive
cd $dir 
bash install-deps
./install.sh

source $HOME/.bashrc