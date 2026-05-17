$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 3

if (-not [bool](Get-Process -Name 'NVIDIA App' -ErrorAction 'SilentlyContinue')) {
    Stop-Service -Force -Name 'NvContainerLocalSystem'
    & "$PSScriptRoot\..\2_disable\Set-NvContainerServices.ps1"
}
