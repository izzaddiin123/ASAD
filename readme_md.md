# ASAD Environment (Arm Security Active Directory)

An automated Active Directory attack & defense training environment featuring real-world security misconfigurations, Kerberos attacks, ACL abuse, and delegation flaws built with Ansible and Vagrant.

---

## 💻 Hardware & System Requirements

To run the ASAD lab smoothly on a local host system (using VirtualBox, Hyper-V, or VMware), ensure your system meets the following specifications:

| Metric | Minimum Requirement | Recommended Requirement |
| :--- | :--- | :--- |
| **CPU** | 4 Cores (x86_64) | 8+ Cores with VT-x/AMD-V enabled |
| **RAM** | 8 GB Free RAM | 16 GB+ RAM |
| **Storage** | 40 GB Free SSD Space | 60 GB+ High-Speed NVMe SSD |
| **Hypervisor** | VirtualBox 7.x / VMware Workstation | VirtualBox 7.x or Proxmox VE |
| **Host OS** | Windows 10/11, macOS (x86), Linux | Linux (Ubuntu/Debian) or Windows 11 |

### Virtual Machine Resource Allocation

| Machine Name | Role | OS | IP Address | RAM | vCPUs |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `ASAD-DC01` | Domain Controller | Windows Server 2022 | `192.168.56.10` | 4 GB | 2 |
| `ASAD-WS01` | Domain Workstation | Windows 10/11 Pro | `192.168.56.20` | 2 GB | 2 |

---

## 🛠️ Prerequisites & Tools Needed

Make sure you have installed the following dependencies on your host control node before deploying:

- **[Vagrant](https://www.vagrantup.com/downloads)** (v2.3+)
- **[VirtualBox](https://www.virtualbox.org/)** (v7.0+)
- **[Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)** (v2.12+)
- **[pywinrm](https://github.com/diyan/pywinrm)** (Required for Ansible WinRM connectivity):
  ```bash
  pip install pywinrm
  ```

---

## 🚀 Deployment Guide

### Option 1: Automated Deployment via Ansible

1. **Clone the repository:**
   ```bash
   git clone https://github.com/armwq/asad.git
   cd asad
   ```

2. **Boot the base Virtual Machines:**
   ```bash
   vagrant up
   ```

3. **Verify WinRM Connectivity:**
   ```bash
   ansible all -i ansible/inventory.ini -m win_ping
   ```

4. **Execute the Provisioning Playbook:**
   ```bash
   ansible-playbook -i ansible/inventory.ini ansible/site.yml
   ```

---

### Option 2: Manual Provisioning (Step-by-Step)

If deploying on standard standalone VMs without Vagrant:

1. Deploy **ASAD-DC01** (`192.168.56.10`) and **ASAD-WS01** (`192.168.56.20`) on a isolated VirtualBox Host-Only Network.
2. Open PowerShell as Administrator on both machines and execute the bootstrap script:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1
   ```
3. Run the Ansible playbook from your Linux host/attacker machine:
   ```bash
   ansible-playbook -i ansible/inventory.ini ansible/site.yml
   ```

---

## 🎯 Included Vulnerabilities & Attack Paths

This lab environment contains the following pre-configured vulnerability paths:

1. **AS-REP Roasting:**
   - Target User: `j.doe` (`DONT_REQ_PREAUTH` enabled)
2. **Kerberoasting:**
   - Target User: `svc_mssql` with SPN `MSSQLSvc/ASAD-DC01.asad.local:1433`
3. **ACL Misconfigurations (GenericAll):**
   - Target Account: `h.technician` (Helpdesk) holds `GenericAll` rights over `Domain Admins`.
4. **Unconstrained Delegation:**
   - Machine Account: `ASAD-WS01$` is configured with `TRUSTED_FOR_DELEGATION`.
5. **Legacy Protocol Exploitation:**
   - LLMNR and NBT-NS enabled for response poisoning and NTLM relaying.

---

## 📝 Student Assessment

A student CTF worksheet is provided in the repository (`/asad/ASAD CTF Student Assessment Worksheet.pdf`). Open it in any modern browser and print/export to PDF to provide students with submission fields for flag collection.