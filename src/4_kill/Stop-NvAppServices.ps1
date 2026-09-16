$ErrorActionPreference = 'SilentlyContinue'

Start-Sleep -Seconds 2

$Process = Get-Process -Name 'NVIDIA App'
$Overlay = Get-Process -Name 'NVIDIA Overlay'

if (-not $Process -and -not $Overlay) {
    $NVDisplayContainerLS = Get-Service -Name 'NVDisplay.ContainerLocalSystem'

    if ($NVDisplayContainerLS.Status -eq 'Running') {
        $NvDisplayContainerLS | Stop-Service -Force
    }

    $NvContainerLS = Get-Service -Name 'NvContainerLocalSystem'

    if ($NvContainerLS.Status -eq 'Running') {
        $NvContainerLS | Stop-Service -Force
    }
}

& "$PSScriptRoot\..\2_disable\Disable-NvAppTask.ps1"
& "$PSScriptRoot\..\2_disable\Set-NvContainerLS.ps1"
