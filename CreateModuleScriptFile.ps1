$Scripts = Get-ChildItem C:\GitRepos\CreateTestAccounts\PSRandomUser\Public\ -File | Select-Object -Property FullName
foreach ( $Script in $Scripts) {
    $Content = Get-Content -Path $Script.fullname
    Add-Content -Path C:\GitRepos\CreateTestAccounts\PSRandomUser\PSRandomUser.psm1 -Value $Content
}
