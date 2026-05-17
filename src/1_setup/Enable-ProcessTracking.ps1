$ErrorActionPreference = 'SilentlyContinue'

$SubcategoryName = 'Process Termination'

$Subcategory = & auditpol.exe /get /subcategory:"$SubcategoryName" /r | ConvertFrom-Csv
$Status = $Subcategory | Select-Object -ExpandProperty 'Inclusion Setting'

if ($Status -notlike '*Success*') {
    Write-Host -Object "Audit policy '$SubcategoryName' is currently set to $Status." -ForegroundColor 'Yellow'
    Write-Host -Object "Enabling 'Success' recording..." -ForegroundColor 'Cyan'

    & auditpol.exe /set /subcategory:"$SubcategoryName" /success:enable | Out-Null

    Write-Host -Object "Successfully updated '$SubcategoryName' to register 'Success' events." -ForegroundColor 'Green'
}
else {
    Write-Host -Object "Audit policy '$SubcategoryName' is already set to $Status. No action taken." -ForegroundColor 'Green'
}
