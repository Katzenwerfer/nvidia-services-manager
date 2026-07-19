$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 2

$Process = Get-Process -Name 'nvcplui'

if (-not $Process) {
    Stop-Service -Force -Name 'NVDisplay.ContainerLocalSystem'
}
