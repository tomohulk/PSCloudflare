Function Set-CloudflareZoneAlwaysUseHTTPS {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true )]
        [CloudflareZoneAlwaysUseHTTPSValue]
        $Value,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/settings/always_use_https'

        $data = @{
            value = $Value.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneAlwaysUseHTTPSValue' -RawResponse $RawResponse.IsPresent
    }
}
