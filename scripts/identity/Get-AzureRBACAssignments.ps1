<#
.SYNOPSIS
    Generates an Azure RBAC role assignment report.

.DESCRIPTION
    Retrieves Azure role assignments and reports:
    - Principal name
    - Principal type
    - Role definition
    - Scope
    - Resource group

    This script is read-only and does not modify Azure resources.

.NOTES
    Portfolio Project:
    Azure Infrastructure Automation

    Required module:
    Az.Resources
#>

#Requires -Modules Az.Resources

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".\Azure-RBAC-Assignments.csv"
)

Write-Host "Starting Azure RBAC inventory..." -ForegroundColor Cyan

# Verify Azure authentication
$context = Get-AzContext

if (-not $context) {
    Write-Host "No Azure session detected." -ForegroundColor Yellow
    Write-Host "Please authenticate using Connect-AzAccount." -ForegroundColor Yellow
    exit 1
}

Write-Host "Subscription: $($context.Subscription.Name)" -ForegroundColor Green

# Retrieve role assignments
$assignments = Get-AzRoleAssignment

if (-not $assignments) {
    Write-Host "No RBAC assignments found." -ForegroundColor Yellow
    exit 0
}

$rbacInventory = foreach ($assignment in $assignments) {

    [PSCustomObject]@{
        PrincipalName   = $assignment.DisplayName
        PrincipalType   = $assignment.ObjectType
        RoleDefinition  = $assignment.RoleDefinitionName
        Scope           = $assignment.Scope
        ResourceGroup   = $assignment.ResourceGroupName
        SignInName      = $assignment.SignInName
        ObjectId        = $assignment.ObjectId
    }
}

# Display results
Write-Host "`nAzure RBAC Assignments:" -ForegroundColor Cyan

$rbacInventory |
    Sort-Object ResourceGroup, RoleDefinition, PrincipalName |
    Format-Table -AutoSize

# Export results
$rbacInventory |
    Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "`nRBAC report created:" -ForegroundColor Green
Write-Host $OutputPath -ForegroundColor Green

Write-Host "`nAzure RBAC inventory completed successfully." -ForegroundColor Cyan
