Function Get-CloudflareDNSRecord {

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

        [Parameter(
            HelpMessage = 'Return a DNS Record by a specified name.'
        )]
        [ValidateLength(
            0, 255
        )]
        [String]
        $Name,

        [Parameter(
            HelpMessage = 'Return DNS Record by its content value.'
        )]
        [String]
        $Content,

        [Parameter(
            HelpMessage = 'Return DNS Record by its record type.'
        )]
        [ValidateSet(
            'A', 'AAAA', 'CNAME', 'HTTPS', 'TXT', 'SRV', 'LOC', 'MX', 'NS', 'SPF', 'CERT', 'DNSKEY', 'DS', 'NAPTR', 'SMIMEA', 'SSHFP', 'SVCB', 'TLSA', 'URI'
        )]
        [String]
        $Type,

        [Parameter(
            HelpMessage = 'Return DNS Record that is proxy enabled.'
        )]
        [Switch]
        $Proxied,

        [Parameter(
            HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.'
        )]
        [Switch]
        $RawResponse
    )

    Process {
        $apiQuery = 'zones/{0}/dns_records' -f $Zone.ID

        if ($PSBoundParameters.Count -ne 0) {
            $parameterList = [Hashtable]$PSBoundParameters
            $parameterList.Remove(
                'Zone'
            )
            $apiQuery += Format-CloudflareQueryString -ParameterList $parameterList
        }

        $response = Invoke-CloudflareAPI -Method GET -APIQuery $apiQuery

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareDNSRecord' -RawResponse $RawResponse.IsPresent
    }
}
