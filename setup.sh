#!/bin/bash
PROJECT_FOLDER=$(pwd)
./utils/hpl-setup.sh
cd $PROJECT_FOLDER
./utils/sysbench-setup.sh
cd $PROJECT_FOLDER
./utils/iozone-setup.sh
cd $PROJECT_FOLDER
./utils/iperf-setup.sh
cd $PROJECT_FOLDER
source ./utils/export.sh
cd $PROJECT_FOLDER