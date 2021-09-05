Function Get-CloudflareAccount {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter()]
        [String]
        $ID,

        [Parameter()]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'accounts'

        if (($PSBoundParameters.GetEnumerator().Where({ $_.Key -ne 'RawResponse' })).Count -ne 0) {
            $parameterList = [Hashtable]$PSBoundParameters

            $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList
        }

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareAccount' -RawResponse $RawResponse.IsPresent
    }
}
