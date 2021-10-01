Function Set-CloudflareZoneSetting {

    [CmdletBinding(ConfirmImpact = 'Medium')]
    [OutputType([CloudflareZoneSetting])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(Mandatory = $true)]
        [ValidateSet([CloudflareZoneSettingIDBinding])]
        $Setting,

        [Parameter(Mandatory = $true)]
        [Object]
        $Value,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/settings/{1}' -f $Zone.ID, $Global:CloudflareZoneSettingIDBinding.$Setting

        $data = @{
            value = $Value.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method Patch -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneSetting' -RawResponse $RawResponse.IsPresent
    }
}
