function New-RandomUser {
    <#
        .SYNOPSIS
        The function New-RandomUser creates a random user using the API provided by the creators of RANDOM USER GENERATOR - https://randomuser.me

        .DESCRIPTION
        The function New-RandomUser creates a random user using the API provided by the creators of RANDOM USER GENERATOR - https://randomuser.me a free and easy to use service to generate random user data for application testing.

        You can request a different nationality of a randomuser. Pictures won't be affected by this, but data such as location, home phone, id, etc. will be more appropriate.

        .EXAMPLE
        New-RandomUser
        Creates a single random user

        .EXAMPLE
        New-RandomUser -Nationality GB -PassLength 14 -Quantity 10 -Email "leigh-services.com"
        Creates 10 random users from United Kingdom, with a password length of 14 characters and with an email address @leigh-services.com

        .INPUTS
        [string] Nationality
        [int] PassLength
        [int] Quantity
        [string] Email
        
        .OUTPUTS
                
        .NOTES
        Author:     Luke Leigh
        Website:    https://blog.lukeleigh.com/
        LinkedIn:   https://www.linkedin.com/in/lukeleigh/
        GitHub:     https://github.com/BanterBoy/
        GitHubGist: https://gist.github.com/BanterBoy

        .LINK
        https://github.com/BanterBoy
    #>

    [CmdletBinding(
        DefaultParameterSetName = "Default")]
    Param
    (
        # Please select the user nationality. The default setting will choose a Random nationality.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please select the user nationality. The default setting will choose a Random nationality.")]
        [ValidateSet('AU', 'BR', 'CA', 'CH', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'IE', 'IR', 'NO', 'NL', 'NZ', 'TR', 'US', 'Random') ]
        [string]
        $Nationality = "Random",
        # Please enter or select password length. The default length is 10 characters.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please enter or select password length. The default length is 10 characters.")]
        [ValidateSet('8', '10', '12', '14', '16', '18', '20') ]
        [int]
        $PassLength = "10",
        # Please select number of results. The default is 1. Min-Max = 1-5000
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please select number of results. The default is 1. Min-Max = 1-5000")]
        [ValidateRange(1, 5000)]
        [int]
        $Quantity = "1",
        # Specify the user's e-mail address. This parameter sets the EmailAddress property of a user object. The default value is $env:USERDNSDOMAIN.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Specify the user's e-mail address. This parameter sets the EmailAddress property of a user object.")]
        [string]
        $Email = "$env:USERDNSDOMAIN"
    )

    BEGIN {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    }

    PROCESS {

        $Uri = "https://randomuser.me/api/?nat=$Nationality&password=upper,lower,special,number,$PassLength&format=PrettyJSON&results=$Quantity"
        $Results = Invoke-RestMethod -Method GET -Uri $Uri -UseBasicParsing
        $mail = ($Email).ToLower()
        
        try {
            foreach ( $item in $Results.results ) {
                $RandomUser = [ordered]@{
                    "Name"              = $item.name.first + " " + $item.name.last
                    "Title"             = $item.name.title
                    "GivenName"         = $item.name.first
                    "Surname"           = $item.name.last
                    "DisplayName"       = $item.name.title + " " + $item.name.first + " " + $item.name.last
                    "HouseNumber"       = $item.location.street.number
                    "StreetAddress"     = $item.location.street.name
                    "City"              = $item.location.city
                    "State"             = $item.location.state
                    "Country"           = $item.location.country
                    "PostalCode"        = $item.location.postcode
                    "UserPrincipalName" = $item.name.first + "." + $item.name.last + "@" + $mail
                    "PersonalEmail"     = $item.email
                    "SamAccountName"    = $item.name.first + $item.name.last
                    "HomePhone"         = $item.phone
                    "MobilePhone"       = $item.cell
                    "Gender"            = $item.gender
                    "Nationality"       = $item.nat
                    "Age"               = $item.dob.age
                    "DateOfBirth"       = $item.dob.date
                    "NINumber"          = $item.id.value
                    "TimeZone"          = $item.location.timezone.description
                    "TimeOffset"        = $item.location.timezone.offset
                    "Latitude"          = $item.location.coordinates.latitude
                    "Longitude"         = $item.location.coordinates.longitude
                    "Username"          = $item.login.username
                    "UUID"              = $item.login.uuid
                    "AccountPassword"   = $item.login.password
                    "Salt"              = $item.login.salt
                    "MD5"               = $item.login.md5
                    "Sha1"              = $item.login.sha1
                    "Sha256"            = $item.login.sha256
                    "LargePicture"      = $item.picture.large
                    "MediumPicture"     = $item.picture.medium
                    "ThumbnailPicture"  = $item.picture.thumbnail
                }
                $obj = New-Object -TypeName PSObject -Property $RandomUser
                Write-Output $obj
            }
        }
        catch {
            Write-Verbose -Message "$_"
        }

    }

    END {

    }

}
function New-TempADUser {

    <#
        .SYNOPSIS
        Function to 

        .DESCRIPTION
        Function to
        https://randomuser.me/

        .EXAMPLE
        New-TempADUserDetails

        .INPUTS
        
        .OUTPUTS
                
        .NOTES
        Author:     Luke Leigh
        Website:    https://blog.lukeleigh.com/
        LinkedIn:   https://www.linkedin.com/in/lukeleigh/
        GitHub:     https://github.com/BanterBoy/
        GitHubGist: https://gist.github.com/BanterBoy

        .LINK
        https://github.com/BanterBoy
    #>
            
    [CmdletBinding(
        SupportsShouldProcess = $true,
        DefaultParameterSetName = "Default")]
    param (
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $Name,
            
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $Title,
    
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $GivenName,

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $Surname,
        
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $DisplayName,

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $SamAccountName,

        
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $StreetAddress,
        
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $State,
            
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $City,
            
        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $Country,

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $PostalCode,

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $UserPrincipalName,

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please enter the DistinguishedName for the OU path for your Email address."
        )]
        [string]
        $Path = (Get-ADDomain).UsersContainer,

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Please enter your"
        )]
        [string]
        $AccountPassword
            
    )
            
    begin {
                
    }
    
    process {
        if ($path) {
            $userUserSettings = @{
                Name                  = $_.Name
                Title                 = $_.Title
                GivenName             = $_.GivenName
                Surname               = $_.Surname
                DisplayName           = $_.DisplayName
                SamAccountName        = $_.SamAccountName
                UserPrincipalName     = $_.UserPrincipalName
                StreetAddress         = $_.StreetAddress
                State                 = $_.State
                City                  = $_.City
                Country               = $_.Country
                PostalCode            = $_.PostalCode
                AccountPassword       = (ConvertTo-SecureString -String $AccountPassword -AsPlainText -Force)
                Enabled               = $true
                ChangePasswordAtLogon = $true
                Path                  = $Path
            }
            
            New-ADUser @userUserSettings -Verbose
        }
        else {
            $userUserSettings = @{
                Name                  = $_.Name
                Title                 = $_.Title
                GivenName             = $_.GivenName
                Surname               = $_.Surname
                DisplayName           = $_.DisplayName
                SamAccountName        = $_.SamAccountName
                UserPrincipalName     = $_.UserPrincipalName
                StreetAddress         = $_.StreetAddress
                State                 = $_.State
                City                  = $_.City
                Country               = $_.Country
                PostalCode            = $_.PostalCode
                AccountPassword       = (ConvertTo-SecureString -String $AccountPassword -AsPlainText -Force)
                Enabled               = $true
                ChangePasswordAtLogon = $true
            }
            
            New-ADUser @userUserSettings -Verbose
        }
    }
        
    end {
        
    }
}
function New-TempADUserDetails {
    
    <#
        .SYNOPSIS
        The function New-TempADUserDetails creates a random user using the API provided by the creators of RANDOM USER GENERATOR - https://randomuser.me

        .DESCRIPTION
        The function New-TempADUserDetails creates a random user using the API provided by the creators of RANDOM USER GENERATOR - https://randomuser.me a free and easy to use service to generate random user data for application testing.

        You can request a different nationality of a randomuser. Pictures won't be affected by this, but data such as location, home phone, id, etc. will be more appropriate.

        .EXAMPLE
        New-RandomUser
        Creates a single random user

        .EXAMPLE
        New-TempADUserDetails -Path (Get-ADDomain).UsersContainer 

        .EXAMPLE
        New-RandomUser -Nationality GB -PassLength 14 -Quantity 10 -Email "leigh-services.com"
        Creates 10 random users from United Kingdom, with a password length of 14 characters and with an email address @leigh-services.com

        .INPUTS
        [string] Nationality
        [int] PassLength
        [int] Quantity
        [string] Email
        
        .OUTPUTS
                
        .NOTES
        Author:     Luke Leigh
        Website:    https://blog.lukeleigh.com/
        LinkedIn:   https://www.linkedin.com/in/lukeleigh/
        GitHub:     https://github.com/BanterBoy/
        GitHubGist: https://gist.github.com/BanterBoy

        .LINK
        https://github.com/BanterBoy
    #>

    [CmdletBinding(
        DefaultParameterSetName = "Default")]
    Param
    (
        # Please select the user nationality. The default setting will choose a Random nationality.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please select the user nationality. The default setting will choose a Random nationality.")]
        [ValidateSet('AU', 'BR', 'CA', 'CH', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'IE', 'IR', 'NO', 'NL', 'NZ', 'TR', 'US', 'Random') ]
        [string]
        $Nationality = "Random",
        # Please enter or select password length. The default length is 10 characters.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please enter or select password length. The default length is 10 characters.")]
        [ValidateSet('8', '10', '12', '14', '16', '18', '20') ]
        [int]
        $PassLength = "10",
        # Please select number of results. The default is 1. Min-Max = 1-5000
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Please select number of results. The default is 1. Min-Max = 1-5000")]
        [ValidateRange(1, 5000)]
        [int]
        $Quantity = "1",
        # Specify the user's e-mail address. This parameter sets the EmailAddress property of a user object. The default value is $env:USERDNSDOMAIN.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Specify the user's e-mail address. This parameter sets the EmailAddress property of a user object.")]
        [string]
        $Email = "$env:USERDNSDOMAIN",
        # Enter the X.500 path of the Organizational Unit (OU) or container where the new object is created.
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Default",
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Enter the X.500 path of the Organizational Unit (OU) or container where the new object is created.")]
        [string]
        $Path
    )

    BEGIN {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    }

    PROCESS {

        $Uri = "https://randomuser.me/api/?nat=$Nationality&password=upper,lower,special,number,$PassLength&format=json&results=$Quantity"
        $Results = Invoke-RestMethod -Method GET -Uri $Uri -UseBasicParsing
        $mail = ($Email).ToLower()
        
        try {
            foreach ( $item in $Results.results ) {
                if ($Path) {
                    $NewFakeUser = [ordered]@{
                        "Name"              = $item.name.first + " " + $item.name.last
                        "Title"             = $item.name.title
                        "GivenName"         = $item.name.first
                        "Surname"           = $item.name.last
                        "DisplayName"       = $item.name.title + " " + $item.name.first + " " + $item.name.last
                        "HouseNumber"       = $item.location.street.number
                        "StreetAddress"     = $item.location.street.name
                        "City"              = $item.location.city
                        "State"             = $item.location.state
                        "Country"           = $item.nat
                        "PostalCode"        = $item.location.postcode
                        "UserPrincipalName" = $item.name.first + "." + $item.name.last + "@" + $mail
                        "SamAccountName"    = $item.name.first + $item.name.last
                        "AccountPassword"   = $item.login.password
                        "Path"              = $Path
                    }
                    $obj = New-Object -TypeName PSObject -Property $NewFakeUser
                    Write-Output $obj
                }
                else {
                    $NewFakeUser = [ordered]@{
                        "Name"              = $item.name.first + " " + $item.name.last
                        "Title"             = $item.name.title
                        "GivenName"         = $item.name.first
                        "Surname"           = $item.name.last
                        "DisplayName"       = $item.name.title + " " + $item.name.first + " " + $item.name.last
                        "HouseNumber"       = $item.location.street.number
                        "StreetAddress"     = $item.location.street.name
                        "City"              = $item.location.city
                        "State"             = $item.location.state
                        "Country"           = $item.nat
                        "PostalCode"        = $item.location.postcode
                        "UserPrincipalName" = $item.name.first + "." + $item.name.last + "@" + $mail
                        "SamAccountName"    = $item.name.first + $item.name.last
                        "AccountPassword"   = $item.login.password
                    }
                    $obj = New-Object -TypeName PSObject -Property $NewFakeUser
                    Write-Output $obj
                }
            }
        }
        catch {
            Write-Verbose -Message "$_"
        }

    }

    END {

    }

}
