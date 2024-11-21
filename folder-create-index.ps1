# Folder location
$folderPath = "C:\Users\lsementa\Documents\Degree Advice\Audits\PDFs"
# Define the output CSV file
$outputCsv = "$folderPath\index.csv"

# Get all subfolders
$subfolders = Get-ChildItem -Path $folderPath -Directory

# Check if there are any subfolders
if ($subfolders.Count -eq 0) {
    Write-Host "No subfolders found in the specified path." -ForegroundColor Yellow
    exit
}

# Initialize an empty array to store results
$results = @()

# Initialize progress bar variables
$totalFolders = $subfolders.Count
$currentFolderIndex = 0

# Iterate through each subfolder in the folder path
foreach ($subFolder in $subfolders) {
    $currentFolderIndex++
    $folderName = $subFolder.Name

    # Update the progress bar
    Write-Progress -Activity "Creating Index File ..." `
        -Status "Processing folder $currentFolderIndex of $($totalFolders): $folderName" `
        -PercentComplete (($currentFolderIndex / $totalFolders) * 100)

    # Iterate through each file in the subfolder
    Get-ChildItem -Path $subFolder.FullName -File | ForEach-Object {
        $fileName = $_.Name

        # Extract the ID, School, and Degree from the file name
        if ($fileName -match '^.*?_(U[0-9]+)_([0-9]+)_([0-9]+)\.pdf$') {
            $id = $matches[1]
            $school = $matches[2]
            $degree = $matches[3]

            # Add to results
            $results += [PSCustomObject]@{
                FolderName = $folderName
                ID         = $id
                School     = $school
                Degree     = $degree
            }
        }
    }
}

# Export results to CSV
$results | Export-Csv -Path $outputCsv -NoTypeInformation -Force

Write-Host "CSV file created at $outputCsv" -ForegroundColor Green