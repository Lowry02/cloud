from hpl_parser import parse_hpl_output
from sysbench_parser import parse_sysbench_output
from iperf_parser import parse_iperf_output
from iozone_parser import parse_iozone_output
import os

output_folder = "./csv"
log_folder = "./logs"

for filename in os.listdir(log_folder):
  output_filename = filename.split('-2025')[0] + ".csv"
  # if filename.startswith("hpl_test"):
  #   parse_hpl_output(os.path.join(log_folder, filename), os.path.join(output_folder, output_filename))
  # elif filename.startswith("sysbench_test"):
  #   parse_sysbench_output(os.path.join(log_folder, filename), os.path.join(output_folder, output_filename))
  # elif filename.startswith("iperf_test"):
  #   parse_iperf_output(os.path.join(log_folder, filename), os.path.join(output_folder, output_filename))
  # elif filename.startswith("iozone_test"):
  #   parse_iozone_output(os.path.join(log_folder, filename), os.path.join(output_folder, output_filename))
  if filename.startswith("iozone-nfs_test"):
    parse_iozone_output(os.path.join(log_folder, filename), os.path.join(output_folder, output_filename))