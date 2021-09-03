# PSCloudflare #
### A PowerShell Wrapper for the Cloudflare API. ###
https://api.cloudflare.com

---

Current commands are:
```
Get-CloudflareDNSRecord
Get-CloudflareZone
Get-CloudflareZoneAvailablePlan
Get-CloudflareZoneAvailableRatePlan
Get-CloudflareZoneSubscription
Set-CloudflareAPIToken
```

```
# Set your API key, this is stored an retrieved from the Windows Credential Vault when API calls are executed.
# This only needs to be done once.
PS C:\> Set-CloudflareAPIToken

# Get a Zone.
PS C:\> Get-CloudflareZone -Name me.tomohulk.com

# Get the Proxied records from a Zone.
PS C:\> Get-CloudflareZone -Name me.tomohulk.com | Get-CloudflareDNSRecord -Proxied
```


More to come.
