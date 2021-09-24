Function Get-CloudflareZoneWAFRuleGroup {
    
    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( Mandatory = $true )]
        [CloudflareZoneWAFPackage]
        $FirewallPackage,

        [Parameter()]
        [String]
        $Name,

        [Parameter()]
        [CloudflareZoneWAFRuleGroupMode]
        $Mode,

        [Parameter()]
        [Int]
        $RulesCount,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/firewall/waf/packages/{1}/groups' -f $FirewallPackage.ZoneID, $FirewallPackage.ID

        $parameterList = [Hashtable]$PSBoundParameters

        # Update RulesCount parameter names to match expected format used by the Cloudflare API, but still follow PowerShell best practices.
        if ($PSBoundParameters.ContainsKey( 'RulesCount' )) {
            $parameterList.Add( 'rules_count', $parameterList.Item( 'RulesCount' ))

            $parameterList.Remove( 'RulesCount' )
        }

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneWAFRuleGroup' -RawResponse $RawResponse.IsPresent
    }
}
