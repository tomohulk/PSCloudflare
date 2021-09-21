Function New-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true )]
        [CloudflareZoneDNSRecordType]
        $Type,

        [Parameter( Mandatory = $true )]
        [ValidateLength( 0, 255 )]
        [String]
        $Name,

        [Parameter( Mandatory = $true )]
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
        $endpoint = 'zones/{0}/dns_records' -f $Zone.ID

        $data = @{
            Type = $Type
            Name = $Name
            Content = $Content
            TTL = $TTL
            Priority = $Priority
            Proxied = $Proxied.IsPresent
        }

        $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
