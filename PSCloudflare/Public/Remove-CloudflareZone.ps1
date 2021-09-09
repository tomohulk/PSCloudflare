Function Remove-CloudflareZone {

    [CmdletBinding( ConfirmImpact = 'High' )]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline )]
        [CloudflareZone]
        $Zone,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method DELETE -Endpoint $endpoint

        if ($RawResponse.IsPresent) {
            Write-Output -InputObject $response
        }
    }
}
