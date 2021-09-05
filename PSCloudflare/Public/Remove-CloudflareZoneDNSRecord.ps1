Function Remove-CloudflareZoneDNSRecord {

    [CmdletBinding(
        ConfirmImpact = 'High'
    )]
    [OutputTYpe()]

    Param (
        [Parameter(
            HelpMessage = 'A Cloudflare Zone DNSRecord object returned from Get-CloudflareZoneDNSRecord.',
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [CloudflareZoneDNSRecord]
        $ZoneDNSRecord,

        [Parameter()]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/{1}' -f $ZoneDNSRecord.ZoneID, $ZoneDNSRecord.ID

        $response = Invoke-CloudflareAPI -Method DELETE -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
