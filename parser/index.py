from hpl_parser import parse_hpl_output
from sysbench_parser import parse_sysbench_output
from iperf_parser import parse_iperf_output
from iozone_parser import parse_iozone_output

output_folder = "./csv"
# parse_hpl_output("./logs/hpl_test-c1-pinning-2025-02-12_17-01.txt", f"{output_folder}/hpl_output.csv")
# parse_sysbench_output("./logs/sysbench_test-c1-pinning-2025-02-12_17-03.txt", f"{output_folder}/sysbench_output.csv")
# parse_iperf_output("./logs/iperf_test-c-pinning-2025-02-12_16-52.txt", f"{output_folder}/iperf_output.csv")
parse_iozone_output("./logs/iozone_test-c1-pinning-2025-02-12_17-04.txt", f"{output_folder}/iperf_output.csv")