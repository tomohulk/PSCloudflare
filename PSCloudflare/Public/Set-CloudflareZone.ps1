Function Set-CloudflareZone {

    [CmdletBinding( ConfirmImpact = 'Medium', DefaultParameterSetName = '__AllParameterSets' )]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ParameterSetName = '__AllParameterSets' )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetPause' )]
        [Switch]
        $Paused,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetVanityNameServer' )]
        [String[]]
        $VanityNameServer,

        [Parameter( Mandatory = $true, ParameterSetName = 'SetPlan' )]
        [CloudflareZonePlan]
        $Plan,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.', ParameterSetName =  '__AllParameterSets' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}' -f $Zone.ID
        
        switch ($PSCmdlet.ParameterSetName) {
            'SetPause' {
                $data = @{
                    paused = $Paused.IsPresent
                }
            }

            'SetVanityNameServer' {
                $data = @{
                    vanity_name_servers = $VanityNameServer
                }
            }

            'SetPlan' {
                $data = @{
                    plan = @{
                        id = $Plan.ID
                    }
                }
            }
        }

        $response = Invoke-CloudflareAPI -Method PATCH -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
