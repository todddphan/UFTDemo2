
$testRoot = "C:\VIP\Demos\Github\UFTDemo2\uft-one-tests"
$resultsRoot = "C:\VIP\Demos\Github\UFTDemo2\Results"
$paramFolder = "$resultsRoot\TempParams"

# Create the parameter folder if it doesn't exist
if (!(Test-Path -Path $paramFolder)) {
    New-Item -ItemType Directory -Path $paramFolder | Out-Null
}

# Loop through each test folder
Get-ChildItem -Path $testRoot -Directory | ForEach-Object {
    $testName = $_.Name
    $testPath = $_.FullName
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $resultsFile = "$resultsRoot\$testName`_$timestamp.html"
    $paramFile = "$paramFolder\params_$testName.txt"

    # Create the parameter file content
    $paramContent = @"
[General]
RunMode=Normal
runType=FileSystem
resultsFilename=$resultsFile

[Test1]
TestPath=$testPath
"@

    # Save the parameter file
    $paramContent | Set-Content -Path $paramFile -Encoding UTF8

    # Run FTToolsLauncher with the parameter file
    Write-Host "Running test: $testName"
    & "C:\Tools\FTToolsLauncher\FTToolsLauncher.exe" -paramfile $paramFile
}
