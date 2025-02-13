#!/bin/bash

# RUNS:number of iterations
# TEST_FOLDER: log folder
# SERVER: server ip

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

if [[ -z "$SERVER" ]]; then
  echo "> SERVER is not defined"
  echo "> Exiting..."
  exit 1
fi

TEST_FOLDER=$(realpath "$TEST_FOLDER")

echo "> Starting Iperf tests"
echo "> Running using:"
echo "    - TEST_FOLDER: $TEST_FOLDER"
echo "    - NAME: $NAME"
echo "    - SERVER: $SERVER"

# log file creation
FILE_NAME=$TEST_FOLDER/iperf_test-$(date +%Y-%m-%d_%H-%M).txt
touch $FILE_NAME

for ((i=1; i<=RUNS; i++)); do
  echo "> Run $i/$RUNS"
  echo -e "\n>> -- [ RUN $i ]\n" >> $FILE_NAME
  echo timestamp,server_ip,server_port,client_ip,client_port,tag_id,interval,transferred,bandwidth >> $FILE_NAME
  iperf -c $SERVER -i 1 -t 30 -y C --output $FILE_NAME
done

echo "> Results saved in $FILE_NAME"
echo "> END"