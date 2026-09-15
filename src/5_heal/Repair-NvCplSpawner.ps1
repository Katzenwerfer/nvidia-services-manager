$ErrorActionPreference = 'SilentlyContinue'

$TaskName = 'NVIDIA Services Spawner (NVIDIA App.exe)'
$TaskPath = '\Custom\NVIDIA\'

$ScheduledTask = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath

if ($ScheduledTask) {
    $ScheduledTask.Triggers.Subscription -match "Data='(.+)'" | Out-Null
    $TargetProcess = Resolve-Path -Path 'C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_*\nvcplui.exe'
    if ($Matches[1] -ne $TargetProcess) {
        $ScheduledTask | Unregister-ScheduledTask -Confirm:$false
        & (Join-Path -Path $PSScriptRoot -ChildPath '..\3_spawn\New-NvCplSpawner.ps1' -Resolve)
    }
}
else {
    & (Join-Path -Path $PSScriptRoot -ChildPath '..\3_spawn\New-NvCplSpawner.ps1' -Resolve)
}
