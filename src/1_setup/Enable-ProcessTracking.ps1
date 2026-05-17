$ErrorActionPreference = 'SilentlyContinue'

$SubcategoryName = 'Process Termination'

& auditpol.exe /set /subcategory:"$SubcategoryName" /success:enable | Out-Null
