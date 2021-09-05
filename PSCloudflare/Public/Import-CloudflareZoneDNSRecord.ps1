Function Import-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true, ValueFromPipeline = $true )]
        [String[]]
        $FilePath,

        [Parameter()]
        [Switch]
        $Proxied
    )

    Process {
        foreach ($item in $FilePath) {
            $endpoint = 'zones/{0}/dns_records/import' -f $Zone.ID

            $form = @{
                File = '@{0}' -f $item
                Proxied = $Proxied.IsPresent
            }

            Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Form $form
        }
    }
}
