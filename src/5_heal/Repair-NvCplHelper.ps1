$ErrorActionPreference = 'SilentlyContinue'

$TaskName = 'NVIDIA Control Panel Helper'
$TaskPath = '\Custom\NVIDIA\'

$ScheduledTask = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath

if ($ScheduledTask) {
    $ScheduledTask.Triggers.Subscription -match "Data='(.+)'" | Out-Null
    $TargetProcess = Resolve-Path -Path 'C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_*\nvcplui.exe'
    if ($Matches[1] -ne $TargetProcess) {
        $ScheduledTask | Unregister-ScheduledTask -Confirm:$false
        & "$PSScriptRoot\..\3_spawn\New-NvCplHelper.ps1"
    }
}
else {
    & "$PSScriptRoot\..\3_spawn\New-NvCplHelper.ps1"
}
