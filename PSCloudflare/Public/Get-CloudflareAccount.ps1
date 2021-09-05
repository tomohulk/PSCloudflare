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

        if ($PSBoundParameters.ContainsKey( 'ID' )) {
            $endpoint += '/{0}' -f $ID
        }

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareAccount' -RawResponse $RawResponse.IsPresent
    }
}
