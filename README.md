# PSCloudflare #
### A PowerShell Wrapper for the Cloudflare API. ###
https://api.cloudflare.com

---

Current commands are:
```
Get-CloudflareAccount
Get-CloudflareDNSRecord
Get-CloudflareZone
Get-CloudflareZoneAvailablePlan
Get-CloudflareZoneAvailableRatePlan
Get-CloudflareZoneSubscription
New-CloudflareZone
Set-CloudflareAPIToken
```

```
# Set your credentials as environment variables.
# This needs to be done every time you start your shell and are using the PSCloudflare module.
PS C:\> $env:CloudflareEmail = 'tomohulk@github.io'
PS C:\> $env:CloudflareAPIKey = 'c2547eb745079dac9320b638f5e225cf483cc5cfdda41'

# Get a Zone.
PS C:\> Get-CloudflareZone -Name im.tomohulk.com

# Get the Proxied records from a Zone.
PS C:\> Get-CloudflareZone -Name im.tomohulk.com | Get-CloudflareDNSRecord -Proxied
```

---

More to come.
