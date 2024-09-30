# regripper_cli_py
converted regripper from perl to python command line interface for EDR Live Incident Response 

for RegRipper refer to RegRipper documentation

Converted to python CLI, because most EDR live response does not work with GUI
File is rr-cli.py

To use example for Crowdstrike in LiveResponse mode: runs "python rr-cli.py <hive file> <output_file.txt>"

Example of HIVE File Directory

C:\Users\<Username>\NTUSER.DAT
 
C:\Windows\System32\config\SYSTEM
 
C:\Windows\System32\config\SOFTWARE
 
C:\Windows\System32\config\SAM
 
C:\Windows\System32\config\SECURITY

I hope it works out for you guys

Have Fun!!!

for end machine, without py, you can leverage on ps1

attached equiv ps1

put C:\local\path\to\rr.ps1

then run

runs "powershell.exe -ExecutionPolicy Bypass -File C:\path\to\uploaded\rr.ps1 -HivePath C:\Users\abuemran\NTUSER.DAT -ReportPath C:\path\to\save\NTUSER.txt"

NTUser.Dat as HiVe example

get C:\path\to\save\NTUSER.txt
