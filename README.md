Performance Comparison: Containers vs Virtual Machines

Project Overview

This project aims to evaluate the performance differences between Containers (Docker) and Virtual Machines (VirtualBox) on an M1 Mac. The comparison is based on multiple benchmarking tests to assess CPU, memory, and I/O operations.

Benchmarking Tests

To compare the performance of Containers and Virtual Machines, the following tests were conducted:

HPL (High-Performance Linpack) - Evaluates floating-point computing performance.

Sysbench - Measures CPU and memory performance.

IOzone - Assesses I/O operations and NFS.

Iperf - Evaluates network performance.

Repository Structure

analysis/ - Contains Jupyter notebooks for plotting and analyzing the benchmarking results.

csv/ - Parsed output files from the test executions.

logs/ - Raw output from the benchmarking tests.

report_img/ - Images used in the project report.

utils/ - Setup and run scripts for test execution.

big-run.sh - Executes benchmarking tests with a large configuration.

small-run.sh - Executes benchmarking tests with a small configuration.

docker-compose.yaml - Configures the containerized environment.

Dockerfile - Defines a pre-configured Ubuntu image for testing.

run.sh - Base script for running all benchmarking tests.

setup.sh - Configures the Ubuntu system to run benchmarking tests.

Conclusion

The results from these tests help determine whether Containers offer better performance than Virtual Machines in various computing environments. The findings and plots are available in the analysis/ folder.