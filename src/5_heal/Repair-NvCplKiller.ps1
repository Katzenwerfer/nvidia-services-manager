$ErrorActionPreference = 'SilentlyContinue'

$TaskName = 'NvDisplayContainerLocalSystem Killer (nvcplui.exe)'
$TaskPath = '\Custom\'

$ScheduledTask = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath
if ($ScheduledTask) {
    $ScheduledTask.Triggers.Subscription -match "Data='(.+)'"
    $TargetProcess = Resolve-Path -Path 'C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_*\nvcplui.exe'
    if ($Matches[1] -ne $TargetProcess) {
        $ScheduledTask | Unregister-ScheduledTask -Confirm:$false
        & "$PSScriptRoot\..\4_kill\New-NvCplKiller.ps1"
    }
}
else {
    & "$PSScriptRoot\..\4_kill\New-NvCplKiller.ps1"
}
