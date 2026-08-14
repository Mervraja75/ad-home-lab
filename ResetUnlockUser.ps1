Set-ADAccountPassword -Identity "username" -NewPassword (ConvertTo-SecureString "NewPassword123!" -AsPlainText -Force) -Reset
Set-ADUser -Identity "username" -ChangePasswordAtLogon $true
Unlock-ADAccount -Identity "username"
Get-ADUser "username" -Properties LockedOut | Select-Object Name, LockedOut