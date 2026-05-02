# Update SSH Public Key in all terraform.tfvars files

param(
    [Parameter(Mandatory=$true)]
    [string]$PublicKeyPath
)

if (!(Test-Path $PublicKeyPath)) {
    Write-Host "Error: Public key file not found: $PublicKeyPath" -ForegroundColor Red
    exit 1
}

$publicKey = Get-Content $PublicKeyPath -Raw
$publicKey = $publicKey.Trim()

Write-Host "Updating terraform.tfvars files with SSH public key..." -ForegroundColor Green

$environments = @('dev', 'staging', 'prod')

foreach ($env in $environments) {
    $tfvarsPath = Join-Path $PSScriptRoot "..\environments\$env\terraform.tfvars"
    
    if (Test-Path $tfvarsPath) {
        $content = Get-Content $tfvarsPath -Raw
        $content = $content -replace 'ssh_public_key = ".*"', "ssh_public_key = `"$publicKey`""
        $content | Out-File -FilePath $tfvarsPath -Encoding UTF8 -NoNewline
        
        Write-Host "✓ Updated $env/terraform.tfvars" -ForegroundColor Green
    }
}

Write-Host "`nAll terraform.tfvars files updated successfully!" -ForegroundColor Green
