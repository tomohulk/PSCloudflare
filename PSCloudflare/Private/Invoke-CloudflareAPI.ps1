Function Invoke-CloudflareAPI {
    
    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter()]
        [String]
        $Email = $env:CloudflareEmail,

        [Parameter()]
        [String]
        $APIKey = $env:ClouldflareAPIKey,

        [Parameter( Mandatory = $false )]
        [HashTable] 
        $Headers = @{},
        
        [Parameter( Mandatory = $true )]
        [ValidateSet( 'GET', 'POST', 'PUT', 'PATCH', 'DELETE' )]
        [String] 
        $Method,

        [Parameter( Mandatory = $true )]
        [String] 
        $Endpoint,

        [Parameter()]
        [String]
        $Data,

        [Parameter()]
        [String]
        $Form
    )

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

        if ($PSBoundParameters.ContainsKey( 'Body' )) {
            $request.Add( 'Body', $Data )
        }

        if ($PSBoundParameters.ContainsKey( 'Form' )) {
            $request.Add( 'Form', $Form )
        }

        try {
            Invoke-RestMethod @request
        } catch {
            $_
            return
        }
    }
}
