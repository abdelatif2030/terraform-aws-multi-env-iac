# Terraform Multi-Environment Deployment Script
# PowerShell Version

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('dev','staging','prod')]
    [string]$Environment,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('plan','apply','destroy','output','show')]
    [string]$Action = 'plan'
)

# Set error action
$ErrorActionPreference = "Stop"

# Colors
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# Set working directory
$workDir = Join-Path $PSScriptRoot "..\environments\$Environment"

if (!(Test-Path $workDir)) {
    Write-ColorOutput Red "Error: Environment directory not found: $workDir"
    exit 1
}

Set-Location $workDir

Write-ColorOutput Green "========================================  "
Write-ColorOutput Green "  Terraform $Action - $Environment Environment"
Write-ColorOutput Green "========================================"
Write-Host ""

# Initialize if needed
if (!(Test-Path ".terraform")) {
    Write-ColorOutput Yellow "Initializing Terraform..."
    terraform init
    Write-Host ""
}

# Execute action
switch ($Action) {
    'plan' {
        Write-ColorOutput Yellow "Running terraform plan..."
        terraform plan -out=tfplan
        Write-Host ""
        Write-ColorOutput Green "✓ Plan saved to tfplan"
        Write-ColorOutput Yellow "Review the plan above, then run:"
        Write-ColorOutput Yellow "  .\deploy.ps1 -Environment $Environment -Action apply"
    }
    
    'apply' {
        if (Test-Path "tfplan") {
            Write-ColorOutput Yellow "Applying saved plan..."
            terraform apply tfplan
            Remove-Item "tfplan" -Force
        } else {
            Write-ColorOutput Yellow "No saved plan found. Applying with confirmation..."
            $confirm = Read-Host "Are you sure? Type 'yes' to continue"
            if ($confirm -eq 'yes') {
                terraform apply -auto-approve
            } else {
                Write-ColorOutput Red "Apply cancelled"
                exit 1
            }
        }
        Write-Host ""
        Write-ColorOutput Green "✓ Apply complete!"
        Write-Host ""
        terraform output
    }
    
    'destroy' {
        Write-ColorOutput Red "⚠️  WARNING: This will destroy all resources in $Environment!"
        $confirm = Read-Host "Type the environment name '$Environment' to confirm"
        if ($confirm -eq $Environment) {
            terraform destroy -auto-approve
            Write-ColorOutput Green "✓ Destroy complete"
        } else {
            Write-ColorOutput Red "Destroy cancelled"
            exit 1
        }
    }
    
    'output' {
        terraform output
    }
    
    'show' {
        terraform show
    }
}
