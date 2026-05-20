$ErrorActionPreference = 'SilentlyContinue'

Start-Service -Name 'NVDisplay.ContainerLocalSystem'

Start-Sleep -Seconds 2
