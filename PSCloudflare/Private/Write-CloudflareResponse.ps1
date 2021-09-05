Function Write-CloudflareResponse {
    
    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(
            Mandatory = $true
        )]
        [PSCustomObject]
        $Response,

        [Parameter(
            Mandatory = $true
        )]
        [String]
        $CloudflareObjectType,

        [Parameter()]
        [Bool]
        $RawResponse
    )

    if ($Response.success) {
        foreach ($result in $Response.result) {
            if ($RawResponse) {
                Write-Output -InputObject $result
            } else {
                $returnValue = ($CloudflareObjectType -as [Type])::new(
                    $result
                )

                Write-Output -InputObject $returnValue
            }
        }
    } elseif ($null -ne $response.errors) {
        # Handle response errors
    }
}
