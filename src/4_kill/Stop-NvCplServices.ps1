$ErrorActionPreference = 'SilentlyContinue'

$SpawnerTask = Get-ScheduledTask -TaskName 'NVIDIA Services Spawner (nvcplui.exe)' -TaskPath '\Custom\NVIDIA\'

if ($SpawnerTask.State -eq 'Running') {
    $Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    while (($SpawnerTask.State -eq 'Running') -and ($Stopwatch.ElapsedMilliseconds -lt 3000)) {
        [System.Threading.Thread]::Sleep(200)
        $SpawnerTask = Get-ScheduledTask -TaskName 'NVIDIA Services Spawner (nvcplui.exe)' -TaskPath '\Custom\NVIDIA\'
    }
    $Stopwatch.Stop()
}

$ControlPanelProcess = Get-Process -Name 'nvcplui'

if (-not $ControlPanelProcess) {
    $NVDisplayContainerLS = Get-Service -Name 'NVDisplay.ContainerLocalSystem'

    if ($NVDisplayContainerLS.Status -eq 'Running') {
        $NvDisplayContainerLS | Stop-Service -Force
    }
}

& "$PSScriptRoot\..\2_disable\Set-NvDisplayContainerLS.ps1"
