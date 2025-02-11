#!/bin/bash

# DAT: the path of the HPL.dat filedit can have a different name, it will be renamed)
# RUNS:number of iterations
# THREADS: number of threads
# NET_TEST: executes or not the net test [TRUE | FALSE]
# SERVER: server ip (if NET_TEST == TRUE)
# TEST_FOLDER: log folder
# NAME: name of the test
# NFS_TEST: executes or not the nfs test [TRUE | FALSE]

# reading and checking params
for arg in "$@"; do
  eval "$arg"
done

if [[ -z "$RUNS" ]]; then
  echo "> RUNS is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$THREADS" ]]; then
  echo "> THREADS is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$NET_TEST" ]]; then
  echo "> NET_TEST is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ "$NET_TEST" == "TRUE" && -z "$SERVER" ]]; then
  echo "> SERVER must be defined if NET_TEST is TRUE"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$TEST_FOLDER" ]]; then
  echo "> TEST_FOLDER is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$NAME" ]]; then
  echo "> TEST_FOLDER is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$DAT" ]]; then
  echo "> DAT is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$NFS_TEST" ]]; then
  echo "> NFS_TEST is not defined"
  echo "> Exiting..."
  exit 1
fi

PROJECT_FOLDER=$(pwd)
./utils/hpl-run.sh DAT=$DAT RUNS=$RUNS TEST_FOLDER=$TEST_FOLDER NAME=$NAME
cd $PROJECT_FOLDER
./utils/sysbench-run.sh THREADS=$THREADS RUNS=$RUNS TEST_FOLDER=$TEST_FOLDER NAME=$NAME
cd $PROJECT_FOLDER
./utils/iozone-run.sh RUNS=$RUNS TEST_FOLDER=$TEST_FOLDER NAME=$NAME
cd $PROJECT_FOLDER
if [[ "$NFS_TEST" == "TRUE" ]]; then
  ./utils/iozone-nfs-run.sh
  cd $PROJECT_FOLDER
fi
if [[ "$NET_TEST" == "TRUE" ]]; then
  ./utils/iperf-run.sh RUNS=$RUNS TEST_FOLDER=$TEST_FOLDER SERVER=$SERVER
  cd $PROJECT_FOLDER
fi
cd $PROJECT_FOLDER