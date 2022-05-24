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
