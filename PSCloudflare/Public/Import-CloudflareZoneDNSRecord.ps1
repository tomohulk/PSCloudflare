Function Import-CloudflareZoneDNSRecord {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true, ValueFromPipeline = $true )]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf })]
        [System.IO.FileInfo]
        $Path,

        [Parameter()]
        [Switch]
        $Proxied,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/dns_records/import' -f $Zone.ID

        $form = @{ 
            file = Get-Item -Path $Path
            proxied = $Proxied.IsPresent
        }

        $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Form $form

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZoneDNSRecordImport' -RawResponse $RawResponse.IsPresent
    }
}
