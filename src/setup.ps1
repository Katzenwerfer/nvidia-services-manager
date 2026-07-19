. "$PSScriptRoot\0_shared\Test-IsElevated.ps1"
Test-IsElevated

# Part 1

& "$PSScriptRoot\1_setup\Enable-ProcessTracking.ps1"

# Part 2

& "$PSScriptRoot\2_disable\Disable-NvAppTask.ps1"
& "$PSScriptRoot\2_disable\Set-NvContainerLS.ps1"
& "$PSScriptRoot\2_disable\Set-NvDisplayContainerLS.ps1"

# Part 3

& "$PSScriptRoot\3_spawn\New-NvAppSpawner.ps1"
& "$PSScriptRoot\3_spawn\New-NvCplHelper.ps1"
& "$PSScriptRoot\3_spawn\New-NvCplSpawner.ps1"

# Part 4

& "$PSScriptRoot\4_kill\New-NvAppKiller.ps1"
& "$PSScriptRoot\4_kill\New-NvCplKiller.ps1"
& "$PSScriptRoot\4_kill\Stop-NvAppServices.ps1"
& "$PSScriptRoot\4_kill\Stop-NvCplServices.ps1"
