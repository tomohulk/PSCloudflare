Function Invoke-CloudflareZoneActivation {

    [CmdletBinding()]
    [OutputType()]

    Param(
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/activation_check' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method PUT -Endpont $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
