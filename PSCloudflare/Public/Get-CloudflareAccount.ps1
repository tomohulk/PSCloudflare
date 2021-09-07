Function Get-CloudflareAccount {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter()]
        [String]
        $ID,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'accounts'

        $parameterList = [Hashtable]$PSBoundParameters

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareAccount' -RawResponse $RawResponse.IsPresent
    }
}
