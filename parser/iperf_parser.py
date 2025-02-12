import re
import csv

def parse_iperf_output(file_path, output_csv):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    runs = []
    current_run = {}
    
    for line in lines:
        run_match = re.match(r">> -- \[ RUN (\d+) \]", line)
        if run_match:
            if current_run:
                runs.append(current_run)  # Store previous run
            current_run = {"Run": int(run_match.group(1))}
            continue
        
        data_match = re.match(r"\[\s*\d+\] (\d+\.\d+-\d+\.\d+) sec\s+(\d+) GBytes\s+(\d+) Gbits/sec", line)
        if data_match:
            current_run["Interval (sec)"] = data_match.group(1)
            current_run["Transfer (GBytes)"] = int(data_match.group(2))
            current_run["Bandwidth (Gbits/sec)"] = int(data_match.group(3))
    
    if current_run:
        runs.append(current_run)  # Store last run
    
    # Write to CSV
    with open(output_csv, 'w', newline='') as csv_file:
        fieldnames = ["Run", "Interval (sec)", "Transfer (GBytes)", "Bandwidth (Gbits/sec)"]
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for run in runs:
            writer.writerow(run)
    
    print(f"CSV file '{output_csv}' created successfully.")