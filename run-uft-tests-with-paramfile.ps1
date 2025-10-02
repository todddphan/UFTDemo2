$testRoot = "C:\\VIP\\Demos\\Github\\UFTDemo2\\uft-one-tests"
$resultsRoot = "C:\\VIP\\Demos\\Github\\UFTDemo2\\Results"
$tempParamsRoot = "C:\\VIP\\Demos\\Github\\UFTDemo2\\TempParams"

# Ensure the TempParams folder exists
if (!(Test-Path -Path $tempParamsRoot)) {
    New-Item -ItemType Directory -Path $tempParamsRoot | Out-Null
}

# Loop through each test folder
Get-ChildItem -Path $testRoot -Directory | ForEach-Object {
    $testName = $_.Name
    $testPath = $_.FullName
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $resultsFile = "$resultsRoot\\$testName`_$timestamp.html"
    $paramFile = "$tempParamsRoot\\$testName`_params.txt"

    # Create the parameter file content with double backslashes
    $paramContent = @"
[General]
RunMode=Normal
runType=FileSystem
resultsFilename=$resultsFile

[Test1]
Test1=$testPath
"@

    # Save the parameter file
    $paramContent | Out-File -FilePath $paramFile -Encoding ASCII

    # Run the test using FTToolsLauncher
    & "C:\Tools\FTToolsLauncher\FTToolsLauncher.exe" -paramfile $paramFile
}