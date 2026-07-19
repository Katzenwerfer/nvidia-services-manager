$ErrorActionPreference = 'SilentlyContinue'

$TaskName = 'NVIDIA Control Panel Helper'
$TaskPath = '\Custom\NVIDIA\'

$ScheduledTask = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath

if (-not $ScheduledTask) {
    Write-Host -Object 'Could not find the scheduled task.' -ForegroundColor 'Yellow'
    Write-Host -Object 'Generating a new one...' -ForegroundColor 'Cyan'

    # --------------------------------
    # === Scheduled Task Principal ===
    # --------------------------------

    $UserId = "$env:USERDOMAIN\$env:USERNAME"

    $ScheduledTaskPrincipal = New-ScheduledTaskPrincipal -UserId $UserId -LogonType 'Interactive'

    # -----------------------------
    # === Scheduled Task Action ===
    # -----------------------------

    $TargetProcess = Resolve-Path -Path 'C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_*\nvcplui.exe'
    $ActionProcess = "`"$TargetProcess`""

    $ScheduledTaskAction = New-ScheduledTaskAction -Execute $ActionProcess

    # -------------------------------
    # === Scheduled Task Settings ===
    # -------------------------------

    $ScheduledTaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -StartWhenAvailable -DontStopIfGoingOnBatteries -MultipleInstances 'IgnoreNew'

    # -------------------------------
    # === Scheduled Task Creation ===
    # -------------------------------

    New-ScheduledTask -Action $ScheduledTaskAction -Principal $ScheduledTaskPrincipal -Settings $ScheduledTaskSettings | Register-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath | Out-Null

    # -----------------------------------
    # === Scheduled Task Verification ===
    # -----------------------------------

    $ScheduledTask = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath
    if (-not $ScheduledTask) {
        Write-Error -Message 'Failed to register scheduled task.' -ErrorAction 'Stop'
    }

    Write-Host -Object "Successfully created new scheduled task '$TaskPath$TaskName'." -ForegroundColor 'Green'
}
else {
    Write-Host -Object 'Scheduled task already exists. No action taken.' -ForegroundColor 'Green'
}
