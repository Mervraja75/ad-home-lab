# Active Directory Home Lab

A fully functional Active Directory environment built from scratch on a personal laptop using VMware Workstation Pro. This project simulates a small business IT infrastructure and documents the process of setting up, configuring, and managing an AD domain.

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| VMware Workstation Pro 25H2 | Virtualization platform |
| Windows Server 2022 Standard Evaluation | Domain Controller OS |
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
| DC IP Address | 192.168.10.1 |
| OS | Windows Server 2022 Standard (Desktop Experience) |
| RAM | 4GB |
| Disk | 80GB |

---

## What I Built

### Day 1 — Domain Controller Setup
- Installed and configured VMware Workstation Pro 25H2
- Created a Windows Server 2022 VM (DC01)
- Set a static IP address and renamed the server
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

### Day 2 — Groups, Windows 10 Client & GPOs *(in progress)*
- Creating security groups and assigning users
- Joining a Windows 10 client to the domain
- Building Group Policy Objects (GPOs):
  - Password policy
  - Desktop wallpaper enforcement
  - Mapped network drive

### Day 3 — PowerShell Automation *(upcoming)*
- Bulk user creation via PowerShell
- Password reset and account unlock automation scripts
- Common AD help desk ticket automation

### Day 4 — Portfolio Polish *(upcoming)*
- Network/AD diagram
- GitHub documentation
- LinkedIn writeup

---

## Lab Topology

![AD Lab Topology](./screenshots/lab-topology.png)

---

## Screenshots

| Screenshot | Description |
|---|---|
| ![Server Manager](./screenshots/server-manager.png) | Server Manager with AD DS role installed |
| ![AD Users and Computers](./screenshots/ad-users-computers.png) | AD Users and Computers showing corp.local domain |
| ![OU Structure](./screenshots/ou-structure.png) | Organizational Unit structure |

---

## Key Concepts Learned

- How Active Directory Domain Services works
- Difference between OUs, security groups, and distribution groups
- How DNS integrates with Active Directory
- Static IP configuration for a Domain Controller
- How Group Policy Objects (GPOs) are applied to OUs
- Real-world naming conventions (DC01, corp.local, jsmith)

---

## What's Next

- Join a Windows 10 client to the domain
- Build and test Group Policy Objects
- Automate user management with PowerShell
- Set up Azure AD Connect (hybrid identity)

---

## Author

**Mervin Raja**
IT Support | Cloud | Full Stack Development

---

*This lab is built for learning and portfolio purposes. All evaluation software is used within Microsoft's free evaluation terms.*
