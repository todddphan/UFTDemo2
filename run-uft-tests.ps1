$testRoot = "C:\VIP\Demos\Github\UFTDemo2\uft-one-tests"
$resultsRoot = "C:\VIP\Demos\Github\UFTDemo2\Results"

Get-ChildItem -Path $testRoot -Directory | ForEach-Object {
    $testName = $_.Name
    $testPath = $_.FullName
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $resultsFile = "$resultsRoot\$testName`_$timestamp.html"

    Write-Host "Running test: $testName"
    & "C:\Tools\FTToolsLauncher\FTToolsLauncher.exe" `
        -testpath $testPath `
        -resultsfilename $resultsFile `
        -runmode "Normal" `
        -runtype "FileSystem"
}