Import-Module ActiveDirectory
$users = Import-Csv "C:\Scripts\users.csv"
foreach ($user in $users) {
    New-ADUser -Name "$($user.FirstName) $($user.LastName)" -GivenName $user.FirstName -Surname $user.LastName -SamAccountName $user.Username -UserPrincipalName "$($user.Username)@corp.local" -Path "OU=$($user.Department),DC=corp,DC=local" -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
}