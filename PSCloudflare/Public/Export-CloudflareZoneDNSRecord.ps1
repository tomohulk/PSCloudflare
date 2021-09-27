Function Export-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter(HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true)]
        [CloudflareZone]
        $Zone,

        [Parameter(HelpMessage = 'Path to create the .BIND (.txt) file.')]
        [String]
        $Path
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/export' -f $Zone.ID

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        if ($PSBoundParameters.ContatinsKey('Path')) {
            if (-not ($Path.EndsWith('.txt'))) {
                $Path += '\{0}.txt' -f $Zone.Name
            }
            
            Out-File -FilePath $Path -InputObject $response
        } else {
            Write-Output -InputObject $response
        }
    }
}
