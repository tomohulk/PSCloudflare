Function Set-CloudflareZoneAlwaysUseHTTPS {

    [CmdletBinding(ConfirmImpact = 'Medium')]
    [OutputType([CloudflareZoneSetting])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(Mandatory = $true)]
        [ValidateSet('On', 'Off')]
        [String]
        $Value,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/settings/always_use_https' -f $Zone.ID

        $data = @{
            value = $Value.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method Patch -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneSetting' -RawResponse $RawResponse.IsPresent
    }
}
