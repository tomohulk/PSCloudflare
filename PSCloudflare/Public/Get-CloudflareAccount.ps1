Function Get-CloudflareAccount {

    [CmdletBinding()]
    [OutputType([CloudflareAccount])]

    Param (
        [Parameter()]
        [String]
        $ID,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'accounts'

        $parameterList = [Hashtable]$PSBoundParameters

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareAccount' -RawResponse $RawResponse.IsPresent
    }
}
