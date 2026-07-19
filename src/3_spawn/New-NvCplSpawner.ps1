$ErrorActionPreference = 'SilentlyContinue'

$TaskName = 'NvDisplayContainerLocalSystem Spawner (nvcplui.exe)'
$TaskPath = '\Custom\NVIDIA\'

$ScheduledTask = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath

if (-not $ScheduledTask) {
    Write-Host -Object 'Could not find the scheduled task.' -ForegroundColor 'Yellow'
    Write-Host -Object 'Generating a new one...' -ForegroundColor 'Cyan'

    # --------------------------------
    # === Scheduled Task Principal ===
    # --------------------------------

    $UserId = "$env:USERDOMAIN\$env:USERNAME"

    $ScheduledTaskPrincipal = New-ScheduledTaskPrincipal -UserId $UserId -LogonType 'S4U'

    # -----------------------------
    # === Scheduled Task Action ===
    # -----------------------------

    $ActionProcess = '"C:\Program Files\PowerShell\7\pwsh.exe"'
    $ActionScript = "$PSScriptRoot\Start-NvDisplayContainer.ps1"
    $ActionParameters = "-ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -WindowStyle Hidden -File `"$ActionScript`""

    $ScheduledTaskAction = New-ScheduledTaskAction -Execute $ActionProcess -Argument $ActionParameters

    # -------------------------------
    # === Scheduled Task Settings ===
    # -------------------------------

    $ScheduledTaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -StartWhenAvailable -DontStopIfGoingOnBatteries -MultipleInstances 'IgnoreNew'

    # ------------------------------
    # === Scheduled Task Trigger ===
    # ------------------------------

    $TargetProcess = Resolve-Path -Path 'C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_*\nvcplui.exe'
    $TargetQuery = @"
<QueryList>
    <Query Id="0" Path="Security">
        <Select Path="Security">
            *[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and
            (EventID=4688) and
            (Task=13312)]] and
            *[EventData[Data[@Name='NewProcessName'] and
            (Data='$TargetProcess')]]
        </Select>
    </Query>
</QueryList>
"@

    $ScheduledTaskTrigger = Get-CimClass -ClassName 'MSFT_TaskEventTrigger' -Namespace 'Root/Microsoft/Windows/TaskScheduler' | New-CimInstance -ClientOnly
    $ScheduledTaskTrigger.Subscription = $TargetQuery

    # ----------------------
    # === Scheduled Task ===
    # ----------------------

    New-ScheduledTask -Action $ScheduledTaskAction -Principal $ScheduledTaskPrincipal -Settings $ScheduledTaskSettings -Trigger $ScheduledTaskTrigger | Register-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath
}
else {
    Write-Host -Object 'Scheduled task already exists. No action taken.' -ForegroundColor 'Green'
}
