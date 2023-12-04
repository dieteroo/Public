[string] $SourceDirectoryPath = 'G:\DCIM\100MSDCF'
[string] $MyPictures = [environment]::GetFolderPath('MyPictures')
[string] $TargetDirectoryPath = $MyPictures + '\00_TE_SORTEREN'

[System.Collections.ArrayList] $filesToMove = Get-ChildItem -Path $SourceDirectoryPath -File -Force -Recurse

if (!(Test-Path -Path $TargetDirectoryPath -PathType Container)) {
    Write-Host "Aanmaken van folder '$TargetDirectoryPath'." -ForegroundColor Yellow
    New-Item -Path $TargetDirectoryPath -ItemType Directory -Force > $null
}

if ($filesToMove.count -gt 0) {
    $filesToMove | ForEach-Object {
        [System.IO.FileInfo] $file = $_

        [DateTime] $fileDate = $file.LastWriteTime
        [string] $dateDirectoryName = $fileDate.ToString('yyyy-MM-dd')
        [string] $dateDirectoryPath = Join-Path -Path $TargetDirectoryPath -ChildPath $dateDirectoryName

        if (!(Test-Path -Path $dateDirectoryPath -PathType Container)) {
            Write-Host "Aanmaken van folder '$dateDirectoryPath'." -ForegroundColor Yellow
            New-Item -Path $dateDirectoryPath -ItemType Directory -Force > $null
        }

        [string] $filePath = $file.FullName
        
        if (!(Test-Path -Path $dateDirectoryPath/$file -PathType Leaf)) {
            Write-Host "Verplaatsen van '$filePath' naar folder '$dateDirectoryPath' gelukt" -ForegroundColor Green
            Move-Item -Path $filePath -Destination $dateDirectoryPath
        }
        
        else {
            Write-Host "Bestand '$filePath' bestaat reeds in folder '$dateDirectoryPath'." -ForegroundColor Red
        }
    }
}
else {
    Write-Host "Geen bestanden gevonden om te kopieren" -ForegroundColor Red
}

Read-Host -Prompt "Druk op de enter toets om dit venster te sluiten en de map $TargetDirectoryPath weer te geven"

Invoke-Item $TargetDirectoryPath
