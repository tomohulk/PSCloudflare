Function New-CloudflareZone {

    [CmdletBinding()]
    [OutputType([CloudflareZone])]

    Param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]]
        $Name,

        [Parameter(Mandatory = $true)]
        [CloudflareAccount]
        $Account,

        [Parameter()]
        [Switch]
        $JumpStart,

        [Parameter()]
        [CloudflareZoneType]
        $Type = 'Full',

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones'
        
        foreach ($item in $Name) {
            $data = @{
                name = $item
                account = @{
                    id = $Account.ID
                }
                jump_start = $JumpStart.IsPresent
                type = $Type
            }

            $response = Invoke-CloudflareAPI -Method Post -Endpoint $endpoint -Data $data

            Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
        }
    }
}
