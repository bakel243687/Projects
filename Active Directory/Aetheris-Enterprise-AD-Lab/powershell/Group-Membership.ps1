$groupMapping = @{
"IT" = "GG_IT_SHARES"
"HR" = "GG_HR_SHARES"
"Finance" = "GG_FINANCE_SHARES"
"Operations" = "GG_OPERATIONS_SHARES"
"Management" = "GG_MANAGEMENT_SHARES"
}

Import-Csv "C:\Users\Administrator\Documents\users.csv" | ForEach-Object {

$group = $groupMapping[$_.Department]

Add-ADGroupMember -Identity $group -Members $_.Username
}
