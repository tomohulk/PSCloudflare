Function Format-CloudflareEndpointString {

    [CmdletBinding()]
    [OutputType(
        [String]
    )]

    Param (
        [Parameter(
            Mandatory = $true
        )]
        [Hashtable]
        $ParameterList
    )

    $queryString += '?'

    foreach ($item in $ParameterList.GetEnumerator()) {
        $queryString += '{0}={1}&' -f $item.Name.ToLower(), $item.Value
    }

    $queryString = $queryString.TrimEnd(
        '&'
    )

    Write-Output -InputObject $queryString
}
