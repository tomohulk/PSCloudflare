Function Set-CloudflareZoneDNSRecord {

    [CmdletBinding(ConfirmImpact = 'Medium')]
    [OutputType([CloudflareZoneDNSRecord])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone DNSRecord object returned from Get-CloudflareZoneDNSRecord.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZoneDNSRecord]
        $ZoneDNSRecord,

        [Parameter()]
        [CloudflareZoneDNSRecordType]
        $Type,
        
        [Parameter()]
        [ValidateLength(0, 255)]
        [String]
        $Name,

        [Parameter()]
        [String]
        $Content,

        [Parameter()]
        [Int]
        $TTL,

        [Parameter()]
        [Bool]
        $Proxied,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/{1}' -f $ZoneDNSRecord.ZoneID ,$ZoneDNSRecord.ID

        foreach ($parameter in @('Type', 'Name', 'Content', 'TTL', 'Proxied')) {
            if (-not ($PSBoundParameters.ContainsKey($parameter))) {
                Set-Variable -Name $parameter -Value $ZoneDNSRecord.$parameter
            }
        }

        $data = @{
            type = $Type
            name = $Name
            content = $Content
            ttl = $TTL
            proxied = $Proxied.ToString().ToLower()
        }

        $response = Invoke-CloudflareAPI -Method Patch -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
