$serviceAccounts = @("svc_backup","svc_monitoring","svc_print")

$path = "OU=Service Account,DC=aetheris,DC=local"

foreach ($svc in $serviceAccounts) {
New-ADUser `
-Name $svc `
-SamAccountName $svc `
-Path $path `
-AccountPassword (ConvertTo-SecureString "StrongPass@123" -AsPlainText -Force) `
-Enabled $true `
-PasswordNeverExpires $true
}
