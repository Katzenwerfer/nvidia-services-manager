$ErrorActionPreference = 'SilentlyContinue'

$TaskNameWildcard = 'NVIDIA App*'

$TargetState = 'Disabled'

$Task = Get-ScheduledTask -TaskName $TaskNameWildcard

if ($null -eq $Task) {
    Write-Error -Message 'Scheduled task could not found on this system.' -ErrorAction 'Stop'
}

if ($Task.State -ne $TargetState) {
    Write-Host -Object "Scheduled task is currently set to '$($Task.State)'." -ForegroundColor 'Yellow'
    Write-Host -Object "Changing state to '$TargetState'..." -ForegroundColor 'Cyan'
    try {
        Disable-ScheduledTask -TaskName $Task.TaskName -ErrorAction 'Stop' | Out-Null
        Write-Host -Object "Successfully changed state to '$TargetState'." -ForegroundColor 'Green'
    }
    catch {
        Write-Error -Message "Failed to change scheduled task state. Make sure you are running as Administrator." -ErrorAction 'Stop'
    }
}
else {
    Write-Host -Object "Scheduled task state is currently set to '$TargetState'. No action taken." -ForegroundColor 'Green'
}
