import re
import csv

def parse_iozone_output(file_path, output_csv):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    runs = []
    current_run = {}
    collecting_data = False
    
    for line in lines:
        run_match = re.match(r">> -- \[ RUN (\d+) \]", line)
        if run_match:
            if current_run:
                runs.append(current_run)  # Store previous run
            current_run = {"Run": int(run_match.group(1))}
            collecting_data = False
            continue
        
        if "kB  reclen" in line:
            collecting_data = True
            continue
        
        if collecting_data:
            data_match = re.match(r"\s*(\d+)\s+(\d+)\s+([\d\.]+)\s+([\d\.]+)\s+([\d\.]+)\s+([\d\.]+)\s+([\d\.]+)\s+([\d\.]+)?", line)
            if data_match:
                current_run.setdefault("Records", []).append({
                    "Size (kB)": int(data_match.group(1)),
                    "Record Length": int(data_match.group(2)),
                    "Write (kB/s)": float(data_match.group(3)),
                    "Rewrite (kB/s)": float(data_match.group(4)),
                    "Read (kB/s)": float(data_match.group(5)),
                    "Reread (kB/s)": float(data_match.group(6)),
                    "Random Read (kB/s)": float(data_match.group(7)) if data_match.group(7) else None,
                    "Random Write (kB/s)": float(data_match.group(8)) if data_match.group(8) else None
                })
    
    if current_run:
        runs.append(current_run)  # Store last run
    
    # Write to CSV
    with open(output_csv, 'w', newline='') as csv_file:
        fieldnames = ["Run", "Size (kB)", "Record Length", "Write (kB/s)", "Rewrite (kB/s)", "Read (kB/s)", "Reread (kB/s)", "Random Read (kB/s)", "Random Write (kB/s)"]
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        
        for run in runs:
            for record in run.get("Records", []):
                writer.writerow({"Run": run["Run"], **record})
    
    print(f"CSV file '{output_csv}' created successfully.")