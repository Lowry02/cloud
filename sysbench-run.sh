#!/bin/bash

# THREADS: number of threads to use
# TEST_FOLDER: log folder
# NAME: test name

# reading and checking params
for arg in "$@"; do
  eval "$arg"
done

if [[ -z "$THREADS" ]]; then
  echo "> THREADS is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$TEST_FOLDER" ]]; then
  echo "> TEST_FOLDER is not defined"
  echo "> Exiting..."
  exit 1
fi

if [[ -z "$NAME" ]]; then
  echo "> NAME is not defined"
  echo "> Exiting..."
  exit 1
fi

TEST_FOLDER=$(realpath "$TEST_FOLDER")

echo "> Starting Sysbench tests"
echo "> Running using:"
echo "    - THREADS: 4"
echo "    - TEST_FOLDER: $TEST_FOLDER"
echo "    - NAME: $NAME"

# log file creation
FILE_NAME=$TEST_FOLDER/sysbench_test-$NAME-$(date +%Y-%m-%d_%H-%M).txt
touch $FILE_NAME

for ((i=1; i<=RUNS; i++)); do
  echo "> Run $i/$RUNS"
  echo -e "\n>> -- [ RUN $i ]\n" >> $FILE_NAME
  echo -e ">> -- [ CPU ]\n" >> $FILE_NAME
  sysbench cpu --threads=$THREADS --cpu-max -prime=100000 run >> $FILE_NAME
  echo -e ">> -- [ CPU ]\n" >> $FILE_NAME
  sysbench memory --memory-block-size=1MB --memory-total-size=5G run >> $FILE_NAME
done

echo "> Results saved in $FILE_NAME"
echo "> END"