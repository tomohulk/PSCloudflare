Function Set-CloudflareZoneWAFRuleGroup {
    
    [CmdletBinding( ConfirmImpact = 'Medium' )]
    [OutputType()]

    Param (
        [Parameter( Mandatory = $true )]
        [CloudflareZoneWAFPackage]
        $FirewallPackage,

        [Parameter( Mandatory = $true)]
        [CloudflareZoneWAFRuleGroup]
        $RuleGroup,

        [Parameter()]
        [CloudflareZoneWAFRuleGroupMode]
        $Mode,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/firewall/waf/packages/{1}/groups/{2}' -f $FirewallPackage.ZoneID, $FirewallPackage.ID, $RuleGroup.ID

        $data = @{
            mode = $Mode.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneWAFRuleGroup' -RawResponse $RawResponse.IsPresent
    }
}
