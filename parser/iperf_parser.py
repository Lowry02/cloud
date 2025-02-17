import re
import csv

def parse_iperf_output(log_filename, output_csv):
    with open(log_filename, 'r') as log_file:
        lines = log_file.readlines()

    csv_data = []
    header_found = False
    run_id = None

    for line in lines:
        line = line.strip()
        
        # Detect run ID
        match = re.match(r">> -- \[ RUN (\d+) \]", line)
        if match:
            run_id = match.group(1)
            continue
        
        # Capture header
        if not header_found and "timestamp" in line:
            header = ["run"] + line.split(",")
            csv_data.append(header)
            header_found = True
            continue
        
        # Capture data rows
        if header_found and re.match(r"^\d{14},", line):
            csv_data.append([run_id] + line.split(","))

    # Write to CSV file
    with open(output_csv, 'w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerows(csv_data)