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

        [Parameter()]
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
        [Hashtable]
        $Data,

        [Parameter()]
        [Hashtable]
        $Form
    )

    Begin {
        if ($null -eq $Email) {
            Write-Error -Message 'The env:CloudflareEmail Environment Variable is $null.' -RecommendedAction 'Set the $env:CloudflareEmail Environment Variable.  See About_Environment_Variables.'
            break
        }

        if ($null -eq $APIKey) {
            Write-Error -Message 'The $env:CloudflareAPIKey Environment Variable is $null.' -RecommendedAction 'Set the $env:CloudflareAPIKey Environment Variable.  See About_Environment_Variables.'
            break
        }
    }

    Process {
        $Headers.Add( 'X-Auth-Email', $Email )
        $Headers.Add( 'X-Auth-Key', $APIKey )
        $Headers.Add( 'Content-type', 'application/json' )

        $request = @{
            Headers = $Headers
            Uri = 'https://api.cloudflare.com/client/v4/{0}' -f $Endpoint
            Method = $Method
            ErrorAction = 'Stop'
        }

        $body = ConvertTo-Json -InputObject $Data
        if ($PSBoundParameters.ContainsKey( 'Data' )) {
            $request.Add( 'Body', $body )
        }

        if ($PSBoundParameters.ContainsKey( 'Form' )) {
            $request.Add( 'Form', $Form )
        }
        
        try {
            Invoke-RestMethod @request
        } catch {
            Write-Error $_
            break
        }
    }
}
