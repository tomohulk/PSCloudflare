#requires -Modules PSCloudflare

$key = # Enter GoDaddy API Key
$secret = # Enter GoDaddy API Secret

$cfAccount = Get-CloudflareAccount


$gdApiheaders = @{
    'Authorization' = 'sso-key {0}:{1}' -f $key, $secret
    'Content-Type' = 'application/json'
}

$gdDomains = Invoke-RestMethod -Method Get -Headers $gdApiheaders -Uri 'https://api.godaddy.com/v1/domains?limit=1000&includes=nameServers'

foreach ($gdDomain in $gdDomains) {
    $gdDnsRecords = Invoke-RestMethod -Method Get -Headers $gdApiHeaders -Uri ('https://api.godaddy.com/v1/domains/{0}/records?includes=port&protocol' -f $gdDomain)
    
    # Don't move zones that are parked.
    if ($gdDnsRecords.data -contains 'Parked') {
        continue
    }

    if ($null -eq (Get-CloudflareZone -Name $gdDomain)) {
        # Create the new Cloudflare Zone.
        $cfZone = New-CloudflareZone -Name $gdDomain -Account $cfAccount

        # Set the zone Plan.
        $enterprisePlan = Get-CloudflareZoneAvailablePlan -Zone $cfZone | Where-Object { $_.Name -eq 'Enterprise' }
        Set-CloudflareZone -Zone $cfZone -Plan $enterprisePlan | Out-Null

        foreach ($gdDnsRecord in $gdDnsRecords) {
            if ($gdDnsRecord.Type -ne 'NS' -and ($gdDnsRecord.Name -ne '_domainconnect' -and $gdDnsRecord.Type -ne 'CNAME')) {
                [Hashtable]$newDNSRecordParams = @{
                    Zone = $cfZone
                    Name = $gdDnsRecord.Name
                    Type = $gdDnsRecord.Type
                    Content = $gdDnsRecord.Data
                    TTL = $gdDnsRecord.TTL
                }

                # Add extra values for SRV records.
                if ($gdDnsRecord.Type -eq 'SRV') {
                    $gdDnsRecordSRVData = Invoke-RestMethod -Method Get -Headers $gdApiHeaders -Uri ('https://api.godaddy.com/v1/domains/{0}/SRV/{1}' -f $gdDomain, $gdDnsRecord.Name) | Where-Object { $_.Data -eq $gdDnsRecord.Data }
                    $srvRecordData = @{
                        service = $gdDnsRecordSRVData.Service
                        proto = $gdDnsRecordSRVData.Protocol
                        name = $gdDnsRecordSRVData.Name
                        weight = $gdDnsRecordSRVData.Weight
                        priority = $gdDnsRecordSRVData.Priority
                        target = $gdDnsRecordSRVData.data
                    }

                    $newDNSRecordParams.Add('Data', $srvRecordData)
                }
                    
                New-CloudflareZoneDNSRecord @newDNSRecordParams | Out-Null
            }

        }
    } 
}
