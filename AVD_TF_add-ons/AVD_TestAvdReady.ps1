<#
.SYNOPSIS
  "AVD-ready" runtime validation for a Host Pool and its Session Hosts.

.DESCRIPTION
  This is NOT a platform prerequisite checklist. It validates whether Azure Virtual Desktop
  can broker connections to session hosts NOW (control-plane readiness), by checking:
   - AVD session host status (Available/Needs Assistance/Unavailable/Shutdown/etc.)
   - VM power state correlation
   - Host pool properties like Start VM on Connect

  Reference: Get-AzWvdHostPool cmdlet syntax and usage.
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory)]
  [string]$SubscriptionId,

  [Parameter(Mandatory)]
  [string]$HostPoolResourceGroup,

  [Parameter(Mandatory)]
  [string]$HostPoolName,

  [string]$ExportCsvPath,

  [switch]$FailIfAnyNotReady
)

Set-StrictMode -Version Latest

function Assert-PS7 {
  if ($PSVersionTable.PSVersion.Major -lt 7) {
    throw "PowerShell 7+ required. Current: $($PSVersionTable.PSVersion)"
  }
}

function Ensure-AzModules {
  $required = @("Az.Accounts","Az.Resources","Az.Compute","Az.DesktopVirtualization")
  foreach ($m in $required) {
    if (-not (Get-Module -ListAvailable -Name $m)) {
      throw "Missing module '$m'. Install-Module $m -Scope CurrentUser"
    }
  }
  foreach ($m in $required) { Import-Module $m -ErrorAction Stop }
}

function Ensure-AzLoginAndContext {
  param([Parameter(Mandatory)][string]$SubId)

  $ctx = Get-AzContext -ErrorAction SilentlyContinue
  if (-not $ctx) {
    throw "No Az context. Run Connect-AzAccount (or use an automation identity)."
  }

  if ($ctx.Subscription.Id -ne $SubId) {
    Set-AzContext -SubscriptionId $SubId -Force | Out-Null
  }
}

function Assert-ResourceGroupVisible {
  param([Parameter(Mandatory)][string]$RgName)

  if (-not (Get-AzResourceGroup -Name $RgName -ErrorAction SilentlyContinue)) {
    throw "Resource group '$RgName' not visible in ARM for the active context. Auth/context issue."
  }
}

function Parse-ComputeVmFromResourceId {
  param([Parameter(Mandatory)][string]$ResourceId)

  # Expected: /subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Compute/virtualMachines/<vm>
  $m = [regex]::Match(
    $ResourceId,
    "/resourceGroups/(?<rg>[^/]+)/providers/Microsoft\.Compute/virtualMachines/(?<vm>[^/]+)",
    "IgnoreCase"
  )
  if ($m.Success) {
    return [pscustomobject]@{ ResourceGroup = $m.Groups["rg"].Value; VmName = $m.Groups["vm"].Value }
  }
  return $null
}

Assert-PS7
Ensure-AzModules
Ensure-AzLoginAndContext -SubId $SubscriptionId
Assert-ResourceGroupVisible -RgName $HostPoolResourceGroup

# Host pool (properties like Start VM on Connect)
$hp = Get-AzWvdHostPool -ResourceGroupName $HostPoolResourceGroup -Name $HostPoolName -ErrorAction Stop

# Session hosts in pool
$sessionHosts = Get-AzWvdSessionHost -ResourceGroupName $HostPoolResourceGroup -HostPoolName $HostPoolName -ErrorAction Stop

$results = foreach ($sh in $sessionHosts) {

  # Normalize fields (cmdlets can differ by version)
  $avdStatus =
    if ($sh.PSObject.Properties.Name -contains "Status") { $sh.Status }
    elseif ($sh.PSObject.Properties.Name -contains "SessionHostHealthCheckStatus") { $sh.SessionHostHealthCheckStatus }
    else { "Unknown" }

  # Compute VM correlation via ResourceId (preferred)
  $vmRef = $null
  if (($sh.PSObject.Properties.Name -contains "ResourceId") -and $sh.ResourceId) {
    $vmRef = Parse-ComputeVmFromResourceId -ResourceId $sh.ResourceId
  }

  $vmPower = "Unknown"
  $vmRg = $null
  $vmName = $null

  if ($vmRef) {
    $vmRg = $vmRef.ResourceGroup
    $vmName = $vmRef.VmName

    try {
      $vm = Get-AzVM -ResourceGroupName $vmRg -Name $vmName -Status -ErrorAction Stop
      $ps = ($vm.Statuses | Where-Object { $_.Code -like "PowerState/*" } | Select-Object -First 1).DisplayStatus
      if ($ps) { $vmPower = $ps }
    } catch {
      $vmPower = "VMNotFoundOrNoAccess"
    }
  }

  # Readiness logic (simple + deterministic)
  $readiness =
    switch -Regex ($avdStatus) {
      "Available"        { "Ready"; break }
      "Needs Assistance" { "Warning"; break }
      "Unavailable"      { "NotReady"; break }
      "Shutdown"         { "NotReady"; break }
      default            { "NotReady"; break }
    }

  $note = @()
  if ($vmPower -match "deallocated|stopped" -and -not $hp.StartVMOnConnect) {
    $note += "VM is not running and Start VM on Connect is disabled."
  }
  if ($readiness -eq "NotReady" -and $vmPower -match "running") {
    $note += "VM running but AVD reports host not connectable (agent/registration/health)."
  }

  [pscustomobject]@{
    HostPool              = $HostPoolName
    SessionHostObjectName = $sh.Name
    AvdStatus             = $avdStatus
    VmResourceGroup       = $vmRg
    VmName                = $vmName
    VmPowerState          = $vmPower
    Readiness             = $readiness
    Notes                 = ($note -join " ")
  }
}

# Output summary
$summary = $results | Group-Object Readiness | Select-Object Name,Count
Write-Host "Host Pool: $HostPoolName" -ForegroundColor Cyan
Write-Host "Start VM on Connect: $($hp.StartVMOnConnect)" -ForegroundColor Cyan
$summary | Format-Table -AutoSize

if ($ExportCsvPath) {
  $results | Export-Csv -NoTypeInformation -Path $ExportCsvPath -Force
  Write-Host "Exported: $ExportCsvPath" -ForegroundColor Green
}

if ($FailIfAnyNotReady) {
  $bad = $results | Where-Object { $_.Readiness -eq "NotReady" }
  if ($bad) {
    throw ("AVD-ready check failed. NotReady hosts: " + ($bad.SessionHostObjectName -join ", "))
  }
}

$results