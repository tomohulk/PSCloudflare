Function Get-CloudflareOrganization {

    [CmdletBinding()]
    [OutputType([CloudflareOrginzation])]

    Param (
        [Parameter()]
        [ValidateSet('Member', 'Invited')]
        [String]
        $Status,

        [Parameter()]
        [ValidateLength(0, 100)]
        [String]
        $Name,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'user/organizations'
            
        $parameterList = [Hashtable]$PSBoundParameters

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareOrganization' -RawResponse $RawResponse.IsPresent
    }
}
