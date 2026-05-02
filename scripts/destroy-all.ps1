# Destroy All Environments Script

param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

Write-ColorOutput Red "⚠️  WARNING: This will destroy ALL environments!"
Write-Host "Environments: dev, staging, prod"
Write-Host ""

if (!$Force) {
    $confirm = Read-Host "Type 'destroy-all' to confirm"
    if ($confirm -ne 'destroy-all') {
        Write-ColorOutput Yellow "Cancelled"
        exit 0
    }
}

$environments = @('dev', 'staging', 'prod')

foreach ($env in $environments) {
    Write-Host ""
    Write-ColorOutput Yellow "========================================"
    Write-ColorOutput Yellow "Destroying $env environment..."
    Write-ColorOutput Yellow "========================================"
    
    $envPath = Join-Path $PSScriptRoot "..\environments\$env"
    Set-Location $envPath
    
    terraform destroy -auto-approve
}

Write-Host ""
Write-ColorOutput Green "✓ All environments destroyed"
