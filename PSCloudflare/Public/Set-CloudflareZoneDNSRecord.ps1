Function Set-CloudflareZoneDNSRecord {

    [CmdletBinding( ConfirmImpact = 'Medium', DefaultParameterSetName = '__AllParameterSets' )]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone DNSRecord object returned from Get-CloudflareZoneDNSRecord.', Mandatory = $true, ParameterSetName = '__AllParameterSets', ValueFromPipeline = $true )]
        [CloudflareZoneDNSRecord]
        $ZoneDNSRecord,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetType' )]
        [CloudflareZoneDNSRecordType]
        $Type,
        
        [Parameter( Mandatory = $true, ParameterSetName = 'SetName' )]
        [ValidateLength( 0, 255 )]
        [String]
        $Name,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetContent' )]
        [String]
        $Content,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetTTL' )]
        [Int]
        $TTL,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetPriortiy' )]
        [ValidateRange( 0, 65535 )]
        [Int]
        $Priority,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetProxied' )]
        [Switch]
        $Proxied,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.', ParameterSetName = '__AllParameterSets' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/{1}' -f $ZoneDNSRecord.ZoneID ,$ZoneDNSRecord.ID

        switch ($PSCmdlet.ParameterSetName) {
            'SetType' {
                $data = @{
                    type = $Type
                }
            }

            'SetName' {
                $data = @{
                    name = $Name
                }
            }

            'SetContent' {
                $data = @{
                    content = $Content
                }
            }

            'SetTTL' {
                $data = @{
                    ttl = $TTL
                }
            }

            'SetPriority' {
                $data = @{
                    priority = $Priority
                }
            }

            'SetProxied' {
                $data = @{
                    proxied = $Proxied.IsPresent
                }
            }
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
