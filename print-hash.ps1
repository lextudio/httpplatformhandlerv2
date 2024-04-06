# Get all .msi files in the current directory
$msiFiles = Get-ChildItem -Path "artifacts\installers\Release" -Filter "*.msi"

# For each .msi file
foreach ($file in $msiFiles) {
    # Calculate the SHA-1 hash
    $hash = Get-FileHash -Algorithm SHA1 $file.FullName

    # Print the file name and the hash
    Write-Output "* $($file.Name): $($hash.Hash)"
}
