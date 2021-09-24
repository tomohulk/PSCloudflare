Function Set-CloudflareZonePageRule {

    [Cmdletbinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true )]
        [CloudflareZonePageRule]
        $PageRule,

        [Parameter()]
        [CloudflareZonePageRuleTarget[]]
        $Target,

        [Parameter()]
        [CloudflareZonePageRuleAction[]]
        $Action,

        [Parameter()]
        [Int]
        $Priority = 1,

        [Parameter()]
        [CloudflareZonePageRuleStatus]
        $Status = 'Disabled',

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/pagerules/{1}' -f $Zone.ID, $PageRule.ID

        foreach ($parameter in @('Target', 'Action', 'Priority', 'Status')) {
            if ( -not ($PSBoundParameters.ContainsKey( $parameter ))) {
                Set-Variable -Name $parameter -Value $PageRule.$parameter
            }
        }
    
        $data = @{
            targets = @($Target)
            actions = @($Action)
            priority = $Priority
            status = $Status
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZonePageRule' -RawResponse $RawResponse.IsPresent
    }
}
