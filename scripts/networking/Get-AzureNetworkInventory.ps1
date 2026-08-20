<#
.SYNOPSIS
    Generates an inventory report of Azure networking resources.

.DESCRIPTION
    Retrieves Azure Virtual Network, subnet, Network Security Group,
    and IP configuration information.

    This script is read-only and does not modify Azure resources.

.NOTES
    Portfolio Project:
    Azure Infrastructure Automation

    Required modules:
    Az.Network
#>

#Requires -Modules Az.Network

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".\Azure-Network-Inventory.csv"
)

Write-Host "Starting Azure Network inventory..." -ForegroundColor Cyan

# Verify Azure authentication
$context = Get-AzContext

if (-not $context) {
    Write-Host "No Azure session detected." -ForegroundColor Yellow
    Write-Host "Please authenticate using Connect-AzAccount." -ForegroundColor Yellow
    exit 1
}

Write-Host "Subscription: $($context.Subscription.Name)" -ForegroundColor Green

# Retrieve Virtual Networks
$virtualNetworks = Get-AzVirtualNetwork

if (-not $virtualNetworks) {
    Write-Host "No Azure Virtual Networks found." -ForegroundColor Yellow
    exit 0
}

$networkInventory = foreach ($vnet in $virtualNetworks) {

    foreach ($subnet in $vnet.Subnets) {

        [PSCustomObject]@{
            VirtualNetwork = $vnet.Name
            ResourceGroup  = $vnet.ResourceGroupName
            Location       = $vnet.Location
            AddressSpace   = ($vnet.AddressSpace.AddressPrefixes -join ", ")
            SubnetName     = $subnet.Name
            SubnetPrefix   = ($subnet.AddressPrefix -join ", ")
            NSGName        = if ($subnet.NetworkSecurityGroup) {
                Split-Path $subnet.NetworkSecurityGroup.Id -Leaf
            }
            else {
                "Not Associated"
            }
        }
    }
}

# Display results
Write-Host "`nAzure Network Inventory:" -ForegroundColor Cyan

$networkInventory |
    Sort-Object ResourceGroup, VirtualNetwork, SubnetName |
    Format-Table -AutoSize

# Export results
$networkInventory |
    Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "`nNetwork inventory report created:" -ForegroundColor Green
Write-Host $OutputPath -ForegroundColor Green

Write-Host "`nAzure Network inventory completed successfully." -ForegroundColor Cyan
