$O365user = New-FakeADUserDetails -Nationality GB -PassLength 14 -Quantity 10 -Email "leigh-services.com"
$O365user | New-FakeADUser
$O365user | Format-Table -Property * -AutoSize -Wrap

$OnPremUser = New-FakeADUserDetails -Nationality GB -PassLength 14 -Quantity 10
$OnPremUser | New-FakeADUser
$OnPremUser | Format-Table -Property * -AutoSize -Wrap


Get-ADUser -Filter { Name -like '*Luke*' } -Properties * | Select-Object -Property SamAccountName, GivenName, Surname, Initials, DisplayName, EmployeeID, EmployeeNumber, Description, Title, Company, Organization, Department, Division, Office, StreetAddress, City, State, Country, PostalCode, POBox, Manager, HomePhone, OfficePhone, MobilePhone, Fax, EmailAddress, UserPrincipalName, HomePage, ProfilePath, HomeDirectory, HomeDrive, ScriptPath, AccountExpirationDate, CannotChangePassword, ChangePasswordAtLogon, PasswordNotRequired, PasswordNeverExpires, Enabled
