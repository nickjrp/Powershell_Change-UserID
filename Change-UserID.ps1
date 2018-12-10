Get-ADUser -filter * | Select SAMAccountName


FINDS ALL USERS WITH A SPACE in THE SAMACCOUNTNAME
get-aduser -filter {samaccountname -like "* *"} | ft

FINDS ALL ACTIVE USERS WITH A SPACE in THE SAMACCOUNTNAME
get-aduser -filter {(samaccountname -like "* *") -and (enabled -eq $TRUE)} | ft

FINDS ALL ACTIVE USERS WITH A SPACE in THE SAMACCOUNTNAME and NO SURNAME
get-aduser -filter {(samaccountname -like "* *") -and (enabled -eq $TRUE) -and (surname -like "*")} | select -first 10 | Format-Table

TO GET ALL AD PROPERTIES
get-aduser -identity <SAMAccountname> -properties *

CODE FOUND ONLINE
$ADUserList = Import-CSV C:\scripts\ADUserList.csv

foreach ($User in $ADUserList)
{
    $csvusername = $user.samaccountname
    $csvuserprincipalname = $user.userprincipalname
    Get-ADUser $($user.Userid) | Set-Aduser -SamAccountName $csvusername -      
    UserPrincipalName $csvuserprincipalname
}

EDITED CODE FOUND ONLINE
$ADUserList = Import-CSV C:\scripts\ADUserList.csv

foreach ($User in $ADUserList)
{
    $csvusername = $user.samaccountname
    
    Get-ADUser $($user.Userid) | Set-Aduser -SamAccountName $csvusername
}

TO EXPORT LIST BUT DOES NOT INCLUDE EMAIL ADDRESS
get-aduser -filter {(samaccountname -like "* *") -and (enabled -eq $TRUE) -and (surname -like "*")} | select Givenname,surname,samaccountname,emailaddress | Export-Csv C:\Users\admnjp\Desktop\UsersWithSpace.csv