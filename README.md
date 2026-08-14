# Active Directory Home Lab

A fully functional Active Directory environment built from scratch on a personal laptop using VMware Workstation Pro. This project simulates a small business IT infrastructure and documents the process of setting up, configuring, and managing an AD domain.

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| VMware Workstation Pro 25H2 | Virtualization platform |
| Windows Server 2022 Standard Evaluation | Domain Controller OS |
| Windows 11 Enterprise Evaluation | Client machine OS |
| Active Directory Domain Services (AD DS) | Directory service |
| DNS Server | Name resolution for the domain |
| Group Policy (GPO) | Centralized policy management |
| PowerShell | Automation and user management |

---

## Lab Environment

| Component | Details |
|---|---|
| Domain Name | corp.local |
| Domain Controller | DC01 |
| Client Machine | CLIENT01 |
| DC IP Address | 192.168.10.1 |
| Client IP Address | 192.168.10.10 |
| OS | Windows Server 2022 Standard (Desktop Experience) |
| DC RAM | 4GB |
| DC Disk | 80GB |

---

## What I Built

### 1 — Domain Controller Setup
- Installed and configured VMware Workstation Pro 25H2
- Created a Windows Server 2022 VM (DC01)
- Set a static IP address and renamed the server to DC01
- Installed the AD DS role and promoted the server to a Domain Controller
- Created the domain `corp.local`
- Built an Organizational Unit (OU) structure modeled after a small company:
  - IT
  - HR
  - Finance
  - Sales
- Created user accounts in each OU:

| Name | Username | Department |
|---|---|---|
| John Smith | jsmith | IT |
| Sarah Jones | sjones | HR |
| Mike Brown | mbrown | Finance |
| Lisa Taylor | ltaylor | Sales |

### 2 — Security Groups, Windows 11 Client & GPOs
- Created security groups for each department (IT-Team, HR-Team, Finance-Team, Sales-Team)
- Assigned users to their respective security groups
- Set up a Windows 11 VM (CLIENT01) with static IP
- Joined CLIENT01 to the corp.local domain
- Logged in as a domain user (corp\jsmith) on CLIENT01
- Built and deployed Group Policy Objects (GPOs):
  - Password Policy — enforcing complexity and expiration
  - Desktop Wallpaper — pushed company wallpaper to all domain machines
  - Control Panel Restriction — blocked standard users from accessing Control Panel
- Verified GPOs applying with `gpresult /r`

### 3 — PowerShell Automation
- Bulk created 5 users from a CSV file using PowerShell — 5 users created in under 5 seconds!
- Built a combined password reset + account unlock script
- Diagnosed and fixed a User Policy GPO issue using `nslookup` and `Resolve-DnsName`
- Verified all GPOs applied correctly using `gpresult /r`

| Name | Username | Department |
|---|---|---|
| Daniel Smith | dsmith | IT |
| Brad Johnson | bjohnson | HR |
| Charles Xavier | cxavier | Finance |
| Michael Jordan | mjordan | Sales |
| Sarah Williams | swilliams | IT |

### 4 — NTFS Permissions & Portfolio Polish
- Created a shared folder (CompanyShare) on DC01
- Tested NTFS vs Share permissions with different users:
  - jsmith (IT-Team) — Read via Share, Full Control via NTFS → Read only (most restrictive wins)
  - sjones (HR) — Read via Share, No NTFS → Can see folder but blocked from opening files
- Documented results in a permissions table
- Wrote Common AD Help Desk Tickets Guide
- Published project to GitHub

---

## PowerShell Scripts

### Bulk User Creation — CreateUsers.ps1
```powershell
Import-Module ActiveDirectory
$users = Import-Csv "C:\Scripts\users.csv"
foreach ($user in $users) {
    New-ADUser -Name "$($user.FirstName) $($user.LastName)" -GivenName $user.FirstName -Surname $user.LastName -SamAccountName $user.Username -UserPrincipalName "$($user.Username)@corp.local" -Path "OU=$($user.Department),DC=corp,DC=local" -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
}
```

### Password Reset + Account Unlock — ResetUnlockUser.ps1
```powershell
Set-ADAccountPassword -Identity "username" -NewPassword (ConvertTo-SecureString "NewPassword123!" -AsPlainText -Force) -Reset
Set-ADUser -Identity "username" -ChangePasswordAtLogon $true
Unlock-ADAccount -Identity "username"
Get-ADUser "username" -Properties LockedOut | Select-Object Name, LockedOut
```

---

## NTFS vs Share Permissions — Test Results

| User | Share Permission | NTFS Permission | Expected | Actual |
|---|---|---|---|---|
| jsmith (IT) | Read | Full Control | Read only | ✅ Read only |
| sjones (HR) | Read | None | Read only | ✅ Read only |
| sjones (HR) | Read | No file access | Blocked | ✅ Can see but can't open file |

**Key takeaway:** When Share and NTFS permissions conflict, the most restrictive permission wins.

---

## GPOs Created

| GPO Name | Type | Effect |
|---|---|---|
| Password Policy | Computer | Enforces complexity, 90 day expiration, 8 char minimum |
| Desktop Wallpaper | User | Pushes company wallpaper to all domain machines |
| Restrict Control Panel | User | Blocks standard users from accessing Control Panel |

---

## Lab Topology

![AD Lab Topology](./screenshots/lab-topology.png)

---

## Screenshots

| Screenshot | Description |
|---|---|
| ![Server Manager](./screenshots/server-manager.png) | Server Manager with AD DS role installed |
| ![AD Users and Computers](./screenshots/ad-users-computers.png) | AD Users and Computers showing corp.local domain |
| ![OU Structure](./screenshots/ou-structure.png) | Organizational Unit structure with all users |
| ![GPO Results](./screenshots/gpresult.png) | gpresult /r showing all GPOs applied |
| ![Control Panel Blocked](./screenshots/control-panel-blocked.png) | Control Panel blocked by GPO |
| ![Bulk Users](./screenshots/bulk-users.png) | PowerShell bulk user creation output |

---

## Key Concepts Learned

- How Active Directory Domain Services works behind the scenes
- Kerberos authentication and how domain login works
- Difference between OUs, security groups, and distribution groups
- How DNS integrates with Active Directory
- Static IP configuration for a Domain Controller
- How Group Policy Objects (GPOs) are applied to OUs
- NTFS vs Share permissions and how they interact
- PowerShell automation for common AD tasks
- Real-world troubleshooting with gpresult and Resolve-DnsName
- Real-world naming conventions (DC01, corp.local, jsmith)

---

## Files in this Repo

| File | Description |
|---|---|
| README.md | Project overview and documentation |
| CreateUsers.ps1 | Bulk user creation from CSV |
| ResetUnlockUser.ps1 | Password reset and account unlock script |
| users.csv | Sample CSV file for bulk user creation |
| common-tickets-guide.md | Common AD help desk tickets reference guide |

---

## Author

**Mervin Raja**
IT Support | Active Directory | Cloud | Full Stack Development
[LinkedIn](https://www.linkedin.com/in/) | [GitHub](https://github.com/)
