$Users = Get-ADUser -Filter * -Properties Title | Select SamAccountName, Title

ForEach ($User in $Users) {
    if($User.Title -eq 'Director Productie'){
        Add-ADGroupMember -Identity Productie-VP-GG -Members $($User.SamAccountName)
        Add-ADGroupMember -Identity Directie-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Productie-VP-GG & Directie-GG"
    }elseif($User.Title -eq 'Director Logistiek'){
        Add-ADGroupMember -Identity Logistiek-VP-GG -Members $($User.SamAccountName)
        Add-ADGroupMember -Identity Directie-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Logistiek-VP-GG & Directie-GG"
    }elseif($User.Title -eq 'Director Onderzoek'){
        Add-ADGroupMember -Identity Onderzoek-VP-GG -Members $($User.SamAccountName)
        Add-ADGroupMember -Identity Directie-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Onderzoek-VP-GG & Directie-GG"
    }elseif($User.Title -eq 'CEO'){
        Add-ADGroupMember -Identity Marketing-VP-GG -Members $($User.SamAccountName)
        Add-ADGroupMember -Identity Directie-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Marketing-VP-GG & Directie-GG"
    }elseif($User.Title -eq 'Boekhouder'){
        Add-ADGroupMember -Identity Boekhouding-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Boekhouding-GG"
    }elseif($User.Title -eq 'Planner'){
        Add-ADGroupMember -Identity Logistiek-MW-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Logistiek-MW-GG"
    }elseif($User.Title -eq 'Marketeer'){
        Add-ADGroupMember -Identity Marketing-MW-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Marketing-MW-GG"
    }elseif($User.Title -eq 'Onderzoeker'){
        Add-ADGroupMember -Identity Onderzoek-MW-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Onderzoek-MW-GG"
    }elseif($User.Title -eq 'Interimmedewerker'){
        Add-ADGroupMember -Identity Productie-MW-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Productie-MW-GG"
    }elseif($User.Title -eq 'Teamleider'){
        Add-ADGroupMember -Identity Productie-TL-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Productie-TL-GG & Productie-MW-GG"
    }elseif($User.Title -eq 'Productiemedewerker'){
        Add-ADGroupMember -Identity Productie-MW-GG -Members $($User.SamAccountName)
        Write-Output "User added to group Productie-MW-GG"
    }

}
