# Change these paths as needed
$pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe"
$installerFile = "$PSScriptRoot\python-installer.exe"
$installDir = "$PSScriptRoot\Python"

# Download the Python installer
Write-Host "Downloading Python installer..."
Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerFile

# Install Python locally (no registry, no PATH)
Write-Host "Installing Python locally in $installDir ..."
Start-Process -FilePath $installerFile -ArgumentList `
    "/quiet", `
    "InstallAllUsers=0", `
    "TargetDir=$installDir", `
    "PrependPath=0", `
    "Include_launcher=0", `
    "Include_pip=1", `
    "Include_tcltk=1", `
    "Shortcuts=0", `
    "AssociateFiles=0" `
    -Wait

# Remove installer to clean up
Remove-Item $installerFile

# Show a reminder to the user
Write-Host "`nPython has been installed locally to: $installDir"
Write-Host "To use it, run:"
Write-Host "`"$installDir\python.exe`" or `"$installDir\Scripts\pip.exe`""
Write-Host "`nYou can also create a virtual environment inside this folder."

# Optional: create a venv in current folder
$venvPath = "$PSScriptRoot\venv"
& "$installDir\python.exe" -m venv $venvPath
Write-Host "`nA virtual environment has been created at: $venvPath"
