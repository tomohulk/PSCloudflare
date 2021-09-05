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
        [CloudflareAccount]
        $Account,

        [Parameter()]
        [Switch]
        $JumpStart,

        [Parameter()]
        [CloudflareZoneType]
        $Type = 'Full',

        [Parameter()]
        [Switch]
        $RawResponse
    )

    Process {
        foreach ($item in $Name) {
            $endpoint = 'zones'
            
            $data = ConvertTo-Json -InputObject (@{
                Name = $item
                Account = @{
                    ID = $Account.ID
                }
                JumpStart = $JumpStart.IsPresent
                Type = $Type
            })

            $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Data $data

            Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
        }
    }
}
