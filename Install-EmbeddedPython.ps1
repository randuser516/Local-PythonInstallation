$pythonZipUrl = "https://www.python.org/ftp/python/3.12.2/python-3.12.2-embed-amd64.zip"
$zipFile = "$PSScriptRoot\python-embed.zip"
$pythonDir = "$PSScriptRoot\Python"

Write-Host "Downloading embedded Python..."
Invoke-WebRequest -Uri $pythonZipUrl -OutFile $zipFile

Write-Host "Extracting to $pythonDir ..."
Expand-Archive -Path $zipFile -DestinationPath $pythonDir -Force
Remove-Item $zipFile

$launcherPath = "$PSScriptRoot\run-python.bat"
$launcherContent = "@echo off`n%~dp0Python\python.exe %*"
Set-Content -Path $launcherPath -Value $launcherContent -Encoding ASCII

Write-Host "`nPython has been installed to: $pythonDir"