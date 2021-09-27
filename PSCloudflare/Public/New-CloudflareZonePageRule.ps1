Function New-CloudflareZonePageRule {

    [CmdletBinding()]
    [OutputType([CloudflareZonePageRule])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(Mandatory = $true)]
        [CloudflareZonePageRuleTarget[]]
        $Target,

        [Parameter(Mandatory = $true)]
        [CloudflareZonePageRuleAction[]]
        $Action,

        [Parameter()]
        [Int]
        $Priority = 1,

        [Parameter()]
        [CloudflareZonePageRuleStatus]
        $Status = 'Disabled',

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    $endpoint = 'zones/{0}/pagerules' -f $Zone.ID

    $data = @{
        targets = @($Target)
        actions = @($Action)
        priority = $Priority
        status = $Status
    }

    $response = Invoke-CloudflareAPI -Method Post -Endpoint $endpoint -Data $data

    Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZonePageRule' -RawResponse $RawResponse.IsPresent
}
