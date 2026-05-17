$ErrorActionPreference = 'SilentlyContinue'

$ServiceNames = @(
    'NvContainerLocalSystem',
    'NVDisplay.ContainerLocalSystem'
)

foreach ($ServiceName in $ServiceNames) {
    $Service = Get-Service -Name $ServiceName

    if ($Service.StartType -ne 'Manual') {
        Write-Host -Object "'$ServiceName' start type is currently set to '$($Service.StartType)'." -ForegroundColor 'Yellow'
        Write-Host -Object "Changing start type to 'Manual'..." -ForegroundColor 'Cyan'

        Set-Service -Name $ServiceName -StartupType 'Manual' -ErrorAction 'Stop'

        Write-Host -Object "Successfully changed start type to 'Manual'." -ForegroundColor 'Green'
    }
    else {
        Write-Host -Object "Service '$ServiceName' start type is currently  set to 'Manual'. No change required." -ForegroundColor 'Green'
    }
}
