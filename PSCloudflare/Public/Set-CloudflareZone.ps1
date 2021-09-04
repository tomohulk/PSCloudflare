Function Set-CloudflareZone {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(
            HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.',
            Mandatory = $true
        )]
        [CloudflareZone]
        $Zone,

        [Parameter()]
        [Switch]
        $Paused,

        [Parameter()]
        [String[]]
        $VanityNameServers,

        [Parameter()]
        [CloudflareZonePlan]
        $Plan,

        [Parameter()]
        [Switch]
        $Passthru,

        [Parameter()]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}' -f $Zone.ID
            
        $data = @{
            Paused = $Paused.IsPresent
        }

        $containsVanityNameServers = $PSBoundParameters.ContainsKey(
            'VanityNameServers'
        )
        if ($containsVanityNameServers) {
            $data.Add(
                'Vanity_Name_Servers', $VanityNameServers
            )
        }

        $containsPlan = $PSBoundParameters.ContainsKey(
            'Plan'
        )
        if ($containsPlan) {
            $data.Add(
                "Plan", $Plan
            )
        }

        $data = ConvertTo-Json -InputObject $data

        $response = Invoke-CloudflareAPI -Method PATCH  -Endpoint $endpoint -Data $data

        if ($Passthru.IsPresent) {
            Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
        }
    }
}
