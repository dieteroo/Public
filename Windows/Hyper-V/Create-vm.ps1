#--------------------------------------------------------------------------#
#- Created by:             Dieter Oosterbaan                              -#
#- Version:                1.0                                            -#
#--------------------------------------------------------------------------#
# Change Log                                                              -#
# 25 October 2023          Initial Script for Windows Server 2022         -#
#--------------------------------------------------------------------------#

#-------------#
#- Variables -#         
#-------------#

$ParentDir = 'C:\Virtual_Machines' 
$Switch = ' ExternalVirtualSwitch'
$VMName = Read-Host -Prompt 'Input your server  name'

#-------------------------------------------#
#- create a directory for virtual machines -#
#-------------------------------------------#
if (Test-Path $ParentDir) {
    Write-Host "Folder Exists"
}
else {
    New-Item $ParentDir -ItemType Directory
    Write-Host "Folder Created successfully"
}

#------------------------------------------#
#- check if VM with identical name exists -#
#------------------------------------------#
if (Test-Path $ParentDir\$VMName) {
    Write-Host "VM Exists"
	break
}

#-----------------------------------#
#- Create virtual switch if needed -#
#-----------------------------------#
$ethernet = Get-NetAdapter -Name "Ethernet 5"

If ( ! ( Get-VMSwitch | Where {$_.Name -eq $Switch} ) ) {
    New-VMSwitch -Name $Switch -NetAdapterName $ethernet.Name -AllowManagementOS $True
}

#----------------------------#
#- create a virtual machine -#
#----------------------------#
New-VM -Name $VMName `
-MemoryStartupBytes 12GB `
-Generation 1 `
-NewVHDPath "$ParentDir\$VMName\$VMName.vhdx" `
-NewVHDSizeBytes 50GB `
-Path "$ParentDir\$VMName" `
-SwitchName $Switch 

#-------------------------#
#- disable DynamicMemory -#
#-------------------------#
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $false

#---------------------#
#- change vCPU count -#
#---------------------#
Set-VMProcessor $VMName -Count 4 

#-------------------------#
#- Remove SCSI controler -#
#-------------------------#
Get-VMScsiController -VMName $VMName -ControllerNumber 0 | Remove-VMScsiController

#---------------------#
#- set install image -#
#---------------------#
Set-VMDvdDrive -VMName $VMName `
-Path 'C:\Iso\en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso' 

#---------------------------------#
#- disable Automatic Checkpoints -#
#---------------------------------#
Set-VM -VMName $VMName -AutomaticCheckpointsEnabled $False

#-----------------------------#
#- start the virtual machine -#
#-----------------------------#
Start-VM -Name $VMName 
