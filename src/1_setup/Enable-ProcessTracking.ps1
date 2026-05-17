$ErrorActionPreference = 'SilentlyContinue'

$SubcategoryName = 'Process Termination'

$Subcategory = & auditpol.exe /get /subcategory:"$SubcategoryName" /r | ConvertFrom-Csv
$Status = $Subcategory | Select-Object -ExpandProperty 'Inclusion Setting'

& auditpol.exe /set /subcategory:"$SubcategoryName" /success:enable | Out-Null
