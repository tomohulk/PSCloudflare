Function Set-CloudflareZoneFirewallPackage {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( Mandatory = $true )]
        [CloudflareZoneFirewallPackage]
        $FirewallPackage,

        [Parameter()]
        [CloudflareZoneFirewallPackageSensitivity]
        $Sensitivity,

        [Parameter()]
        [CloudflareZoneFirewallPackageActionMode]
        $ActionMode,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/firewall/waf/packages/{1}' -f $FirewallPackage.ZoneID, $FirewallPackage.ID

        foreach ($parameter in @('Sensitivity', 'ActionMode')) {
            if (-not ($PSBoundParameters.ContainsKey($parameter))) {
                Set-Variable -Name $parameter -Value $FirewallPackage.$parameter
            }
        }

        $data = @{
            sensitivity = $Sensitivity
            action_mode = $ActionMode
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneFirewallPackage' -RawResponse $RawResponse.IsPresent
    }
}
