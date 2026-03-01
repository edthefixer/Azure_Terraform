param(
  [string]$ResourceGroup,
  [string]$HostPoolName,
  [int]$TimeoutMinutes = 20
)

$StartTime = Get-Date
while ($true) {
    $hosts = Get-AzWvdSessionHost -ResourceGroupName $ResourceGroup -HostPoolName $HostPoolName
    $unhealthy = $hosts | Where-Object { $_.Status -ne "Available" }
    if ($unhealthy.Count -eq 0) {
        Write-Host "All session hosts are available."
        exit 0
    }
    if (((Get-Date) - $StartTime).TotalMinutes -ge $TimeoutMinutes) {
        Write-Host "Timeout reached. Some hosts are still not available."
        exit 1
    }
    Write-Host "Waiting for session hosts to become available..."
    Start-Sleep -Seconds 60
}
