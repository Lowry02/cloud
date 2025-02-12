import re
import csv

def parse_hpl_output(file_path, output_csv):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    runs = []
    current_run = None
    
    for line in lines:
        run_match = re.match(r">> -- \[ RUN (\d+) \]", line)
        if run_match:
            if current_run:
                runs.append(current_run)  # Store previous run
            current_run = []  # Start new run
            continue
        
        data_match = re.match(r"(\S+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+([\d\.]+)\s+([\d\.e\+\-]+)", line)
        if data_match:
            current_run.append(data_match.groups())
    
    if current_run:
        runs.append(current_run)  # Store last run
    
    # Write to CSV
    with open(output_csv, 'w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(["Run", "T/V", "N", "NB", "P", "Q", "Time", "Gflops"])
        
        for run_idx, run in enumerate(runs, start=1):
            for entry in run:
                writer.writerow([run_idx] + list(entry))
    
    print(f"CSV file '{output_csv}' created successfully.")