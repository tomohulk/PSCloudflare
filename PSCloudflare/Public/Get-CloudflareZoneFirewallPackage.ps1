Function Get-CloudflareZoneFirewallPackage {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter()]
        [String]
        $Name,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/firewall/waf/packages' -f $Zone.ID

        $parameterList = [Hashtable]$PSBoundParameters

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneFirewallPackage' -RawResponse $RawResponse.IsPresent
    }
}
