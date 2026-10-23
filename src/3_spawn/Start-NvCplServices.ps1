$ErrorActionPreference = 'SilentlyContinue'

$ControlPanelProcess = Get-Process -Name 'nvcplui'

if ($ControlPanelProcess) {
    $Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    while (($ControlPanelProcess) -and ($Stopwatch.ElapsedMilliseconds -lt 3000)) {
        [System.Threading.Thread]::Sleep(200)
        $ControlPanelProcess = Get-Process -Name 'nvcplui'
    }

    $Stopwatch.Stop()
}

$DisplayContainerService = Get-Service -Name 'NVDisplay.ContainerLocalSystem'

if ($DisplayContainerService.Status -ne 'Running') {
    Start-Service -Name 'NVDisplay.ContainerLocalSystem'
    $DisplayContainerService.WaitForStatus('Running', [TimeSpan]::FromSeconds(3))
}

$ControlPanelProcess = Get-Process -Name 'nvcplui'

if (-not $ControlPanelProcess) {
    Start-ScheduledTask -TaskPath '\Custom\NVIDIA\' -TaskName 'NVIDIA Control Panel Helper'

    $Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    while ((-not $ControlPanelProcess) -and ($Stopwatch.ElapsedMilliseconds -lt 3000)) {
        [System.Threading.Thread]::Sleep(200)
        $ControlPanelProcess = Get-Process -Name 'nvcplui'

    }
    $Stopwatch.Stop()
}
