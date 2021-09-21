Function New-CloudflareZone {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( Mandatory = $true, ValueFromPipeline = $true )]
        [String[]]
        $Name,

        [Parameter( Mandatory = $true )]
        [CloudflareAccount]
        $Account,

        [Parameter()]
        [Switch]
        $JumpStart,

        [Parameter()]
        [CloudflareZoneType]
        $Type = 'Full',

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        foreach ($item in $Name) {
            $endpoint = 'zones'
            
            $data = @{
                name = $item
                account = @{
                    id = $Account.ID
                }
                jump_start = $JumpStart.IsPresent
                type = ($Type -as [String]).ToLower()
            }

            $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Data $data

            Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
        }
    }
}
