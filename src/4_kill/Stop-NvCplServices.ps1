$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 2

$Process = Get-Process -Name 'nvcplui'

if (-not $Process) {
    $NVDisplayContainerLS = Get-Service -Name 'NVDisplay.ContainerLocalSystem'

    if ($NVDisplayContainerLS.Status -eq 'Running') {
        $NvDisplayContainerLS | Stop-Service -Force
    }
}
