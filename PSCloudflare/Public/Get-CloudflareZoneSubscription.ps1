Function Get-CloudflareZoneSubscription {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(
            Mandatory = $true
        )]
        [CloudflareZone]
        $Zone,

        [Parameter(
            HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.'
        )]
        [Switch]
        $RawResponse
    )

    Process {
        $apiQuery = 'zones/{0}/subscription' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method GET -APIQuery $apiQuery

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneSubscription' -RawResponse $RawResponse.IsPresent
    }
}
