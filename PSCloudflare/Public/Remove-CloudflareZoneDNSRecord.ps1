Function Remove-CloudflareZoneDNSRecord {

    [CmdletBinding( ConfirmImpact = 'High' )]
    [OutputTYpe()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone DNSRecord object returned from Get-CloudflareZoneDNSRecord.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZoneDNSRecord]
        $ZoneDNSRecord,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/{1}' -f $ZoneDNSRecord.ZoneID, $ZoneDNSRecord.ID

        $response = Invoke-CloudflareAPI -Method DELETE -Endpoint $endpoint

        if ($RawResponse.IsPresent) {
            Write-Output -InputObject $response
        }
    }
}
