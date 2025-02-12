import re
import csv

def parse_sysbench_output(file_path, output_csv):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    runs = []
    current_run = {}
    section = None
    
    for line in lines:
        run_match = re.match(r">> -- \[ RUN (\d+) \]", line)
        if run_match:
            if current_run:
                runs.append(current_run)  # Store previous run
            current_run = {"Run": int(run_match.group(1))}
            continue
        
        section_match = re.match(r">> -- \[ (CPU|MEMORY) \]", line)
        if section_match:
            section = section_match.group(1)
            continue
        
        if section == "CPU":
            if "CPU_events_per_sec" in line:
                current_run["CPU_events_per_sec"] = float(line.split(':')[-1].strip())
            elif "total time" in line:
                current_run["CPU_total_time"] = float(line.split(':')[-1].strip().replace('s', ''))
            elif "total number of events" in line:
                current_run["CPU_total_events"] = int(line.split(':')[-1].strip())
            elif "avg:" in line:
                current_run["CPU_latency_avg"] = float(line.split(':')[-1].strip())
            elif "min:" in line:
                current_run["CPU_latency_min"] = float(line.split(':')[-1].strip())
            elif "max:" in line:
                current_run["CPU_latency_max"] = float(line.split(':')[-1].strip())
            elif "95th percentile:" in line:
                current_run["CPU_latency_95th"] = float(line.split(':')[-1].strip())
            elif "sum:" in line:
                current_run["CPU_latency_sum"] = float(line.split(':')[-1].strip())
            elif "events (avg/stddev):" in line:
                values = re.findall(r"\d+\.\d+", line)
                current_run["CPU_thread_fairness_events_avg"] = float(values[0])
                current_run["CPU_thread_fairness_events_stddev"] = float(values[1])
            elif "execution time (avg/stddev):" in line:
                values = re.findall(r"\d+\.\d+", line)
                current_run["CPU_thread_fairness_exec_avg"] = float(values[0])
                current_run["CPU_thread_fairness_exec_stddev"] = float(values[1])
        
        elif section == "MEMORY":
            if "block size:" in line:
                current_run["Memory_block_size"] = line.split(':')[-1].strip().removesuffix("KiB")
            elif "total size:" in line:
                current_run["Memory_total_size"] = line.split(':')[-1].strip()
            elif "operation:" in line:
                current_run["Memory_operation"] = line.split(':')[-1].strip()
            elif "scope:" in line:
                current_run["Memory_scope"] = line.split(':')[-1].strip()
            elif "Total operations:" in line:
                current_run["Memory_total_operations"] = int(line.split(':')[-1].strip().split(' ')[0])
            elif "MiB transferred" in line:
                current_run["Memory_mib_transferred"] = float(line.split('(')[-1].split(' ')[0])
            elif "total time" in line:
                current_run["Memory_total_time"] = float(line.split(':')[-1].strip().replace('s', ''))
            elif "total number of events" in line:
                current_run["Memory_total_events"] = int(line.split(':')[-1].strip())
            elif "avg:" in line:
                current_run["Memory_latency_avg"] = float(line.split(':')[-1].strip())
            elif "min:" in line:
                current_run["Memory_latency_min"] = float(line.split(':')[-1].strip())
            elif "max:" in line:
                current_run["Memory_latency_max"] = float(line.split(':')[-1].strip())
            elif "95th percentile:" in line:
                current_run["Memory_latency_95th"] = float(line.split(':')[-1].strip())
            elif "sum:" in line:
                current_run["Memory_latency_sum"] = float(line.split(':')[-1].strip())
            elif "events (avg/stddev):" in line:
                values = re.findall(r"\d+\.\d+", line)
                current_run["Memory_thread_fairness_events_avg"] = float(values[0])
                current_run["Memory_thread_fairness_events_stddev"] = float(values[1])
            elif "execution time (avg/stddev):" in line:
                values = re.findall(r"\d+\.\d+", line)
                current_run["Memory_thread_fairness_exec_avg"] = float(values[0])
                current_run["Memory_thread_fairness_exec_stddev"] = float(values[1])
    
    if current_run:
        runs.append(current_run)  # Store last run
    
    # Write to CSV
    with open(output_csv, 'w', newline='') as csv_file:
        fieldnames = runs[0].keys()
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for run in runs:
            writer.writerow(run)
    
    print(f"CSV file '{output_csv}' created successfully.")