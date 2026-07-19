$ErrorActionPreference = 'SilentlyContinue'

$TaskNameWildcard = 'NVIDIA App*'

$Task = Get-ScheduledTask -TaskName $TaskNameWildcard

if (-not $Task) {
    Write-Error -Message 'Scheduled task could not found on this system.' -ErrorAction 'Stop'
}

if ($Task.State -ne 'Disabled') {
    Write-Host -Object "Scheduled task is currently set to '$($Task.State)'." -ForegroundColor 'Yellow'
    Write-Host -Object "Changing state to 'Disabled'..." -ForegroundColor 'Cyan'

    Disable-ScheduledTask -TaskName $Task.TaskName -ErrorAction 'Stop' | Out-Null

    $Task = Get-ScheduledTask -TaskName $TaskNameWildcard
    if ($Task.State -ne 'Disabled') {
        Write-Error -Message 'Failed to change scheduled task state.' -ErrorAction 'Stop'
    }

    Write-Host -Object "Successfully changed state to 'Disabled'." -ForegroundColor 'Green'
}
else {
    Write-Host -Object "Scheduled task '$($Task.TaskName)' state is currently set to 'Disabled'. No action taken." -ForegroundColor 'Green'
}
