<#
.SYNOPSIS
    Generates an inventory report of Azure Storage Accounts.

.DESCRIPTION
    Retrieves Azure Storage Account information including:
    - Storage account name
    - Resource group
    - Location
    - SKU
    - Kind
    - HTTPS-only configuration
    - Minimum TLS version
    - Public network access

    This script is read-only and does not modify Azure resources.

.NOTES
    Portfolio Project:
    Azure Infrastructure Automation

    Required module:
    Az.Storage
#>

#Requires -Modules Az.Storage

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".\Azure-Storage-Inventory.csv"
)

Write-Host "Starting Azure Storage inventory..." -ForegroundColor Cyan

# Verify Azure authentication
$context = Get-AzContext

if (-not $context) {
    Write-Host "No Azure session detected." -ForegroundColor Yellow
    Write-Host "Please authenticate using Connect-AzAccount." -ForegroundColor Yellow
    exit 1
}

Write-Host "Subscription: $($context.Subscription.Name)" -ForegroundColor Green

# Retrieve Storage Accounts
$storageAccounts = Get-AzStorageAccount

if (-not $storageAccounts) {
    Write-Host "No Azure Storage Accounts found." -ForegroundColor Yellow
    exit 0
}

$storageInventory = foreach ($storage in $storageAccounts) {

    [PSCustomObject]@{
        StorageAccount       = $storage.StorageAccountName
        ResourceGroup        = $storage.ResourceGroupName
        Location             = $storage.Location
        Kind                 = $storage.Kind
        SKU                  = $storage.Sku.Name
        HTTPSOnly            = $storage.EnableHttpsTrafficOnly
        MinimumTLSVersion    = $storage.MinimumTlsVersion
        PublicNetworkAccess  = $storage.PublicNetworkAccess
    }
}

# Display results
Write-Host "`nAzure Storage Inventory:" -ForegroundColor Cyan

$storageInventory |
    Sort-Object ResourceGroup, StorageAccount |
    Format-Table -AutoSize

# Export results
$storageInventory |
    Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "`nStorage inventory report created:" -ForegroundColor Green
Write-Host $OutputPath -ForegroundColor Green

Write-Host "`nAzure Storage inventory completed successfully." -ForegroundColor Cyan
