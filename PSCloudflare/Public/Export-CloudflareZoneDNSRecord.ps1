Function Export-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( HelpMessage = 'Path to create the .BIND file.')]
        [String]
        $Path = $pwd
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/export' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        $Path += '\{0}.txt' -f $Zone.Name
        Out-File -FilePath $Path -InputObject $response
    }
}
