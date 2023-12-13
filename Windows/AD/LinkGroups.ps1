
Add-ADGroupMember -Identity Directie-Directie-RW-UG -Members Directie-GG
Add-ADGroupMember -Identity Logistiek-Logistiek-RW-UG -Members Logistiek-VP-GG, Logistiek-MW-GG
Add-ADGroupMember -Identity Marketing-Marketing-RW-UG -Members Marketing-VP-GG, Marketing-MW-GG
Add-ADGroupMember -Identity Onderzoek-Onderzoek-RW-UG -Members Onderzoek-VP-GG, Onderzoek-MW-GG
Add-ADGroupMember -Identity Productie-Productie-RW-UG -Members Productie-VP-GG, Productie-TL-GG, Productie-MW-GG
Add-ADGroupMember -Identity Directie-Productie-Read-UG -Members Directie-GG
Add-ADGroupMember -Identity Directie-Logistiek-Read-UG -Members Directie-GG
Add-ADGroupMember -Identity Directie-Marketing-Read-UG -Members Directie-GG
Add-ADGroupMember -Identity Directie-Boekhouding-P-RW-UG -Members Directie-GG
Add-ADGroupMember -Identity Boekhouding-Boekhouding-P-RW-UG -Members Boekhouding-GG
Add-ADGroupMember -Identity Teamleaders-ProductiePlanning-P-RW-UG -Members Productie-TL-GG
Add-ADGroupMember -Identity Productie-ProductiePlanning-P-Read-UG -Members Productie-MW-GG

Add-ADGroupMember -Identity Directie-Boekhouding-P-RW-LG -Members Directie-Boekhouding-P-RW-UG, Boekhouding-Boekhouding-P-RW-UG
Add-ADGroupMember -Identity Productie-Productieplanning-P-RW-LG -Members Teamleaders-ProductiePlanning-P-RW-U
Add-ADGroupMember -Identity Productie-Productieplanning-P-Read-LG -Members Productie-ProductiePlanning-P-Read-UG
Add-ADGroupMember -Identity Directie--RW-LG -Members Directie-Directie-RW-UG
Add-ADGroupMember -Identity Logistiek--RW-LG -Members Logistiek-Logistiek-RW-UG
Add-ADGroupMember -Identity Logistiek--Read-LG -Members Directie-Logistiek-Read-UG
Add-ADGroupMember -Identity Marketing--RW-LG -Members Marketing-Marketing-RW-UG
Add-ADGroupMember -Identity Marketing--Read-LG -Members Directie-Marketing-Read-UG
Add-ADGroupMember -Identity Onderzoek--RW-LG -Members Onderzoek-Onderzoek-RW-UG
Add-ADGroupMember -Identity Productie--RW-LG -Members Productie-Productie-RW-UG
Add-ADGroupMember -Identity Productie--Read-LG -Members Directie-Productie-Read-UG
