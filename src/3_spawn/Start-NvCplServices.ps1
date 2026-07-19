$ErrorActionPreference = 'SilentlyContinue'


$NVDisplayContainerLS = Get-Service -Name 'NVDisplay.ContainerLocalSystem'

if ($NVDisplayContainerLS.Status -ne 'Running') {
    Start-Service -Name 'NVDisplay.ContainerLocalSystem'
}

Start-Sleep -Seconds 1

$Process = Get-Process -Name 'nvcplui'

if (-not $Process) {
    Start-ScheduledTask -TaskPath '\Custom\NVIDIA\' -TaskName 'NVIDIA Control Panel Helper'
}

Start-Sleep -Seconds 1
