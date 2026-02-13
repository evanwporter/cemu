import json
import os

INPUT_FILE = "tests\\GameboyCPUTests\\v2\\cb.json"
OUTPUT_DIR = "tests\\GameboyCPUTests\\v2\\cb"

os.makedirs(OUTPUT_DIR, exist_ok=True)

with open(INPUT_FILE, "r") as f:
    data = json.load(f)

groups = {}

for entry in data:
    name = entry["name"]

    parts = name.split()
    cb_second_byte = parts[1]

    groups.setdefault(cb_second_byte, []).append(entry)

for cb_byte, entries in groups.items():
    out_path = os.path.join(OUTPUT_DIR, f"{cb_byte}.json")
    with open(out_path, "w") as f:
        json.dump(entries, f, indent=2)
