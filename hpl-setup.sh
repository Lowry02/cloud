#!/bin/bash
sudo apt update
sudo apt upgrade

sudo apt install build-essential linux-headers-$(uname -r) hwloc libhwloc-dev libevent-dev gfortran

# instaling OpenBLAS
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
git checkout v0.3.21
make
make PREFIX=$HOME/opt/OpenBLAS install
cd ..

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

# compiling HPL
wget https://netlib.org/benchmark/hpl/hpl-2.3.tar.gz
gunzip hpl-2.3.tar.gz
tar xvf hpl-2.3.tar
rm hpl-2.3.tar
mv hpl-2.3 ~/hpl

cp ./Make.linux ~/hpl
cd ~/hpl
make arch=linux

cp ~/project/HPL.dat ~/hpl/bin/linux
