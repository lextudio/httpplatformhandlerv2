$files = Get-ChildItem .\artifacts\installers\Release\* -Include ('*.msi') -File

Write-Output "SHA-1 hashes of the installers are,`n"

foreach ($file in $files) {
    $hash = Get-FileHash $file.FullName -Algorithm SHA1
    Write-Output "* $($file.Name): $($hash.Hash)"
}
