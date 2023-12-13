Import-Module ActiveDirectory

New-ADObject -Name "Groups" -Type "container" -Path "OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "GlobalGroups" -Path "OU=Groups,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "DomainLocalGroups" -Path "OU=Groups,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "UniversalGroups" -Path "OU=Groups,OU=MOOS,DC=ad,DC=moos,DC=internal"

#Import CSV
$groups = Import-Csv ‘C:\temp\ImportADGroups.csv‘

# Loop through the CSV
    foreach ($group in $groups) {

    $groupProps = @{

      Name          = $group.name
      Path          = $group.path
      GroupScope    = $group.scope
      GroupCategory = $group.category
      Description   = $group.description

      }#end groupProps

    New-ADGroup @groupProps
    
} #end foreach loop
