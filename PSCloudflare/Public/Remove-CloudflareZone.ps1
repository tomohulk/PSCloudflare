Function Remove-CloudflareZone {

    [CmdletBinding( ConfirmImpact = 'High' )]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline )]
        [CloudflareZone]
        $Zone
    )

    Process {
        $endpoint = 'zones/{0}' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method DELETE -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
