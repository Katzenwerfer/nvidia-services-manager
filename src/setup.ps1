# Part 1

& "$PSScriptRoot\1_setup\Enable-ProcessTracking.ps1"

# Part 2

& "$PSScriptRoot\2_disable\Disable-NvAppTask.ps1"
& "$PSScriptRoot\2_disable\Set-NvContainerLS.ps1"
& "$PSScriptRoot\2_disable\Set-NvDisplayContainer.ps1"

# Part 3

& "$PSScriptRoot\3_spawn\New-NvCplSpawner.ps1"

# Part 4

& "$PSScriptRoot\4_kill\New-NvAppKiller.ps1"
& "$PSScriptRoot\4_kill\New-NvCplKiller.ps1"
& "$PSScriptRoot\4_kill\Stop-NvContainerLS.ps1"
& "$PSScriptRoot\4_kill\Stop-NvDisplayContainer.ps1"
