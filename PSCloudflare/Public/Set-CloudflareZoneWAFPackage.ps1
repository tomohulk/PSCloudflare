Function Set-CloudflareZoneWAFPackage {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( Mandatory = $true )]
        [CloudflareZoneWAFPackage]
        $FirewallPackage,

        [Parameter()]
        [CloudflareZoneWAFPackageSensitivity]
        $Sensitivity,

        [Parameter()]
        [CloudflareZoneWAFPackageActionMode]
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
            sensitivity = $Sensitivity.ToString().ToLower()
            action_mode = $ActionMode.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneWAFPackage' -RawResponse $RawResponse.IsPresent
    }
}
