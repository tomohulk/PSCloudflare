Function Get-CloudflareZoneAvailabeRatePlan {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(
            HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.',
            Mandatory = $true,
            ValueFromPipeline = $true
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
        $endpoint = 'zones/{0}/available_rate_plans' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method GET -APIQuery $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneRatePlan' -RawResponse $RawResponse.IsPresent
    }
}