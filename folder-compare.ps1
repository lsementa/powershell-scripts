# Set the paths of the two directories
$dir1 = "C:\Users\lsementa\Desktop\folder1"
$dir2 = "C:\Users\lsementa\Desktop\folder2"

# Get lists of file names (not full paths) in each directory
$filesInDir1 = Get-ChildItem -Path $dir1 -File | ForEach-Object { $_.Name }
$filesInDir2 = Get-ChildItem -Path $dir2 -File | ForEach-Object { $_.Name }

# Find files present in $dir1 but not in $dir2
$missingInDir2 = $filesInDir1 | Where-Object { $_ -notin $filesInDir2 }
# Find files present in $dir2 but not in $dir1
$missingInDir1 = $filesInDir2 | Where-Object { $_ -notin $filesInDir1 }

# Output the results
if ($missingInDir2.Count -eq 0 -and $missingInDir1.Count -eq 0) {
    Write-Output "Both directories contain the same files."
} else {
    if ($missingInDir2.Count -gt 0) {
        Write-Output "Files in ${dir1} but not in ${dir2}:"
        $missingInDir2 | ForEach-Object { Write-Output $_ }
    }
    
    if ($missingInDir1.Count -gt 0) {
        Write-Output "Files in ${dir2} but not in ${dir1}:"
        $missingInDir1 | ForEach-Object { Write-Output $_ }
    }
}

