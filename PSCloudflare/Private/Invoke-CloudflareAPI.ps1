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
            break
        }

        if ($null -eq $APIKey) {
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

        if ($PSBoundParameters.ContainsKey( 'Data' )) {
            $json = ConvertTo-Json -Depth 4 -EnumsAsStrings -InputObject $Data
            $body = [Regex]::Replace( $json, '(?<=")(\w+)(?=":)', { $args[0].Groups[1].Value.ToLower() } )
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
