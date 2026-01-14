import-module au

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

Get-ChildItem -Path $scriptDir -Directory | ForEach-Object {
    $updateScript = Join-Path $_.FullName 'update.ps1'
    if (Test-Path $updateScript) {
        Write-Host "Updating package: $($_.Name)"
        Push-Location $_.FullName
        try {
            & $updateScript
        } finally {
            Pop-Location
        }
    }
}
