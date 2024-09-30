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
