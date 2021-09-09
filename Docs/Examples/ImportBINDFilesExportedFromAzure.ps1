# Get your Cloudflare Account object.
$account = Get-CloudflareAccount

# Loop through all the BIND files that where exported from Azure.
foreach ($bindFile in ( Get-ChildItem -Path 'C:\AzureExportedBINDFiles')) {
    # Strip out the Azure Name Server records.
    $bindContent = Get-Content -Path $bindFile.FullName
    $bindContent | Where-Object { $_ -notmatch '172800 IN NS ns' } | Set-Content -Path $bindFile.FullName
    
    $zoneName = $bindFile.Basename

    # Create the Zone in Cloudflare if it doesn't exist.
    if ($null -eq ( Get-CloudflareZone -Name $zoneName )) {
        $newZone = New-CloudflareZone -Name $zoneName -Account $account
        
        if ($null -ne $newZone) {
            # Set the Plan the Zone uses.
            $enterprisePlan = Get-CloudflareZoneAvailablePlan -Zone $newZone | Where-Object { $_.Name -eq 'Enterprise' }
            Set-CloudflareZone -Zone $newZone -Plan $enterprisePlan | Out-Null

            # Import the BIND File to the Zone.
            Import-CloudflareZoneDNSRecord -Zone $newZone -Path $bindFile.FullName | Out-Null

            # Enable the Cloudflare Proxy on targeted records.
            $zoneDNSRecords = Get-CloudflareZoneDNSRecord -Zone $newZone
            $zoneDNSRecordsToProxy = @($zoneDNSRecords | Where-Object { $_.Type -eq 'A' -and $_.Name -eq $zoneName }
                $zoneDNSRecords | Where-Object { $_.Type -eq 'A' -and $_.Name -eq $('www.{0}' -f $zoneName) }
                $zoneDNSRecords | Where-Object { $_.Type -eq 'CNAME' -and $_.Name -eq $('www.{0}' -f $zoneName) }
            )

            $zoneDNSRecordsToProxy | Set-CloudflareZoneDNSRecord -Proxied | Out-Null
        }
    }
}
