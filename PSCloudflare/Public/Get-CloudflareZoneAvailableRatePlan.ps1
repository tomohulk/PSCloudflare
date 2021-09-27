Function Get-CloudflareZoneAvailableRatePlan {

    [CmdletBinding()]
    [OutputType([CloudflareZoneRatePlan])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/available_rate_plans' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method Get -APIQuery $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneRatePlan' -RawResponse $RawResponse.IsPresent
    }
}
