$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 2

if (-not [bool](Get-Process -Name 'nvcplui' -ErrorAction 'SilentlyContinue')) {
    Stop-Service -Force -Name 'NVDisplay.ContainerLocalSystem'
}
