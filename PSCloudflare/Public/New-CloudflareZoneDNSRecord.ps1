Function New-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType([CloudflareZoneDNSRecord])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(Mandatory = $true)]
        [CloudflareZoneDNSRecordType]
        $Type,
        
        [Parameter(Mandatory = $true)]
        [ValidateLength(0, 255)]
        [String]
        $Name,

        [Parameter(Mandatory = $true)]
        [String]
        $Content,

        [Parameter()]
        [Int]
        $TTL = 1,

        [Parameter()]
        [ValidateRange(0, 65535)]
        [Int]
        $Priority = 10,

        [Parameter()]
        [Switch]
        $Proxied,

        [Parameter()]
        [Hashtable]
        $Data = $null,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records' -f $Zone.ID

        $data = @{
            type = $Type
            name = $Name
            content = $Content
            ttl = $TTL
            priority = $Priority
            proxied = $Proxied.IsPresent
            data = $Data
        }

        $response = Invoke-CloudflareAPI -Method Post -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
