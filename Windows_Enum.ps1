# Get current user and hostname
Write-Host "User: $env:USERNAME"
Write-Host "Hostname: $env:COMPUTERNAME"

# Get group memberships of current user
Write-Host "Group memberships:"
whoami /groups

# Get existing users and groups
Write-Host "Existing users and groups:"
Get-LocalUser
Get-LocalGroup

# Get operating system information
Write-Host "Operating system information:"
Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture

# Get network information
Write-Host "Network information:"
Get-NetAdapter | Select-Object Name, InterfaceDescription, MacAddress, Status
Get-NetIPAddress | Select-Object IPAddress, InterfaceAlias

# Get installed applications
Write-Host "Installed applications:"
Get-WmiObject Win32_Product | Select-Object Name, Version

# Get running processes
Write-Host "Running processes:"
Get-Process | Select-Object Name, Id, CPU, Description, StartTime

Read-Host "Press Enter to exit"
