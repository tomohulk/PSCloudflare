Function Set-CloudflareZoneDNSRecord {

    [CmdletBinding( ConfirmImpact = 'Medium' )]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone DNSRecord object returned from Get-CloudflareZoneDNSRecord.', Mandatory = $true )]
        [CloudflareZoneDNSRecord]
        $ZoneDNSRecord,

        [Parameter( Mandatory = $true )]
        [CloudflareZoneDNSRecordType]
        $Type,
        
        [Parameter()]
        [ValidateLength( 0, 255 )]
        [String]
        $Name,

        [Parameter()]
        [String]
        $Content,

        [Parameter()]
        [Int]
        $TTL = 1,

        [Parameter()]
        [ValidateRange( 0, 65535 )]
        [Int]
        $Priority = 10,

        [Parameter()]
        [Switch]
        $Proxied,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/{1}' -f $ZoneDNSRecord.ZoneID ,$ZoneDNSRecord.ID

        if (-not ($PSBoundParameters.ContainsKey( 'Type' ))) {
            $Type = $ZoneDNSRecord.Type
        }

        if (-not ($PSBoundParameter.ContainsKey( 'Name' ))) {
            $Name = $ZoneDNSRecord.Name
        }

        if (-not ($PSBoundParameters.ContainsKey( 'Content' ))) {
            $Content = $ZoneDNSRecord.Content
        }

        if (-not ($PSBoundParameter.ContaintsKey( 'TTL' ))) {
            $TTL = $ZoneDNSRecord.TTL
        }

        if (-not ($PSBoundParameter.ContainsKey( 'Priority' ))) {
            $Priority = $ZoneDNSRecord.Prority
        }

        $data = ConvertTo-Json -InputObject (@{
            Type = $Type
            Name = $Name
            Content = $Content
            TTL = $TTL
            Priority = $Priority
            Proxied = $Proxied.IsPresent
        })

        $response = Invoke-CloudflareAPI -Method PUT -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
