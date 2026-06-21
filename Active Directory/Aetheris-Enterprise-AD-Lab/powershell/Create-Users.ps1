$domain = "DC=aetheris,DC=local"

Import-Csv "C:\Users\Administrator\Documents\users.csv" | ForEach-Object {

$ou = switch ($_.Department) {
    "Operations" { "OU=Operations,OU=User,$domain" }
    "Management" { "OU=Management,OU=User,$domain" }
}

New-ADUser `
-Name "$($_.FirstName) $($_.LastName)" `
-GivenName $_.FirstName `
-Surname $_.LastName `
-SamAccountName $_.Username `
-UserPrincipalName "$($_.Username)@aetheris.local" `
-Path $ou `
-AccountPassword (ConvertTo-SecureString "StrongPassw0rd?" -AsPlainText -Force) `
-Enabled $true `
-ChangePasswordAtLogon $false
}
