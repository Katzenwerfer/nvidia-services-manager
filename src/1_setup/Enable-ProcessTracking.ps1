$ErrorActionPreference = 'SilentlyContinue'

$SubcategoryName = 'Process Termination'

$Subcategory = & auditpol.exe /get /subcategory:"$SubcategoryName" /r | ConvertFrom-Csv
$Status = $Subcategory | Select-Object -ExpandProperty 'Inclusion Setting'

if ($Status -notlike '*Success*') {
    Write-Host -Object "Audit policy '$SubcategoryName' is currently set to $Status." -ForegroundColor 'Yellow'
    Write-Host -Object "Enabling 'Success' recording..." -ForegroundColor 'Cyan'

    & auditpol.exe /set /subcategory:"$SubcategoryName" /success:enable | Out-Null

    if ($LASTEXITCODE -ne 0) {
        Write-Error -Message "Failed to configure policy for '$SubcategoryName'. Make sure you are running as Administrator." -ErrorAction 'Stop'
    }

    Write-Host -Object "Successfully updated '$SubcategoryName' to register 'Success' events." -ForegroundColor 'Green'
}
else {
    Write-Host -Object "Audit policy '$SubcategoryName' is already set to $Status. No action taken." -ForegroundColor 'Green'
}
