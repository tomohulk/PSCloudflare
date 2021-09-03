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
        [ValidateSet(
            'Active', 'Pending', 'Initalizing', 'Moved', 'Deleted', 'Deactivted'
        )]
        [String]
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

        if ($PSBoundParameters.Count -ne 0) {
            $parameterList = [Hashtable]$PSBoundParameters

            # Update AccountName and/or AccountID parameter Names to match expected format used by the Cloudflare API, but still follow PowerShell best practices.
            $containsAccountName = $parameterList.ContainsKey(
                'AccountName'
            )
            if ($containsAccountName) {
                $parameterList.Add(
                    'account.name', $parameterList.Item('AccountName')
                )

                $parameterList.Remove(
                    'AccountName'
                )
            }

            $containsAccountID = $parameterList.ContainsKey(
                'AccountID'
            )
            if ($containsAccountID) {
                $parameterList.Add(
                    'account.id', $parameterList.Item('AccountID')
                )
                
                $parameterList.Remove(
                    'AccountID'
                )
            }

            $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList
        }

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
