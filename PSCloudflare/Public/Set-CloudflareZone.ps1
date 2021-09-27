Function Set-CloudflareZone {

    [CmdletBinding(ConfirmImpact = 'Medium')]
    [OutputType([CloudflareZone])]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter()]
        [Bool]
        $Paused,

        [Parameter()]
        [String[]]
        $VanityNameServer,

        [Parameter()]
        [CloudflareZonePlan]
        $Plan,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}' -f $Zone.ID
        
        foreach ($parameter in @('Paused', 'VanityNameServer', 'Plan')) {
            if ( -not ($PSBoundParameters.ContainsKey($parameter))) {
                Set-Variable -Name $parameter -Value $Zone.$parameter
            }
        }

        $data = @{
            paused = $Paused
            vanity_name_servers = @($VanityNameServer)
            plan = $Plan.ID
        }

        $response = Invoke-CloudflareAPI -Method Patch -Endpoint $endpoint -Data $data

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
    }
}
