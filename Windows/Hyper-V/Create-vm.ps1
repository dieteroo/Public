 #--------------------------------------------------------------------------#
#- Created by:             Dieter Oosterbaan                              -#
#- Version:                1.3                                            -#
#--------------------------------------------------------------------------#
# Change Log                                                              -#
# 25 October 2023          Initial Script for Windows Server 2022         -#
# 10 November 2023         Added workstation or server choice             -#
# 10 November 2023         Added second HDD for server                    -#
# 10 November 2023         Computername prompt name standardization       -#
#--------------------------------------------------------------------------#

#-------------#
#- Variables -#
#-------------#

$ParentDir = 'C:\Virtual_Machines'
$Switch = 'ExternalVirtualSwitch'

 #---------------------------#
#- Prompt for computername -#
#---------------------------#
Write-Host "VM-WIN-S- or VM-WIN-W- will be added automagically" -ForegroundColor Yellow
$VMName = Read-Host -Prompt 'Input your desired name for the virtual machine' 

#-------------------------#
#- Workstation or server -#  
#-------------------------#
$envChoice = [System.Management.Automation.Host.ChoiceDescription[]](@(
    (New-Object System.Management.Automation.Host.ChoiceDescription("&Workstation", "Virtual workstation environment")),
    (New-Object System.Management.Automation.Host.ChoiceDescription("&Server", "Virtual server environment"))
))
 $environment = $Host.Ui.PromptForChoice("Environment", "Choose the target environment", $envChoice, 0)

if($environment -eq 0) {
    $VMName = "VM-WIN-Ws-" + $VMName 
    $Memory = 8GB
    $Processor = 1
    $HDD = 30GB
    $Image = 'C:\Iso\en-us_windows_10_consumer_editions_version_22h2_x64_dvd_8da72ab3.iso'
}

if($environment -eq 1) {
    $VMName = "VM-WIN-Ser-" + $VMName
    $Memory = 12GB
    $Processor = 2
    $HDD = 50GB
    $HDD2 = 50GB
    $Image = 'C:\Iso\en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso'
} 

#-------------------------------------------#
#- create a directory for virtual machines -#
#-------------------------------------------#
if (Test-Path $ParentDir) {
    Write-Host $ParentDir " folder exists" 
}
else {
    New-Item $ParentDir -ItemType Directory
    Write-Host $ParentDir " folder created successfully" 
}

#------------------------------------------#
#- check if VM with identical name exists -#
#------------------------------------------#
if (Test-Path $ParentDir\$VMName) {
    Write-Host "Folder" $ParentDir\$VMName "exists - VM Exists" 
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
-MemoryStartupBytes $Memory `
-Generation 1 `
-NewVHDPath "$ParentDir\$VMName\$VMName-Disk01.vhdx" `
-NewVHDSizeBytes $HDD `
-Path "$ParentDir\$VMName" `
-SwitchName $Switch 

#--------------------------------------#
#- create & add second HDD for server -#
#--------------------------------------#
If ($environment -eq 1) {
    New-VHD -SizeBytes $HDD2 `
    -Path “$ParentDir\$VMName\$VMName-Disk02.vhdx”
    Add-VMHardDiskDrive -VMName $VMName `
    -Path “$ParentDir\$VMName\$VMName-Disk02.vhdx” `
    -ControllerType IDE -ControllerNumber 0 -ControllerLocation 1
}

#-------------------------#
#- disable DynamicMemory -#
#-------------------------#
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $false

#---------------------#
#- change vCPU count -#
#---------------------#
Set-VMProcessor $VMName -Count $Processor 

#-------------------------#
#- Remove SCSI controler -#
#-------------------------#
Get-VMScsiController -VMName $VMName -ControllerNumber 0 | Remove-VMScsiController

#---------------------#
#- set install image -#
#---------------------#
Set-VMDvdDrive -VMName $VMName `
-Path $Image 

#---------------------------------#
#- disable Automatic Checkpoints -#
#---------------------------------#
Set-VM -VMName $VMName -AutomaticCheckpointsEnabled $False

#-----------------------------#
#- start the virtual machine -#
#-----------------------------#
Start-VM -Name $VMName  
 
