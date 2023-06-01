#!/bin/bash

# Function to check for misconfigurations and list shares
check_misconfigurations() {
    echo "Testing SMB misconfigurations for IP: $1"

    # Check if NULL session is allowed
    smbclient -L //$1 -N -U "%" 2>/dev/null >/dev/null
    if [ $? -eq 0 ]; then
        echo "NULL Session Allowed: Yes"
    else
        echo "NULL Session Allowed: No"
    fi
    echo "Command: smbclient -L //$1 -N -U \"%\""

    # Check if guest account is enabled
    smbclient -L //$1 -N -U "guest" 2>/dev/null >/dev/null
    if [ $? -eq 0 ]; then
        echo "Guest Account Enabled: Yes"
    else
        echo "Guest Account Enabled: No"
    fi
    echo "Command: smbclient -L //$1 -N -U \"guest\""

    # Check if anonymous login is allowed
    smbclient -L //$1 -N 2>/dev/null >/dev/null
    if [ $? -eq 0 ]; then
        echo "Anonymous Login Allowed: Yes"
    else
        echo "Anonymous Login Allowed: No"
    fi
    echo "Command: smbclient -L //$1 -N"

    # Check if password policy is enforced
    smbclient -L //$1 -U "test"%"password" 2>/dev/null >/dev/null
    if [ $? -eq 0 ]; then
        echo "Password Policy Enforced: No"
    else
        echo "Password Policy Enforced: Yes"
    fi
    echo "Command: smbclient -L //$1 -U \"test\"%\"password\""

    echo "------------------------"

    # List shares
    smbclient -L //$1 -N 2>/dev/null | grep -E "^[[:alnum:]]+" | while read -r share; do
        echo "Share found: $share"
    done
}

# Check if an IP address is provided as an argument
if [ $# -eq 0 ]; then
    echo "Please provide an IP address as an argument."
    exit 1
fi

# Call the function to check misconfigurations and list shares for the provided IP address
check_misconfigurations "$1"
