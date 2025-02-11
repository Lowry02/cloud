#!/bin/bash

# RUNS:number of iterations
# TEST_FOLDER: log folder
# SHARED_FOLDER: shared folder path
# NAME: test name

# reading and checking params
for arg in "$@"; do
  eval "$arg"
done

if [[ -z "$RUNS" ]]; then
  echo "> RUNS is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$TEST_FOLDER" ]]; then
  echo "> TEST_FOLDER is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$SHARED_FOLDER" ]]; then
  echo "> SHARED_FOLDER is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$NAME" ]]; then
  echo "> NAME is not defined"
  echo "> Exiting..."
  exit 1
fi

TEST_FOLDER=$(realpath "$TEST_FOLDER")

echo "> Starting IOzone NFS tests"
echo "> Running using:"
echo "    - TEST_FOLDER: $TEST_FOLDER"
echo "    - NAME: $NAME"

# log file creation
FILE_NAME=$TEST_FOLDER/iozone-nfs_test-$NAME-$(date +%Y-%m-%d_%H-%M).txt
touch $FILE_NAME

for ((i=1; i<=RUNS; i++)); do
  echo "> Run $i/$RUNS"
  echo -e "\n>> -- [ RUN $i ]\n" >> $FILE_NAME
  iozone -a -i 0 -i 1 -i 2 -f $SHARED_FOLDER/tempfile >> $FILE_NAME
done

echo "> Results saved in $FILE_NAME"
echo "> END"