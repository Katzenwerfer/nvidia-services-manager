$ErrorActionPreference = 'SilentlyContinue'

$SubcategoryNames = @(
    'Process Creation',
    'Process Termination'
)

function Get-SubcategoryStatus {
    param ([string]$SubcategoryName)
    $Subcategory = & auditpol.exe /get /subcategory:"$SubcategoryName" /r | ConvertFrom-Csv
    return $Subcategory | Select-Object -ExpandProperty 'Inclusion Setting'
}

foreach ($SubcategoryName in $SubcategoryNames) {
    $Status = Get-SubcategoryStatus -SubcategoryName $SubcategoryName
    if ($Status -notlike '*Success*') {
        Write-Host -Object "Audit policy '$SubcategoryName' is currently set to $Status." -ForegroundColor 'Yellow'
        Write-Host -Object "Enabling 'Success' recording..." -ForegroundColor 'Cyan'

        & auditpol.exe /set /subcategory:"$SubcategoryName" /success:enable | Out-Null

        $Status = Get-SubcategoryStatus -SubcategoryName $SubcategoryName
        if ($Status -notlike '*Success*') {
            Write-Error -Message "Failed to configure policy for '$SubcategoryName'." -ErrorAction 'Stop'
        }

        Write-Host -Object "Successfully updated '$SubcategoryName' to register 'Success' events." -ForegroundColor 'Green'
    }
    else {
        Write-Host -Object "Audit policy '$SubcategoryName' is already set to $Status. No action taken." -ForegroundColor 'Green'
    }
}
