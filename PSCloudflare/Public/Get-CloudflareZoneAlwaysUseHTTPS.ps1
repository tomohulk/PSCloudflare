Function Get-CloudflareZoneAlwaysUseHTTPS {

    [CmdletBinding()]
    [OutputType([CloudflareZoneAlwaysUseHTTPS])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = '/zones/{0}/settings/always_use_https' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneAlwaysUseHTTPS' -RawResponse $RawResponse.IsPresent
    }
}
