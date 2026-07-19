$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 2

$Process = Get-Process -Name 'NVIDIA App'

if (-not $Process) {
    Stop-Service -Force -Name 'NVDisplay.ContainerLocalSystem'
    Stop-Service -Force -Name 'NvContainerLocalSystem'
    & "$PSScriptRoot\..\2_disable\Disable-NvAppTask.ps1"
    & "$PSScriptRoot\..\2_disable\Set-NvContainerLS.ps1"
}
