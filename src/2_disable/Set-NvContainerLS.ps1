$ErrorActionPreference = 'SilentlyContinue'

$ServiceName = 'NvContainerLocalSystem'

$Service = Get-Service -Name $ServiceName

if (-not $Service) {
    Write-Error -Message "Service '$ServiceName' was not found on this system." -ErrorAction 'Stop'
}

if ($Service.StartType -ne 'Manual') {
    Write-Host -Object "'$ServiceName' start type is currently set to '$($Service.StartType)'." -ForegroundColor 'Yellow'
    Write-Host -Object "Changing start type to 'Manual'..." -ForegroundColor 'Cyan'

    Set-Service -Name $ServiceName -StartupType 'Manual' -ErrorAction 'Stop'

    $Service = Get-Service -Name $ServiceName
    if ($Service.StartType -ne 'Manual') {
        Write-Error 'Failed to update the service.' -ErrorAction 'Stop'
    }

    Write-Host -Object "Successfully changed start type to 'Manual'." -ForegroundColor 'Green'
}
else {
    Write-Host -Object "Service '$ServiceName' start type is currently  set to 'Manual'. No change required." -ForegroundColor 'Green'
}
