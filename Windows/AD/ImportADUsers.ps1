<#
    .SYNOPSIS
    Import-ADUsers.ps1

    .DESCRIPTION
    Import Active Directory users from CSV file.

    .LINK
    alitajran.com/import-ad-users-from-csv-powershell

    .NOTES
    Written by: ALI TAJRAN
    Website:    alitajran.com
    LinkedIn:   linkedin.com/in/alitajran

    .CHANGELOG
    V1.00, 04/24/2023 - Initial version
    V1.10, 10/14/2023 - Improvement catch block
#>

New-ADObject -Name "MOOS" -Type "container" -Path "DC=ad,DC=moos,DC=internal"
New-ADObject -Name "Users" -Type "container" -Path "OU=MOOS,DC=ad,DC=moos,DC=internal"

New-ADOrganizationalUnit -Name "Directie" -Path "OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "Onderzoek" -Path "OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "Productie" -Path "OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "Logistiek" -Path "OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "Marketing" -Path "OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"
New-ADOrganizationalUnit -Name "Boekhouding" -Path "OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"

New-ADUser -Name "Jeroen Moos" -GivenName "Jeroen" -Surname "Moos" -SamAccountName "jeroen.moos" -AccountPassword (ConvertTo-SecureString -AsPlainText “Vdab3001” -Force) -ChangePasswordAtLogon $False -Company "Brouwerij Moos" -Title "CEO" -City "Oostrozebeke" -Department "Directie" -DisplayName "Jeroen Moos" -Country "BE" -PostalCode "8780" -Enabled $True -Path "OU=Directie,OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"

New-ADUser -Name "Piet Huysenbrouwer" -GivenName "Piet" -Surname "Huysenbrouwer" -SamAccountName "piet.huysenbrouwer" -AccountPassword (ConvertTo-SecureString -AsPlainText “Vdab3001” -Force) -ChangePasswordAtLogon $False -Company "Brouwerij Moos" -Title "Director Onderzoek" -City "Oostrozebeke" -Department "Directie" -DisplayName "Piet Huysenbrouwer" -Country "BE" -PostalCode "8780" -Enabled $True -Path "OU=Directie,OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"

New-ADUser -Name "Angela Moos" -GivenName "Angela" -Surname "Moos" -SamAccountName "angela.moos" -AccountPassword (ConvertTo-SecureString -AsPlainText “Vdab3001” -Force) -ChangePasswordAtLogon $False -Company "Brouwerij Moos" -Title "Director Productie" -City "Oostrozebeke" -Department "Directie" -DisplayName "Angela Moos" -Country "BE" -PostalCode "8780" -Enabled $True -Path "OU=Directie,OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"

New-ADUser -Name "Hop Karlsberg" -GivenName "Hop" -Surname "Karlsberg" -SamAccountName "hop.karlsberg" -AccountPassword (ConvertTo-SecureString -AsPlainText “Vdab3001” -Force) -ChangePasswordAtLogon $False -Company "Brouwerij Moos" -Title "Director Logistiek" -City "Oostrozebeke" -Department "Directie" -DisplayName "Hop Karlsberg" -Country "BE" -PostalCode "8780" -Enabled $True -Path "OU=Directie,OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"



# Define the CSV file location and import the data
$Csvfile = "C:\temp\ImportADUsers.csv"
$Users = Import-Csv $Csvfile

# Import the Active Directory module
Import-Module ActiveDirectory

# Loop through each user
foreach ($User in $Users) {
    $Name = $User.'First name' + " " + $User.'Last name'
$Name
    $GivenName = $User.'First name'
$GivenName
    $Surname = $User.'Last name'
$Surname
    $DisplayName = $User.'First name' + " " + $User.'Last name'
$DisplayName 
    $SamAccountName = $User.'First name' + "." + $User.'Last name'
$SamAccountName 
    $UserPrincipalName = $User.'First name' + "." + $User.'Last name' + "@ad.moos.internal"
$UserPrincipalName 
    $StreetAddress = $User.'Street'
$StreetAddress 
    $City = $User.'City'
$City 
    $State = $User.'State/province'
$State 
    $PostalCode = $User.'Zip/Postal Code'
$PostalCode 
    $Country = $User.'Country/region'
$Country 
    $JobTitle = $User.'Job Title'
$JobTitle 
    $Department = $User.'Department'
$Department 
    $Company = $User.'Company'
$Company 
    $ManagerDisplayName = $User.'Manager'
$ManagerDisplayName 
    $Manager = if ($ManagerDisplayName) {
        Get-ADUser -Filter "DisplayName -eq '$ManagerDisplayName'" -Properties DisplayName |
        Select-Object -ExpandProperty DistinguishedName
    }
$Manager 
    $OU = "OU=" + $User.'Department' + ",OU=Users,OU=MOOS,DC=ad,DC=moos,DC=internal"
$OU 
    $Description = $User.'Description'
$Description 
    $Office = $User.'Office'
$Office 
    $TelephoneNumber = $User.'Telephone number'
$TelephoneNumber 
    $Email = $User.'E-mail'
$Email 
    $Mobile = $User.'Mobile'
$Mobile 
    $Notes = $User.'Notes'
$Notes 
    $AccountStatus = $User.'Account status'
$AccountStatus

    # Check if the user already exists in AD
    $UserExists = Get-ADUser -Filter { SamAccountName -eq $SamAccountName } -ErrorAction SilentlyContinue

    if ($UserExists) {
        Write-Warning "User '$SamAccountName' already exists in Active Directory."
        continue
    }

    # Create new user parameters
    $NewUserParams = @{
        Name                  = $Name
        GivenName             = $GivenName
        Surname               = $Surname
        DisplayName           = $DisplayName
        SamAccountName        = $SamAccountName
        UserPrincipalName     = $UserPrincipalName
        StreetAddress         = $StreetAddress
        City                  = $City
        State                 = $State
        PostalCode            = $PostalCode
        Country               = $Country
        Title                 = $JobTitle
        Department            = $Department
        Company               = $Company
        Manager               = $Manager
        Path                  = $OU
        Description           = $Description
        Office                = $Office
        OfficePhone           = $TelephoneNumber
        EmailAddress          = $UserPrincipalName
        MobilePhone           = $Mobile
        AccountPassword       = (ConvertTo-SecureString "Vdab3001" -AsPlainText -Force)
        Enabled               = if ($AccountStatus -eq "Enabled") { $true } else { $false }
        ChangePasswordAtLogon = $false # Set the "User must change password at next logon" flag
    }

    # Add the info attribute to OtherAttributes only if Notes field contains a value
    if (![string]::IsNullOrEmpty($Notes)) {
        $NewUserParams.OtherAttributes = @{info = $Notes }
    }

    try {
        # Create the new AD user
        New-ADUser @NewUserParams
        Write-Host "User $SamAccountName created successfully." -ForegroundColor Cyan
    }
    catch {
        # Failed to create the new AD user
        $ErrorMessage = $_.Exception.Message
        if ($ErrorMessage -match "The password does not meet the length, complexity, or history requirement") {
            Write-Warning "User $SamAccountName created but account is disabled. $_"
        }
        else {
            Write-Warning "Failed to create user $SamAccountName. $_"
        }
    }
}
