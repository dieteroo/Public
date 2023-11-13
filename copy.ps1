[string] $SourceDirectoryPath = 'C:\Users\test\DCIM'
[string] $TargetDirectoryPath = 'C:\Users\test\Te sorteren'

[System.Collections.ArrayList] $filesToMove = Get-ChildItem -Path $SourceDirectoryPath -File -Force -Recurse

$filesToMove | ForEach-Object {
    [System.IO.FileInfo] $file = $_

    [DateTime] $fileDate = $file.LastWriteTime
    [string] $dateDirectoryName = $fileDate.ToString('yyyy-MM-dd')
    [string] $dateDirectoryPath = Join-Path -Path $TargetDirectoryPath -ChildPath $dateDirectoryName

    if (!(Test-Path -Path $dateDirectoryPath -PathType Container))
    {
        Write-Verbose "Aanmaken van folder '$dateDirectoryPath'." -ForegroundColor Yellow
        New-Item -Path $dateDirectoryPath -ItemType Directory -Force > $null
    }

    [string] $filePath = $file.FullName

    if (!(Test-Path -Path $dateDirectoryPath/$filePath -PathType Leaf))
    {
    Write-Information "Verplaatsen van '$filePath' naar folder '$dateDirectoryPath'." -ForegroundColor Green
    Move-Item -Path $filePath -Destination $dateDirectoryPath
    }
    elseif 
    {
    Write-Information "Bestand '$filePath' bestaat reeds in folder '$dateDirectoryPath'." -ForegroundColor Red
    }
}
