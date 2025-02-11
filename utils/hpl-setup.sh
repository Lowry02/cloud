#!/bin/bash
sudo apt update -y
sudo apt upgrade -y

PACKAGES_TO_INSTALL="build-essential hwloc libhwloc-dev libevent-dev gfortran linux-headers-$(uname -r)"
for package in $PACKAGES_TO_INSTALL; do
  sudo apt install -y $package
done

# instaling OpenBLAS
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
git checkout v0.3.21
make
make PREFIX=$HOME/opt/OpenBLAS install
cd ..
rm -rf OpenBLAS

# installing OpenMPI
wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.4.tar.gz
tar xf openmpi-4.1.4.tar.gz
rm openmpi-4.1.4.tar.gz
cd openmpi-4.1.4
CFLAGS="-Ofast -march=native" ./configure --prefix=$HOME/opt/OpenMPI
make -j 16
make install
export MPI_HOME=$HOME/opt/OpenMPI
export PATH=$PATH:$MPI_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MPI_HOME/lib
cd ..
rm -rf openmpi-4.1.4

# compiling HPL
wget https://netlib.org/benchmark/hpl/hpl-2.3.tar.gz
gunzip hpl-2.3.tar.gz
tar xvf hpl-2.3.tar
rm hpl-2.3.tar
mv hpl-2.3 ~/hpl

cp ./utils/Make.linux ~/hpl
cd ~/hpl
make arch=linux