# Define version and URLs
$version = "3.10.11"
$major = "310"
$pythonUrl = "https://www.python.org/ftp/python/$version/python-$version-embed-amd64.zip"
$pythonwUrl = "https://www.python.org/ftp/python/$version/pythonw.exe"
$pipUrl = "https://bootstrap.pypa.io/get-pip.py"

# Define paths
$workDir = "$PSScriptRoot\python-embed"
$zipPath = "$PSScriptRoot\python-embed.zip"
$pythonwPath = "$workDir\pythonw.exe"
$getPipPath = "$workDir\get-pip.py"

# Create work directory
New-Item -ItemType Directory -Force -Path $workDir | Out-Null

# Download embedded python zip
Invoke-WebRequest $pythonUrl -OutFile $zipPath

# Extract it
Expand-Archive -Path $zipPath -DestinationPath $workDir -Force

# Clean up zip
Remove-Item $zipPath

# Download get-pip.py
Invoke-WebRequest $pipUrl -OutFile $getPipPath

# Allow imports in _pth file
$pthFile = Get-ChildItem "$workDir\python*.pth" | Select-Object -First 1
Add-Content $pthFile "`nimport site"

# Install pip using python.exe
Start-Process -FilePath "$workDir\python.exe" -ArgumentList "get-pip.py" -WorkingDirectory $workDir -Wait

# Download pythonw.exe
Invoke-WebRequest $pythonwUrl -OutFile $pythonwPath

Write-Host "Python embedded setup complete in $workDir"
