# ☁️ Azure Infrastructure Automation

Azure infrastructure automation portfolio demonstrating practical cloud infrastructure, security, identity, monitoring, PowerShell automation, and Infrastructure as Code concepts.

> **Portfolio Project:** This repository contains independently developed examples for learning and demonstrating cloud infrastructure engineering concepts. It does not contain confidential, proprietary, credential, or employer-specific information.

---

## Project Objectives

- Automate common Azure infrastructure administration tasks
- Manage and inventory Azure Virtual Machines
- Work with Azure Virtual Networks, subnets, and NSGs
- Manage Azure Storage resources
- Demonstrate Microsoft Entra ID and Azure RBAC
- Demonstrate Azure WAF security concepts
- Use PowerShell for Azure automation
- Demonstrate Infrastructure as Code using Bicep
- Explore Azure Monitor and Log Analytics
- Demonstrate cloud troubleshooting and operational practices

---

## 🏗️ High-Level Architecture

```text
Administrator / Cloud Engineer
            |
            | PowerShell / Bicep
            v
   Azure Management Layer
            |
    +-------+-------+--------+
    |               |        |
    v               v        v
Azure VMs       Networking  Storage
    |               |        |
    +-------+-------+--------+
            |
            v
   Identity / RBAC / Security
            |
       +----+----+
       |         |
       v         v
   Azure WAF  Monitoring
              / Log Analytics
