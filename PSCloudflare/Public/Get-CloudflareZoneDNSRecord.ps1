Function Get-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(
            HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.',
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [CloudflareZone]
        $Zone,

        [Parameter( HelpMessage = 'Return a DNS Record by a specified name.' )]
        [ValidateLength( 0, 255 )]
        [String]
        $Name,

        [Parameter( HelpMessage = 'Return DNS Record by its content value.' )]
        [String]
        $Content,

        [Parameter( HelpMessage = 'Return DNS Record by its record type.' )]
        [CloudflareZoneDNSRecordType]
        $Type,

        [Parameter( HelpMessage = 'Return DNS Record that is proxy enabled.' )]
        [Switch]
        $Proxied,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records' -f $Zone.ID

        $parameterList = [Hashtable]$PSBoundParameters
            
        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
