Function Set-CloudflareZoneWAF {

    [CmdletBinding( ConfirmImpact = 'Medium' )]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter()]
        [CloudflareZoneWAFValue]
        $Value,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/settings/waf' -f $Zone.ID

        $data = @{
            Value = $Value.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneWAF' -RawResponse $RawResponse.IsPresent
    }
}
