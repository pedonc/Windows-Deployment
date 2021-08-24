#
# Computer Deployment And Management Tools
#
# Copyright (C) 2021 Curtis Glavin, Jonathan Huppi, Joshua Casiano
#
# This is currently a rudimentary proof-of-concept script to begin working towards a model of machine administration with unique, secure, algorithmically-generated passwords for managed workstations.  The goal is to create a secure environment with a minimum amount of secret data, potentially allowing a single, memorizable salt to be used to generate unique, reproducible, secure administrator passwords for all devices.
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License Version 3 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License Version 3 along with this program, under the file name LICENSE.  As of this writing, the GPL Version 3 is also posted on the web at:
#
# http://www.gnu.org/licenses/
#
# You may also obtain a copy of the license by writing to:
#
# Free Software Foundation, Inc.
# 59 Temple Place, Suite 330
# Boston, MA 02111-1307, USA
#

#Requires -RunAsAdministrator

#
# This global will hold the length of the passwords to be generated.  The value should be between 16 and 64 (inclusive).  For security, it is recommended that the value be the largest possible length (up to the maximum of 64) that will be compatible with your systems and protocols.  By default, this value is set to 16, as that is compatible with legacy password limits from Micrososft, is long enough to be reasonably secure, and is short enough for manual entry when required.
#
$script:PASSWORD_LENGTH = 16

#
# This global will hold the minimum salt length for password generation.
#
$script:MINIMUM_SALT_LENGTH = 8

#
# This global will hold the unique device identifier, which is usually the system's MAC address in lowercase without punctuation or whitespace
#
$script:ID = $null

#
# This global will hold the username for the administrator account to be created.
#
$script:USERNAME = $null

#
# This global will hold the salt for the password for the administrator account that will be created.
#
$script:SALT = $null

function sanitizedMAC([string]$mac) {
    $mac = $mac -replace '[^a-fA-F0-9]'
    $mac = $mac.ToLower()
    if ($mac.length -eq 12) {
        return $mac
    }
    return $false
}

function validUsername([string]$username) {
    if ($username.length -le 20 -and $username.length -gt 0) {
        $test = $username -replace '[^a-zA-Z0-9]'
        if ($username -eq $test) {
            return $true
        }
    }
    return $false
}

function validSalt([string]$salt) {
    if ($salt.length -lt $MINIMUM_SALT_LENGTH) {
        return $false
    }
    return $true
}

function hashword([string]$salt, [string]$id, [int]$length = $PASSWORD_LENGTH) {
    $stream = [System.IO.MemoryStream]::new()
    $streamWriter = [System.IO.StreamWriter]::new($stream)
    $streamWriter.write($salt + $id)
    $streamWriter.Flush()
    $stream.Position = 0
    $result = Get-FileHash -Algorithm SHA256 -InputStream $stream | Select-Object Hash
    return $result.Hash.SubString(0,$length).toLower()
}

#
# Obtain a unique identifier for this device
#
$options = @()
$counter = 1
$ipconfig = ipconfig /all
if ($ipconfig) {
    $adapters = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration"
    if ($adapters) {
        $counter = 1
        $line = 0
        do {
            if (($ipconfig[$line].length -gt 55) -and ($ipconfig[$line].substring(0,39) -eq "   Physical Address. . . . . . . . . : ")) {
                $ipconfig[$line]
                $adapter = $adapters | Where-Object {$_.MACAddress -eq $ipconfig[$line].substring(39,17).replace('-',':')}
                $options += New-Object PsObject -Property @{ Option=$counter; Description=$adapter.Description; MAC=$adapter.MacAddress}
                $counter++
            }
            $line++
        } while ($line -lt $ipconfig.Count)
        if ($counter -gt 1) {
            $options += New-Object PsObject -Property @{ Option=$counter; Description="Enter A Custom Identifier"; MAC=""}
            do {
                Clear-Host
                Write-Host "Select NIC whose MAC will be the device's unique identifier, or select ${counter} for custom`n"
                Write-Host "(please prioritize physical Ethernet, Wi-Fi, or Bluetooth adapters, in that order)`n"
                $options | Format-Table Option, Description, MAC | Format-Wide
                $input = Read-Host "Enter option number (1-${counter})"
                if ($input -ne ($input -as [int])) {
                    $input = $null
                }
            } until(($input -ge 1) -and ($input -le $counter))
            if ($input -ne $counter) {
                $mac = sanitizedMAC $options[$input - 1].MAC
                if ($mac) {
                    $ID = $mac
                }
            }
        }
    }
}
if ($ID -eq $null) {
    do {
        Clear-Host
        $input = Read-Host "Enter the device's unique identifier (12 lowercase hexadecimal characters)"
        $input = sanitizedMAC $input
        if ($input) {
            $ID = $input
        }
    }
    until($ID -ne $null)
}


#
# Obtain the username for the administrator account to be created
#
do {
    Clear-Host
    $input = Read-Host "Enter the username for the account you want to create (maximum 20 alphanumeric characters)"
    if (validUsername $input) {
        $USERNAME = $input.ToLower()
    }
} until($USERNAME -ne $null)

#
# Obtain the salt to be used when generating the administrator account's password
#
do {
    Clear-Host
    $input = Read-Host "Enter the salt for the new account's password (minimum 8 characters)" -AsSecureString
    $input = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($input))
    if (validSalt $input) {
        $SALT = $input
    }
} until($SALT -ne $null)

#
# Create the administrator account
#
$PASSWORD = hashword $SALT $ID
$PASSWORD = ConvertTo-SecureString $PASSWORD -AsPlainText -Force
$result = New-LocalUser $USERNAME -Password $PASSWORD -PasswordNeverExpires
$result = Add-LocalGroupMember -Group "Administrators" -Member $USERNAME
write-host "Created administrator account ${USERNAME} on system ${ID}"
exit
