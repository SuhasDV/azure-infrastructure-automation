# ☁️ Azure Infrastructure Automation

Azure infrastructure automation portfolio demonstrating practical cloud infrastructure, security, monitoring, PowerShell automation, and Infrastructure as Code concepts.

> **Portfolio Project:** This repository contains independently developed examples for learning and demonstrating cloud infrastructure engineering concepts. It does not contain confidential, proprietary, credential, or employer-specific information.

---

## 🎯 Project Objectives

The goal of this project is to demonstrate practical Azure infrastructure engineering and automation skills.

Key objectives include:

- Automate common Azure infrastructure administration tasks
- Manage and inventory Azure Virtual Machines
- Work with Azure Virtual Networks, subnets, and NSGs
- Manage Azure Storage resources
- Demonstrate Microsoft Entra ID and Azure RBAC
- Demonstrate Azure security concepts
- Use PowerShell for Azure automation
- Demonstrate Infrastructure as Code using Bicep
- Explore Azure Monitor and Log Analytics
- Develop cloud troubleshooting and operational practices

---

## 🏗️ High-Level Architecture

```text
              Administrator / Cloud Engineer
                         |
                         | PowerShell / Bicep
                         v
                Azure Management Layer
                         |
          +--------------+--------------+
          |              |              |
          v              v              v
      Azure VMs      Networking       Storage
          |              |              |
          +--------------+--------------+
                         |
                         v
                Identity / RBAC /
                    Security
                         |
                 +-------+-------+
                 |               |
                 v               v
             Azure WAF       Monitoring
                              / Log Analytics
```

---

## 🧰 Technology Stack

| Technology | Purpose |
|---|---|
| Microsoft Azure | Cloud infrastructure |
| Azure Virtual Machines | Compute |
| Azure Virtual Network | Networking |
| Subnets | Network segmentation |
| Network Security Groups | Network security |
| Azure Storage | Cloud storage |
| Microsoft Entra ID | Identity |
| Azure RBAC | Access control |
| Azure WAF | Web security |
| Azure Monitor | Monitoring |
| Log Analytics | Log analysis |
| PowerShell | Automation |
| Azure CLI | Azure administration |
| Bicep | Infrastructure as Code |
| Git & GitHub | Version control |

---

## 💻 Azure Virtual Machines

This section demonstrates Azure VM inventory and administration concepts.

Information collected can include:

- VM name
- Resource group
- Location
- Operating system
- VM size
- Power state
- Network interface
- Private IP address
- Public IP configuration
- Provisioning state

Example:

```text
scripts/
└── virtual-machines/
    └── Get-AzureVMInventory.ps1
```

---

## 🌐 Azure Networking

Networking areas covered include:

- Virtual Networks
- Subnets
- Network Security Groups
- Network interfaces
- Public IP addresses
- Private IP addresses
- Network segmentation
- Basic network security

Example:

```text
scripts/
└── networking/
    └── Get-AzureNetworkInventory.ps1
```

---

## 💾 Azure Storage

Storage automation concepts include:

- Storage Accounts
- Blob Storage
- Resource groups
- Azure regions
- Storage configuration
- Storage security concepts
- Resource inventory

Example:

```text
scripts/
└── storage/
    └── Get-AzureStorageInventory.ps1
```

---

## 🔐 Identity & Azure RBAC

Identity and access management areas include:

- Microsoft Entra ID
- Azure RBAC
- Role assignments
- Subscription-level access
- Resource group permissions
- Least-privilege access

Example:

```text
scripts/
└── identity/
    └── Get-AzureRBACAssignments.ps1
```

---

## 🛡️ Azure WAF

Azure Web Application Firewall concepts include:

- Web traffic inspection
- Managed security rules
- Custom security rules
- Prevention and detection concepts
- Web application security

Example:

```text
scripts/
└── security/
    └── Get-AzureWAFConfiguration.ps1
```

---

## 📊 Monitoring & Observability

