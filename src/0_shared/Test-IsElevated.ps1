function Test-IsElevated {
    $WindowsPrincipal = [System.Security.Principal.WindowsPrincipal]
    $WindowsIdentity = [System.Security.Principal.WindowsIdentity]
    $WindowsBuiltInRole = [Security.Principal.WindowsBuiltInRole]

    $CurrentIdentity = New-Object -TypeName $WindowsPrincipal -ArgumentList $WindowsIdentity::GetCurrent()

    $IsElevated = $CurrentIdentity.IsInRole($WindowsBuiltInRole::Administrator)

    if ($IsElevated -eq $false) {
        Write-Error -Message "This script requires local admin privileges. Please run it as administrator." -ErrorAction 'Stop'
    }
}
