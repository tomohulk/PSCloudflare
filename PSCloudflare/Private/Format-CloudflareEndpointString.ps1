Function Format-CloudflareEndpointString {

    [CmdletBinding()]
    [OutputType( [String] )]

    Param (
        [Parameter( Mandatory = $true )]
        [Hashtable]
        $ParameterList
    )

    if ($ParameterList.ContainsKey( 'RawResponse' )) {
        $ParameterList.Remove( 'RawResponse' )
    }
    
    $queryString += '?'

    foreach ($item in $ParameterList.GetEnumerator()) {
        $queryString += '{0}={1}&' -f $item.Name.ToLower(), $item.Value
    }

    $queryString = $queryString.TrimEnd(
        '&'
    )

    Write-Output -InputObject $queryString
}
