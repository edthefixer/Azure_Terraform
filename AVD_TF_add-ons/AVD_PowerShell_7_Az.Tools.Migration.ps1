#requires -PSEdition Core
#requires -Version 7.0

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Block ISE explicitly (ISE is Windows PowerShell only, but this makes intent obvious)
if ($host.Name -match 'ISE') {
    throw "This script must be run in PowerShell 7 (pwsh), not PowerShell ISE."
}

$ModuleName      = 'Az.Tools.Migration'
$MinimumVersion  = [Version]'1.1.5'

Write-Host "PowerShell: $($PSVersionTable.PSVersion) ($($PSVersionTable.PSEdition))" -ForegroundColor Cyan
Write-Host "Ensuring module '$ModuleName' version >= $MinimumVersion ..." -ForegroundColor Cyan

# TLS 1.2 (safe to set; helps in locked-down environments)
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
} catch {
    # In PS7 this may be unnecessary; ignore if not supported
}

# Trust PSGallery (CurrentUser scope is safest for enterprise endpoints)
try {
    $psGallery = Get-PSRepository -Name 'PSGallery' -ErrorAction Stop
    if ($psGallery.InstallationPolicy -ne 'Trusted') {
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted | Out-Null
    }
} catch {
    throw "PSGallery is not available or cannot be queried. Ensure PowerShellGet is available and PSGallery access is permitted."
}

# Check installed version (if any)
$installed = Get-InstalledModule -Name $ModuleName -ErrorAction SilentlyContinue

if (-not $installed) {
    Write-Host "Module not found. Installing $ModuleName (minimum $MinimumVersion)..." -ForegroundColor Yellow
    Install-Module -Name $ModuleName -MinimumVersion $MinimumVersion -Scope CurrentUser -Force -AllowClobber
}
elseif ([Version]$installed.Version -lt $MinimumVersion) {
    Write-Host "Module version $($installed.Version) is below required $MinimumVersion. Upgrading..." -ForegroundColor Yellow
    Install-Module -Name $ModuleName -MinimumVersion $MinimumVersion -Scope CurrentUser -Force -AllowClobber
}
else {
    Write-Host "Module version $($installed.Version) already meets requirement." -ForegroundColor Green
}

Import-Module $ModuleName -Force

# Validate loaded version
$loaded = (Get-Module -Name $ModuleName).Version
if ([Version]$loaded -lt $MinimumVersion) {
    throw "Validation failed: Loaded $ModuleName version is $loaded, which is below required $MinimumVersion."
}

Write-Host "SUCCESS: $ModuleName version $loaded installed and loaded in PowerShell 7." -ForegroundColor Green