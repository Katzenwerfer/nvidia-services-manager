$ErrorActionPreference = 'SilentlyContinue'

$ServiceNames = @(
    'NvContainerLocalSystem',
    'NVDisplay.ContainerLocalSystem'
)

$TargetStartType = 'Manual'

foreach ($ServiceName in $ServiceNames) {
    $Service = Get-Service -Name $ServiceName

    if ($null -eq $Service) {
        Write-Error -Message "Service '$ServiceName' was not found on this system." -ErrorAction 'Stop'
    }

    if ($Service.StartType -ne $TargetStartType) {
        Write-Host -Object "'$ServiceName' start type is currently set to '$($Service.StartType)'." -ForegroundColor 'Yellow'
        Write-Host -Object "Changing start type to '$TargetStartType'..." -ForegroundColor 'Cyan'
        try {
            Set-Service -Name $ServiceName -StartupType $TargetStartType -ErrorAction 'Stop'
            Write-Host -Object "Successfully changed start type to '$TargetStartType'." -ForegroundColor 'Green'
        }
        catch {
            Write-Error "Failed to update the service. Make sure you are running as Administrator." -ErrorAction 'Stop'
        }
    }
    else {
        Write-Host -Object "Service '$ServiceName' start type is currently  set to '$TargetStartType'. No change required." -ForegroundColor 'Green'
    }
}
