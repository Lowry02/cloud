#!/bin/bash
./run.sh \
DAT=./utils/hpl-big.dat \
RUNS=1 \
THREADS=4 \
SERVER=vm2 \
TEST_FOLDER=./logs \
NAME=vm1 \
NFS_TEST=TRUE \
NET_TEST=TRUE
