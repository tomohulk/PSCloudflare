Function Set-CloudflareZone {

    [CmdletBinding(
        ConfirmImpact = 'Medium'
    )]
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
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}' -f $Zone.ID
            
        $data = @{
            Paused = $Paused.IsPresent
        }

        if ($PSBoundParameters.ContatinKey( 'VanityNameServers' )) {
            $data.Add(
                'Vanity_Name_Servers', $VanityNameServers
            )
        }

        if ($PSBoundParameters.ContainsKey( 'Plan')) {
            $data.Add(
                "Plan", $Plan
            )
        }

        $data = ConvertTo-Json -InputObject $data

        $response = Invoke-CloudflareAPI -Method PATCH  -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
