Function Get-CloudflareZoneSubscription {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/subscription' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneSubscription' -RawResponse $RawResponse.IsPresent
    }
}
