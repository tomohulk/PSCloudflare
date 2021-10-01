Function Get-CloudflareZoneSetting {

    [CmdletBinding()]
    [OutputType([CloudflareZoneSetting])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(Mandatory = $true)]
        [ValidateSet([CloudflareZoneSettingIDBinding])]
        $Setting,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = '/zones/{0}/settings/{1}' -f $Zone.ID, $Global:CloudflareZoneSettingIDBinding.$Setting

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneSetting' -RawResponse $RawResponse.IsPresent
    }
}
