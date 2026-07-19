$ErrorActionPreference = 'SilentlyContinue'

$NVDisplayContainerLS = Get-Service -Name 'NVDisplay.ContainerLocalSystem'

if ($NVDisplayContainerLS.Status -ne 'Running') {
    Start-Service -Name 'NVDisplay.ContainerLocalSystem'
}

$NVContainerLS = Get-Service -Name 'NvContainerLocalSystem'

if ($NVContainerLS.Status -ne 'Running') {
    Start-Service -Name 'NvContainerLocalSystem'
}

Start-Sleep -Seconds 2
