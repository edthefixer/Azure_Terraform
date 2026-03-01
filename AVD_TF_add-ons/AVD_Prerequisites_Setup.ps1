# AVD Prerequisites Setup Script
# This script installs required PowerShell modules and registers necessary Azure resource providers for AVD deployments.

# Install required PowerShell modules
Write-Host "Installing Az.ImageBuilder module..."
Install-Module Az.ImageBuilder -Force -AllowClobber -Scope CurrentUser

# Register required Azure resource providers
Write-Host "Registering Microsoft.Monitor resource provider..."
Register-AzResourceProvider -ProviderNamespace 'Microsoft.Monitor'

Write-Host "Registering Microsoft.KeyVault resource provider..."
Register-AzResourceProvider -ProviderNamespace 'Microsoft.KeyVault'

Write-Host "Registering Microsoft.Storage resource provider..."
Register-AzResourceProvider -ProviderNamespace 'Microsoft.Storage'

Write-Host "Registering Microsoft.DesktopVirtualization resource provider..."
Register-AzResourceProvider -ProviderNamespace 'Microsoft.DesktopVirtualization'

Write-Host "Registering Microsoft.Compute resource provider..."
Register-AzResourceProvider -ProviderNamespace 'Microsoft.Compute'

Write-Host "Registering Microsoft.Network resource provider..."
Register-AzResourceProvider -ProviderNamespace 'Microsoft.Network'

Write-Host "All prerequisites have been checked and installed."
