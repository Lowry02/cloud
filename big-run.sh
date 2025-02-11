#!/bin/bash
./run.sh \
DAT=./utils/hpl-big.dat \
RUNS=1 \
THREADS=4 \
NET_TEST=TRUE \
SERVER=vm2 \
TEST_FOLDER=./logs \
NFS_TEST=TRUE \
SHARED_FOLDER=~/shared \
NAME=vm1
