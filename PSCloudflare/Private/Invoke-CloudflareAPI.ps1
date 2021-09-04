Function Invoke-CloudflareAPI {
    
    [CmdletBinding(
        ConfirmImpact = 'Low',
        SupportsShouldProcess = $true
    )]
    [OutputType()]

    Param (
        [Parameter()]
        [String]
        $Email = $env:CloudflareEmail,

        [Parameter()]
        [String]
        $APIKey = $env:ClouldflareAPIKey,

        [Parameter(
            Mandatory = $false
        )]
        [HashTable] 
        $Headers = @{},
        
        [Parameter(
            Mandatory = $true
        )]
        [ValidateSet(
            "GET", "POST", "PUT", "PATCH", "DELETE"
        )]
        [String] 
        $Method,

        [Parameter(
            Mandatory = $true
        )]
        [String] 
        $Endpoint,

        [Parameter()]
        [String]
        $Data = $null
    )

    Process {
        $Headers.Add(
            'X-Auth-Email', $Email
        )
        $Headers.Add(
            'X-Auth-Key', $APIKey
        )
        $Headers.Add(
            'Content-type', 'application/json'
        )

        $request = @{
            Headers = $Headers
            Uri = 'https://api.cloudflare.com/client/v4/{0}' -f $Endpoint
            Method = $Method
            Body = $Data
            ErrorAction = 'Stop'
        }

        try {
            if ($PSCmdlet.ShouldProcess($request)) {
                Invoke-RestMethod @request
            }
        } catch {
            $_
            return
        }
    }
}
