Function Get-CloudflareZonePageRule {

    [CmdletBinding()]
    [OutputType([CloudflareZonePageRule])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter()]
        [CloudflareZonePageRuleStatus]
        $Status,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/pagerules' -f $Zone.ID

        $parameterList = [Hashtable]$PSBoundParameters

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZonePageRule' -RawResponse $RawResponse.IsPresent
    }
}
