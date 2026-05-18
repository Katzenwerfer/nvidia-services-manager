$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 3

if (-not [bool](Get-Process -Name 'nvcplui' -ErrorAction 'SilentlyContinue')) {
    Stop-Service -Force -Name 'NVDisplay.ContainerLocalSystem'
    & "$PSScriptRoot\..\2_disable\Set-NvContainerServices.ps1"
}
