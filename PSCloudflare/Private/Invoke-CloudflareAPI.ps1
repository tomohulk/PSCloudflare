Function Invoke-CloudflareAPI {
    
    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'Email to authenticate with.' )]
        [String]
        $Email = $env:CloudflareEmail,

        [Parameter( HelpMessage = 'API Key to authenticate with.' )]
        [String]
        $APIKey = $env:CloudflareAPIKey,

        [Parameter( Mandatory = $false )]
        [HashTable] 
        $Headers = @{},
        
        [Parameter( Mandatory = $true )]
        [ValidateSet( 'GET', 'POST', 'PUT', 'PATCH', 'DELETE' )]
        [String] 
        $Method,

        [Parameter( HelpMessage = 'URI Endpoint to invoke the webrequest aginst.', Mandatory = $true )]
        [String] 
        $Endpoint,

        [Parameter()]
        [String]
        $Data,

        [Parameter()]
        [String]
        $Form
    )

    Begin {
        if ($null -eq $env:CloudflareEmail) {
            Write-Error -Message 'The env:CloudflareEmail Environment Variable is $null.' -RecommendedAction 'Set the $env:CloudflareEmail Environment Variable.  See About_Environment_Variables.'
            break
        }

        if ($null -eq $env:CloudflareAPIKey) {
            Write-Error -Message 'The $env:CloudflareAPIKey Environment Variable is $null.' -RecommendedAction 'Set the $env:CloudflareAPIKey Environment Variable.  See About_Environment_Variables.'
            break
        }
    }

    Process {
        $Headers.Add( 'X-Auth-Email', $Email )
        $Headers.Add( 'X-Auth-Key', $APIKey )
        $Headers.Add( 'Content-type', 'application/json' )

        if ($PSBoundParameters.ContainsKey( 'Body' )) {
            $request.Add( 'Body', $Data )
        }

        if ($PSBoundParameters.ContainsKey( 'Form' )) {
            $request.Add( 'Form', $Form )
        }

        $request = @{
            Headers = $Headers
            Uri = 'https://api.cloudflare.com/client/v4/{0}' -f $Endpoint
            Method = $Method
            ErrorAction = 'Stop'
        }

        try {
            Invoke-RestMethod @request
        } catch {
            $_
            return
        }
    }
}
