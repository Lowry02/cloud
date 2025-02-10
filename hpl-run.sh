#!/bin/bash

# Variables:
# - DAT: the path of the HPL.dat filedit can have a different name, it will be renamed)
# - RUNS:number of iterations
# - TEST_FOLDER: folder in which to save the logs

# reading input variables
for arg in "$@"; do
  eval "$arg"
done

echo "> Starting HPL tests"
echo "> Reading user input"

# checking if all the required params are passed
if [[ -z "$DAT" ]]; then
  echo "> DAT is not defined"
  echo "> Exiting..."
  exit 1
fi

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

echo "> Running with:"
echo "    DAT: $DAT"
echo "    RUNS: $RUNS"
echo "    TEST_FOLDER: $TEST_FOLDER"

# setting env variables
export MPI_HOME=$HOME/opt/OpenMPI
export PATH=$PATH:$MPI_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MPI_HOME/lib

# copying the dat and creating the log file
echo "> Copying dat file"
cp $DAT $HOME/hpl/bin/linux/HPL.dat

FILE_NAME = $TEST_FOLDER/hpl_test-$(date +%Y-%m-%d_%H-%M).txt
echo "> Creating logging file: $FILE_NAME"
touch $FILE_NAME

for ((i=1; i<=RUNS; i++)); do
  echo "> Run $i/$RUNS"
  mpirun --bind-to core -np 4 $HOME/hpl/bin/linux/xhpl >> $FILE_NAME
done

echo "> Results saved in $FILE_NAME"
echo "> END"