Function Get-CloudflareOrganization {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter()]
        [ValidateSet( 'Member', 'Invited' )]
        [String]
        $Status,

        [Parameter()]
        [ValidateLength( 0, 100 )]
        [String]
        $Name,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'user/organizations'

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareOrganization' -RawResponse $RawResponse.IsPresent
    }
}
