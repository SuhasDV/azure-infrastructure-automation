<#
.SYNOPSIS
    Generates an inventory report of Azure Virtual Machines.

.DESCRIPTION
    Retrieves Azure Virtual Machine information including:
    - VM name
    - Resource group
    - Location
    - VM size
    - Operating system
    - Power state
    - Provisioning state

    This script is read-only and does not modify Azure resources.

.NOTES
    Portfolio Project:
    Azure Infrastructure Automation

    Required module:
    Az.Compute
#>

#Requires -Modules Az.Compute

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".\Azure-VM-Inventory.csv"
)

Write-Host "Starting Azure Virtual Machine inventory..." -ForegroundColor Cyan

# Verify Azure authentication
$context = Get-AzContext

if (-not $context) {
    Write-Host "No Azure session detected." -ForegroundColor Yellow
    Write-Host "Please authenticate using Connect-AzAccount." -ForegroundColor Yellow
    exit 1
}

Write-Host "Subscription: $($context.Subscription.Name)" -ForegroundColor Green

# Retrieve all Azure VMs
$vms = Get-AzVM -Status

if (-not $vms) {
    Write-Host "No Azure Virtual Machines found." -ForegroundColor Yellow
    exit 0
}

$inventory = foreach ($vm in $vms) {

    $powerState = ($vm.Statuses |
        Where-Object { $_.Code -like "PowerState/*" } |
        Select-Object -ExpandProperty DisplayStatus)

    [PSCustomObject]@{
        VMName            = $vm.Name
        ResourceGroup     = $vm.ResourceGroupName
        Location          = $vm.Location
        VMSize            = $vm.HardwareProfile.VmSize
        OperatingSystem   = $vm.StorageProfile.OSDisk.OsType
        PowerState        = $powerState
        ProvisioningState = $vm.ProvisioningState
    }
}

# Display results
Write-Host "`nAzure VM Inventory:" -ForegroundColor Cyan

$inventory |
    Sort-Object ResourceGroup, VMName |
    Format-Table -AutoSize

# Export results
$inventory |
    Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "`nInventory report created:" -ForegroundColor Green
Write-Host $OutputPath -ForegroundColor Green

Write-Host "`nAzure VM inventory completed successfully." -ForegroundColor Cyan
