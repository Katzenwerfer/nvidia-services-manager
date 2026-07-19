$ErrorActionPreference = 'SilentlyContinue'

Start-Service -Name 'NVDisplay.ContainerLocalSystem'
Start-Service -Name 'NvContainerLocalSystem'

Start-Sleep -Seconds 2
