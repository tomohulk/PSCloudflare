Function Write-CloudflareResponse {
    
    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( Mandatory = $true )]
        [PSCustomObject[]]
        $Response,

        [Parameter( Mandatory = $true )]
        [String]
        $ObjectType,

        [Parameter( Mandatory = $true )]
        [Bool]
        $RawResponse
    )

    if ($Response.success) {
        foreach ($result in $Response.result) {
            if ($RawResponse) {
                Write-Output -InputObject $result
            } else {
                Write-Output -InputObject ($ObjectType -as [Type])::new( $result )
            }
        }
    } else {
        $Response
    }
}
