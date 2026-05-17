$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 3

if (-not [bool](Get-Process -Name 'NVIDIA App' -ErrorAction 'SilentlyContinue')) {
    Stop-Service -Force -Name 'NvContainerLocalSystem'
}
