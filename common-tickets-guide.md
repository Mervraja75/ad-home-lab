# Common AD Help Desk Tickets Guide

A reference guide for the most common Active Directory help desk scenarios. Based on a home lab built with Windows Server 2022 and corp.local domain.

---

## Ticket 1 — User Locked Out

**Scenario:** A user calls saying they can't log in and their account is locked out.

**Cause:** Too many failed login attempts (enforced by Password Policy GPO).

**How to verify:**
```powershell
Get-ADUser -Identity "username" -Properties LockedOut | Select-Object Name, LockedOut
```

**How to fix:**
```powershell
Unlock-ADAccount -Identity "username"
```

**How to confirm it worked:**
```powershell
Get-ADUser "username" -Properties LockedOut | Select-Object Name, LockedOut
```
Expected output: `LockedOut : False`

**Best practice:** Always verify the account is unlocked after running the command. Ask the user to try logging in immediately after.

---

## Ticket 2 — User Forgot Password / Password Reset

**Scenario:** A user calls saying they forgot their password or their password has expired.

**How to reset the password:**
```powershell
Set-ADAccountPassword -Identity "username" -NewPassword (ConvertTo-SecureString "TempPassword123!" -AsPlainText -Force) -Reset
```

**Force user to change password at next login:**
```powershell
Set-ADUser -Identity "username" -ChangePasswordAtLogon $true
```

**Combined script (reset + unlock in one go):**
```powershell
Set-ADAccountPassword -Identity "username" -NewPassword (ConvertTo-SecureString "TempPassword123!" -AsPlainText -Force) -Reset
Set-ADUser -Identity "username" -ChangePasswordAtLogon $true
Unlock-ADAccount -Identity "username"
Get-ADUser "username" -Properties LockedOut | Select-Object Name, LockedOut
```

**Best practice:** Always give the user a temporary password and force them to change it at next login for security. Never reuse old passwords.

---

## Ticket 3 — Join a Computer to the Domain

**Scenario:** A new computer needs to be joined to the corp.local domain.

**Prerequisites:**
- Computer has a static or DHCP IP address
- DNS is pointing to the Domain Controller (192.168.10.1)
- You have Domain Admin credentials

**Step 1 — Verify DNS is working:**
```powershell
Resolve-DnsName corp.local
```
Expected output: corp.local resolving to 192.168.10.1

**Step 2 — Join the domain:**
1. Press **Win + R** → type `sysdm.cpl` → Enter
2. Click **Change** under Computer Name tab
3. Select **Domain** → type `corp.local`
4. Enter Domain Admin credentials when prompted
5. Click **OK** → Restart the computer

**Step 3 — Verify domain join:**
After restart, log in with:
- Username: `corp\username`
- Password: user's domain password

**Step 4 — Force Group Policy to apply:**
```powershell
gpupdate /force
```

**Step 5 — Verify GPOs are applying:**
```powershell
gpresult /r
```

**Best practice:** Always run `gpupdate /force` and `gpresult /r` after joining a computer to the domain to confirm Group Policies are applying correctly.

---

## Quick Reference — Useful PowerShell Commands

| Task | Command |
|---|---|
| Check if account is locked | `Get-ADUser -Identity "username" -Properties LockedOut` |
| Unlock account | `Unlock-ADAccount -Identity "username"` |
| Reset password | `Set-ADAccountPassword -Identity "username" -NewPassword (ConvertTo-SecureString "Password" -AsPlainText -Force) -Reset` |
| Force password change at logon | `Set-ADUser -Identity "username" -ChangePasswordAtLogon $true` |
| Check all users in domain | `Get-ADUser -Filter * \| Select-Object Name, SamAccountName` |
| Force GPO update | `gpupdate /force` |
| Check applied GPOs | `gpresult /r` |
| Check DNS resolution | `Resolve-DnsName corp.local` |

---

*Built as part of an Active Directory Home Lab project using VMware Workstation Pro 25H2, Windows Server 2022, and Windows 11.*
