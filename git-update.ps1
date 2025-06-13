#requires -PSEdition Core

$targetBranch = "release-jackson"
$allowList = "devops-academy-one" , "devops-academy-two"


# Get all folders containing a .git subfolder (indicating a Git repo)
Get-ChildItem -Path . -Directory -Recurse | Where-Object {
    Test-Path "$($_.FullName)/.git"
} | ForEach-Object {
    $repoPath = $_.FullName
    $repoName = $_.Name

    if ($allowList -contains $repoName){
        Write-Host "`n--- Processing repository: $repoName ---" -ForegroundColor Cyan

        try {
            Push-Location $repoPath

            Write-Host "Switching to 'main' branch..." -ForegroundColor Yellow
            git checkout main
            git pull

            Write-Host "Switching to '$targetBranch' branch..." -ForegroundColor Yellow
            git checkout $targetBranch
            git pull

            Write-Host "Rebasing '$targetBranch' onto 'main'..." -ForegroundColor Yellow
            git rebase mai

            if ($LASTEXITCODE -eq 0){
                Write-Host "Force pushing changes to '$targetBranch'..." -ForegroundColor Yellow
                git push -f
            }
        }
        catch {
            Write-Error "Error processing $repoName : $($_.Exception.Message)"
        }
        finally {
            Pop-Location
        }
}
}
