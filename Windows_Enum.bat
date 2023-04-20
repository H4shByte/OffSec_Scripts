@echo off

echo User: %USERNAME%
echo Hostname: %COMPUTERNAME%

echo Group memberships:
whoami /groups

echo Existing users and groups:
net user
net localgroup

echo Operating system information:
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"

echo Network information:
ipconfig /all

echo Installed applications:
wmic product get name,version

echo Running processes:
tasklist

pause
