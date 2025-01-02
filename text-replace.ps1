# Folder path and the find/replace terms
$folderPath = "C:\Users\lsementa\Documents\Degree Advice\degree-advice-pdf\Dashboard"
$findText = 'C:/users/'
$replaceText = 'file:///C:/Users/'

# Get all files in the folder (you can add filters like *.txt or *.js if you want specific files)
$files = Get-ChildItem -Path $folderPath -File
#$files = Get-ChildItem -Path $folderPath -File -Filter *.txt

# Loop through each file in the folder
foreach ($file in $files) {
    # Read the file content
    $content = Get-Content -Path $file.FullName
    # Replace the findText with replaceText
    $newContent = $content -replace $findText, $replaceText
    
    # If the content has changed, write the new content back to the file
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "Updated file: $($file.FullName)"
    }
}
