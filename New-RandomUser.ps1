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
            HelpMessage = "Specify the user's e-mail address. This parameter sets the EmailAddress property of a user object. The default value is $env:USERDNSDOMAIN.")]
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
