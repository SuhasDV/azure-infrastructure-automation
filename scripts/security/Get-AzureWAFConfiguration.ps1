<#
.SYNOPSIS
    Generates an Azure Web Application Firewall configuration report.

.DESCRIPTION
    Retrieves Azure WAF policy information including:
    - WAF policy name
    - Resource group
    - Location
    - Policy mode
    - Managed rule sets
    - Custom rules
    - Policy state

    This script is read-only and does not modify Azure resources.

.NOTES
    Portfolio Project:
    Azure Infrastructure Automation

    Required module:
    Az.Network
#>

#Requires -Modules Az.Network

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".\Azure-WAF-Configuration.csv"
)

Write-Host "Starting Azure WAF configuration inventory..." -ForegroundColor Cyan

# Verify Azure authentication
$context = Get-AzContext

if (-not $context) {
    Write-Host "No Azure session detected." -ForegroundColor Yellow
    Write-Host "Please authenticate using Connect-AzAccount." -ForegroundColor Yellow
    exit 1
}

Write-Host "Subscription: $($context.Subscription.Name)" -ForegroundColor Green

# Retrieve WAF policies
$policies = Get-AzApplicationGatewayFirewallPolicy

if (-not $policies) {
    Write-Host "No Azure WAF policies found." -ForegroundColor Yellow
    exit 0
}

$wafInventory = foreach ($policy in $policies) {

    $managedRuleSets = @()

    if ($policy.ManagedRules.ManagedRuleSets) {
        $managedRuleSets = $policy.ManagedRules.ManagedRuleSets |
            ForEach-Object {
                "$($_.RuleSetType) $($_.RuleSetVersion)"
            }
    }

    $customRuleCount = 0

    if ($policy.CustomRules) {
        $customRuleCount = $policy.CustomRules.Count
    }

    [PSCustomObject]@{
        PolicyName        = $policy.Name
        ResourceGroup     = $policy.ResourceGroupName
        Location          = $policy.Location
        PolicyMode        = $policy.PolicySettings.Mode
        PolicyState       = $policy.PolicySettings.State
        ManagedRuleSets   = ($managedRuleSets -join "; ")
        CustomRuleCount   = $customRuleCount
        ProvisioningState = $policy.ProvisioningState
    }
}

# Display results
Write-Host "`nAzure WAF Configuration:" -ForegroundColor Cyan

$wafInventory |
    Sort-Object ResourceGroup, PolicyName |
    Format-Table -AutoSize

# Export results
$wafInventory |
    Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "`nWAF configuration report created:" -ForegroundColor Green
Write-Host $OutputPath -ForegroundColor Green

Write-Host "`nAzure WAF inventory completed successfully." -ForegroundColor Cyan
