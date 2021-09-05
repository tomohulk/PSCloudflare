Function Test-CloudflareZoneActivation {

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

        $respose = Invoke-CloudflareAPI -Method PUT -Endpont $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
