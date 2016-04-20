## Description
Complete installation of torch + fbcunn libraries. 

## Installation

Prerequisites:

* Ubuntu 14.04
* libboost1.55, cuda7.5 and CuDNN(v4) already installed


Into the directory `torch_fbcunn_easy_install` launch:
``` 
./install_1.sh
./install_2.sh
```
This will install torch and fbcunn libraries with all needed dependencies and then it will test if the installation was successful running a test script.


## Prerequisites

**libboost1.55**

```
sudo apt-get install libboost1.55-all-dev
```

**CUDA**

* Go to https://developer.nvidia.com/cuda-downloads
* Download CUDA repository package 

```
sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb 
sudo apt-get update 
sudo apt-get install cuda 
```


**CuDNN**

* Register to https://developer.nvidia.com/cuDNN 
* Download cuDNN R4 for Linux (the name of the file should be cudnn-7.0-linux-x64-v4.0-prod.tgz)

```
tar -xvf cudnn-7.0-linux-x64-v3.0-prod.tgz
sudo cp cuda/include/*.h /usr/local/cuda/include
sudo cp cuda/lib64/*.so* /usr/local/cuda/lib64
```


## Contributors

Emanuele Pesce, Nicolo' Savioli