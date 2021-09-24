Function Format-CloudflareEndpointString {

    [CmdletBinding()]
    [OutputType( [String] )]

    Param (
        [Parameter( HelpMessage = 'Search parameters to build the query string.', Mandatory = $true )]
        [Hashtable]
        $ParameterList
    )

    $invalidParameters = @(
        [System.Management.Automation.Internal.CommonParameters].GetProperties().Name
        [System.Management.Automation.Internal.ShouldProcessParameters].GetProperties().Name
        [System.Management.Automation.Internal.TransactionParameters].GetProperties().Name
        'RawResponse'
        'Zone'
    )

    foreach ($parameterName in $invalidParameters) {
        if ($ParameterList.ContainsKey( $parameterName )) {
            $ParameterList.Remove( $parameterName )
        }
    }
    
    if ($ParameterList.Count -gt 0) {
        $queryString += '?'

        foreach ($item in $ParameterList.GetEnumerator()) {
            $queryString += '{0}={1}&' -f $item.Name.ToLower(), $item.Value
        }

        $queryString = $queryString.TrimEnd(
            '&'
        )
    }

    Write-Output -InputObject $queryString
}
