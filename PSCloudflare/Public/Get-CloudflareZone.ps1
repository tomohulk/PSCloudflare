Function Get-CloudflareZone {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter()]
        [Alias(
            'Hostname'
        )]
        [String]
        $Name,

        [Parameter()]
        [CloudflareZoneStatus]
        $Status,

        [Parameter()]
        [ValidateLength(
            0, 100
        )]
        [String]
        $AccountName,

        [Parameter()]
        [ValidateLength(
            0, 32
        )]
        [String]
        $AccountID,

        [Parameter(
            HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.'
        )]
        [Switch]
        $RawResponse

    )

    Process {
        $endpoint = 'zones'

        if (($PSBoundParameters.GetEnumerator().Where({ $_.Key -ne 'RawResponse' })).Count -ne 0) {
            $parameterList = [Hashtable]$PSBoundParameters

            # Update AccountName and/or AccountID parameter Names to match expected format used by the Cloudflare API, but still follow PowerShell best practices.
            if ($PSBoundParameters.ContainsKey( 'AccountName' )) {
                $parameterList.Add( 'account.name', $parameterList.Item( 'AccountName' ))

                $parameterList.Remove( 'AccountName' )
            }

            if ($PSBoundParameters.ContainsKey( 'AccountID' )) {
                $parameterList.Add( 'account.id', $parameterList.Item('AccountID' ))
                
                $parameterList.Remove( 'AccountID' )
            }

            $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList
        }

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
