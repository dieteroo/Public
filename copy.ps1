[string] $SourceDirectoryPath = 'C:\Users\test\DCIM'
[string] $TargetDirectoryPath = 'C:\Users\test\Te sorteren'

[System.Collections.ArrayList] $filesToMove = Get-ChildItem -Path $SourceDirectoryPath -File -Force -Recurse

$filesToMove | ForEach-Object {
    [System.IO.FileInfo] $file = $_

    [DateTime] $fileDate = $file.LastWriteTime
    [string] $dateDirectoryName = $fileDate.ToString('yyyy.MM.dd')
    [string] $dateDirectoryPath = Join-Path -Path $TargetDirectoryPath -ChildPath $dateDirectoryName

    if (!(Test-Path -Path $dateDirectoryPath -PathType Container))
    {
        Write-Verbose "Creating directory '$dateDirectoryPath'."
        New-Item -Path $dateDirectoryPath -ItemType Directory -Force > $null
    }

    [string] $filePath = $file.FullName
    Write-Information "Moving file '$filePath' into directory '$dateDirectoryPath'."
    Move-Item -Path $filePath -Destination $dateDirectoryPath
}
