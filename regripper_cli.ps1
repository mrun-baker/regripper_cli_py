param(
    [string]$HivePath,   # Path to the hive file
    [string]$ReportPath  # Path to the report file
)

# Function to process the registry hive file
function Process-Hive {
    param (
        [string]$HiveFile,
        [string]$OutputFile
    )

    # Check if the hive file exists
    if (-not (Test-Path -Path $HiveFile)) {
        Write-Host "Hive file not found: $HiveFile"
        exit 1
    }

    # Open the hive and get the root key
    reg.exe load HKU\TempHive $HiveFile
    $rootKey = Get-Item "HKU:\TempHive"

    # Create the report file
    try {
        New-Item -Path $OutputFile -Force
    } catch {
        Write-Host "Unable to create report file: $OutputFile"
        exit 1
    }

    # Write initial data to the report
    Add-Content -Path $OutputFile -Value "Processing hive: $HiveFile"
    Add-Content -Path $OutputFile -Value "---------------------------------"

    # Determine the type of the hive
    $hiveType = Guess-HiveType $rootKey
    Add-Content -Path $OutputFile -Value "Hive type: $hiveType"

    # Iterate through root keys and add them to the report
    $rootKey.SubKeys | ForEach-Object {
        Add-Content -Path $OutputFile -Value "Subkey: $($_.PSChildName)"
    }

    # Unload the hive after processing
    reg.exe unload HKU\TempHive
    Write-Host "Hive processing complete. Report saved to: $OutputFile"
}

# Function to guess the hive type based on subkeys
function Guess-HiveType {
    param (
        [Microsoft.Win32.RegistryKey]$RootKey
    )

    # Check for common hive types based on specific subkeys
    if (Test-Path "HKU:\TempHive\SAM\Domains\Account\Users") {
        return "SAM"
    }
    if (Test-Path "HKU:\TempHive\Microsoft\Windows\CurrentVersion") {
        return "SOFTWARE"
    }
    if (Test-Path "HKU:\TempHive\MountedDevices" -and Test-Path "HKU:\TempHive\Select") {
        return "SYSTEM"
    }
    if (Test-Path "HKU:\TempHive\Software\Microsoft\Windows\CurrentVersion") {
        return "NTUSER.DAT"
    }

    return "Unknown"
}

# Main logic
if (-not (Test-Path -Path $HivePath)) {
    Write-Host "Hive file does not exist: $HivePath"
    exit 1
}

Process-Hive -HiveFile $HivePath -OutputFile $ReportPath
