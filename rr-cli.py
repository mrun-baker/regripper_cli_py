import os
from Registry import Registry

def process_hive(hive_path, report_path):
    reg = Registry.Registry(hive_path)
    root_key = reg.root()

    with open(report_path, 'w') as rpt:
        rpt.write(f"Processing hive: {hive_path}\n")
        rpt.write(f"Hive type: {guess_hive_type(root_key)}\n")
        rpt.write(f"Plugins executed:\n")
        # Iterate through registry keys and perform necessary actions
        for subkey in root_key.subkeys():
            rpt.write(f"Subkey: {subkey.name()}\n")
            # Add more processing and plugin execution here based on your needs

def guess_hive_type(root_key):
    """Guess the type of the hive based on keys present."""
    try:
        if root_key.subkey("SAM\\Domains\\Account\\Users"):
            return "SAM"
        if root_key.subkey("Microsoft\\Windows\\CurrentVersion"):
            return "SOFTWARE"
        if root_key.subkey("MountedDevices") and root_key.subkey("Select"):
            return "SYSTEM"
        if root_key.subkey("Software\\Microsoft\\Windows\\CurrentVersion"):
            return "NTUSER.DAT"
    except Registry.RegistryKeyNotFoundException:
        pass
    return "Unknown"

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python rr.py <hive_file> <report_file>")
        sys.exit(1)

    hive_file = sys.argv[1]
    report_file = sys.argv[2]

    if not os.path.exists(hive_file):
        print(f"Hive file {hive_file} does not exist.")
        sys.exit(1)

    process_hive(hive_file, report_file)
    print(f"Ripping complete. Report saved to {report_file}")