# Admin check

. "$PSScriptRoot\0_shared\Test-IsElevated.ps1"
Test-IsElevated

# Required setup

& "$PSScriptRoot\1_setup\Enable-ProcessTracking.ps1"

# General scripts

& "$PSScriptRoot\2_disable\Set-NvDisplayContainerLS.ps1"

# NvCpl scripts

$NvCplProcess = Resolve-Path -Path 'C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_*\nvcplui.exe'
if ($NvCplProcess) {
    & "$PSScriptRoot\3_spawn\New-NvCplHelper.ps1"
    & "$PSScriptRoot\3_spawn\New-NvCplSpawner.ps1"
    & "$PSScriptRoot\4_kill\New-NvCplKiller.ps1"
    & "$PSScriptRoot\4_kill\Stop-NvCplServices.ps1"
}

# NvApp scripts

$NvAppProcess = 'C:\Program Files\NVIDIA Corporation\NVIDIA App\CEF\NVIDIA App.exe'
if ($NvAppProcess) {
    & "$PSScriptRoot\2_disable\Disable-NvAppTask.ps1"
    & "$PSScriptRoot\2_disable\Set-NvContainerLS.ps1"
    & "$PSScriptRoot\3_spawn\New-NvAppSpawner.ps1"
    & "$PSScriptRoot\4_kill\New-NvAppKiller.ps1"
    & "$PSScriptRoot\4_kill\Stop-NvAppServices.ps1"
}
