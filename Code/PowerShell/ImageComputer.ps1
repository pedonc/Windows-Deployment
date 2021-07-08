#
# Windows Deployment Imaging Script
#
# Copyright (C) 2021 Curtis Glavin, Jonathan Huppi, Joshua Casiano
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

#
# Will contain number of disk to install to
#
$disk = -1

#
# Will contain name for computer
#
$name = "*"

#
# Will contain PE drive letter
#
$peDrive = "*"

#
# Will contain new Windows drive letter
#
$windowsDrive = "*"

#
# Will contain System drive letter
#
$systemDrive = "*"


$disks = Get-Disk
#
# Quit if there are not at least 2 disks with non-zero
# capacity (USB PE disk + destination disk)
#
if (!$disks -or (($disks | Where-Object -FilterScript {$_.Size -gt 0} | measure).Count -lt 2)) {
    Clear-Host
    Write-Host "No destination disk found.`nPlease install disk and/or drivers and restart script.`n`n"
    [void](Read-Host 'Press Enter to quit the program...')
    Exit
}

#
# Obtain letter of PE drive
# (educated guess based on location of Images\Windows21H1ProEFI64SysprepWindows.swm)
# and select an available drive letter for the new
# Windows partition that will be created
#
$originalDrives = (Get-PSDrive -PSProvider FileSystem).Name
if ($originalDrives) {
    ForEach ($drive in $originalDrives) {
        if (Test-Path "${drive}:\Images\Windows21H1ProEFI64SysprepWindows.swm") {
            $peDrive = $drive
            break
        }
    }
}
if ($peDrive -eq "*") {
    Clear-Host
    Write-Host "Could not identify PE source drive.`n`n"
    [void](Read-Host 'Press Enter to quit the program...')
    Exit
}
$availableLetters = [char[]]([int][char]'A'..[int][char]'Z') | Where {$originalDrives -NotContains $_}
if ($availableLetters.Length -lt 2) {
    Clear-Host
    Write-Host "Insufficient drive letters available.`n`n"
    [void](Read-Host 'Press Enter to quit the program...')
    Exit
}
$windowsDrive = $availableLetters[-1]
$systemDrive = $availableLetters[-2]

#
# Prompt for a disk to install to
#
do {
    Clear-Host
    Write-Host "Select the disk to install to.`nWARNING: THE SELECTED DISK WILL BE ERASED`n`n"
    $disks | Format-Table -Property Number,FriendlyName,Size
    $input = Read-Host "Enter DiskNumber of disk to erase and install to"
    if ($disks.Number -contains $input) {
        $disk = [int]$input
    }
} while ($disk -eq -1)

#
# Obtain a valid system name.
# System name must be lower case alphanumeric
# If NICs are found, option given to set system name to MAC address
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
            $options += New-Object PsObject -Property @{ Option=$counter; Description="Enter A Custom Name"; MAC=""}
            do {
                Clear-Host
                Write-Host "Select NIC whose MAC will be system name, or select ${counter} for custom`n"
                $options | Format-Table Option, Description, MAC | Format-Wide
                $input = Read-Host "Enter option number (1-${counter})"
                if ($input -ne ($input -as [int])) {
                    $input = $null
                }
            } until(($input -ge 1) -and ($input -le $counter))
            if ($input -ne $counter) {
                [string]$name = $options[$input - 1].MAC
                $name = $name -replace '[^a-fA-F0-9]'
                $name = $name.ToLower()
                if ($name.length -ne 12) {
                    $name = "*"
                }
            }
        }
    }
}
if ($name -eq "*") {
    do {
        Clear-Host
        $input = Read-Host "Enter system name (1-15 lower case alphanumeric characters)"
        $test = $input
        $test = $test -replace '[^a-zA-Z0-9]'
        $test = $test.ToLower()
        if (($input -ceq $test) -and (($input.length -ge 1) -and ($input.length -le 15))) {
            $name = $input
        }
    }
    until($name -ne "*")
}

Clear-Host

#
# Setup disk to receive image
#
Clear-Disk -Number $disk -RemoveData -RemoveOEM -Confirm:$false -ErrorAction SilentlyContinue | Out-Null

Initialize-Disk $disk -PartitionStyle GPT | Out-Null
New-Partition -DiskNumber $disk -Size 314572800 -DriveLetter $systemDrive -GptType "{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}" | Format-Volume -FileSystem FAT32 | Out-Null
New-Partition -DiskNumber $disk -Size 16777216 -GptType "{e3c9e316-0b5c-4db8-817d-f92df00215ae}" | Out-Null
New-Partition -DiskNumber $disk -DriveLetter $windowsDrive -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Windows" | Out-Null
$originalSize = (Get-PartitionSupportedSize -DiskNumber $disk -PartitionNumber 3).SizeMax
Resize-Partition -DiskNumber $disk -PartitionNumber 3 -Size ($originalSize - 555MB)
New-Partition -DiskNumber $disk -Size 550MB -GptType "{de94bba4-06d1-4d40-a16a-bfd50179d6ac}" | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Recovery" | Out-Null
Write-Host "Completed configuration of destination disk"

#
# Clone image to destination disk
#
dism /apply-image /imagefile:"${peDrive}:\Images\Windows21H1ProEFI64SysprepWindows.swm" /swmfile:"${peDrive}:\Images\Windows21H1ProEFI64SysprepWindows*.swm" /index:1 /applydir:"${windowsDrive}:\"
iex "${windowsDrive}:\Windows\System32\bcdboot ${windowsDrive}:\Windows /s ${systemDrive}: /f UEFI"
Write-Host "Applied image to destination disk"

#
# Set system name
#
$unattendPath = "${windowsDrive}:\Windows\Panther\unattend.xml"
[xml]$xml = Get-Content $unattendPath
$xmlNameSpace = $xml.DocumentElement.NamespaceURI
$nameElement = $xml.CreateElement("ComputerName", $xmlNameSpace)
$nameText = $xml.CreateTextNode($name)
$nameElement.AppendChild($nameText) | Out-Null
$xml.unattend.settings.component.AppendChild($nameElement) | Out-Null
$xml.Save($unattendPath) | Out-Null
Write-Host "System name set to ${name}`nCompleted automated configuration`n"
