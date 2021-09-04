Function New-CloudflareZone {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [String[]]
        $Name,

        [Parameter(
            Mandatory = $true
        )]
        [String]
        $AccountID,

        [Parameter()]
        [Switch]
        $JumpStart,

        [Parameter()]
        [CloudflareZoneType]
        $Type = 'Full',

        [Parameter()]
        [Switch]
        $Passthru,

        [Parameter()]
        [Switch]
        $RawResponse
    )

    Process {
        foreach ($item in $Name) {
            $endpoint = 'zones'
            
            $body = ConvertTo-Json -InputObject (@{
                Name = $item
                Account = @{
                    ID = $AccountID
                }
                JumpStart = $JumpStart.IsPresent
                Type = $Type
            })

            $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Body $body

            if ($Passthru.IsPresent) {
                Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
            }
        }
    }
}