This project explores:

- Azure Monitor
- Metrics
- Activity Logs
- Log Analytics
- Resource health
- Operational monitoring
- Infrastructure troubleshooting

Basic operational flow:

```text
Detection
   |
   v
Investigation
   |
   v
Troubleshooting
   |
   v
Remediation
   |
   v
Validation
```

---

## ⚙️ PowerShell Automation

PowerShell is used as the primary automation language.

Typical workflow:

```text
Authenticate
    |
    v
Select Azure Subscription
    |
    v
Query Azure Resources
    |
    v
Collect Infrastructure Data
    |
    v
Filter / Process Data
    |
    v
Generate Report
```

Automation concepts demonstrated include:

- Resource discovery
- Infrastructure inventory
- Administrative reporting
- Filtering
- Error handling
- Reusable automation
- Structured output

---

## 🧱 Infrastructure as Code

Infrastructure as Code concepts are demonstrated using Bicep.

Example structure:

```text
infrastructure-as-code/
└── bicep/
    ├── main.bicep
    ├── parameters.bicepparam
    └── modules/
```

Key benefits:

- Repeatability
- Version control
- Consistency
- Reviewability
- Infrastructure standardization

---

## 📁 Project Structure

```text
azure-infrastructure-automation/
│
├── README.md
│
├── architecture/
│   └── Azure-Infrastructure-Architecture.md
│
├── scripts/
│   ├── virtual-machines/
│   │   └── Get-AzureVMInventory.ps1
│   │
│   ├── storage/
│   │   └── Get-AzureStorageInventory.ps1
│   │
│   ├── networking/
│   │   └── Get-AzureNetworkInventory.ps1
│   │
│   ├── identity/
│   │   └── Get-AzureRBACAssignments.ps1
│   │
│   └── security/
│       └── Get-AzureWAFConfiguration.ps1
│
├── infrastructure-as-code/
│   ├── README.md
│   └── bicep/
│
└── documentation/
    └── troubleshooting.md
```

---

## 🔒 Security Considerations

Never commit:

- Passwords
- Client secrets
- API keys
- Access tokens
- Private keys
- Connection strings
- Subscription credentials

Example:

```powershell
# Never hard-code credentials

$ClientSecret = "DO-NOT-STORE-SECRETS-HERE"
```

Use secure authentication mechanisms when working with real Azure environments.

---

## 🧪 Testing Approach

The project follows a basic validation approach:

1. Validate PowerShell syntax
2. Test authentication
3. Use a controlled Azure environment
4. Validate returned resource information
5. Check error handling
6. Review generated output
7. Validate permissions
8. Confirm expected results

---

## 🛠️ Troubleshooting Approach

```text
Identify Problem
      |
      v
Collect Evidence
      |
      v
Check Azure Resource State
      |
      v
Review Permissions
      |
      v
Review Network Configuration
      |
      v
Review Logs
      |
      v
Apply Remediation
      |
      v
Validate Resolution
```

---

## 🚀 Future Enhancements

Planned areas for future development include:

- Azure Policy automation
- Azure Automation
- Azure Functions
- Advanced Azure Monitor queries
- Log Analytics automation
- GitHub Actions
- Automated Bicep deployments
- Infrastructure compliance checks
- Automated infrastructure health reports
- DevOps integration

---

## 🎯 Portfolio Objective

This repository demonstrates practical cloud infrastructure engineering through:

- Azure administration
- Infrastructure automation
- Identity and access management
- Network security
- Cloud storage
- Compute management
- Monitoring
- Troubleshooting
- PowerShell automation
- Infrastructure as Code
- Version control
- Secure cloud operations

The project is designed to support roles involving:

- Cloud Infrastructure Engineering
- Azure Administration
- Cloud Operations
- DevOps Engineering
- Infrastructure Automation
- Site Reliability Engineering

---

---

**Built with Microsoft Azure + PowerShell + Bicep + Microsoft Entra ID + GitHub**
