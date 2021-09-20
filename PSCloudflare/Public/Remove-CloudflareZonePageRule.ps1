Function Remove-CloudflareZonePageRule {

    [CmdletBinding( ConfirmImpact = 'High')]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true )]
        $PageRule
    )

    Process {
        $endpoint = 'zones/{0}/pagerulese/{1}' -f $ZoneDNSRecord.ZoneID, $PageRule.ID

        $response = Invoke-CloudflareAPI -Method DELETE -Endpoint $endpoint

        if ($RawResponse.IsPresent) {
            Write-Output -InputObject $response
        }
    }
}
