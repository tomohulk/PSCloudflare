# PSCloudflare #
### A PowerShell Wrapper for the Cloudflare API. ###
https://api.cloudflare.com

---

Current commands are:
```
Export-CloudflareZoneDNSRecord
Get-CloudflareAccount
Get-CloudflareOrganization
Get-CloudflareZone
Get-CloudflareZoneAvailablePlan
Get-CloudflareZoneAvailableRatePlan
Get-CloudflareZoneDNSRecord
Get-CloudflareZonePageRule
Get-CloudflareZoneSubscription
Import-CloudflareZoneDNSRecord
Invoke-CloudflareZoneActivation
New-CloudflareZone
New-CloudflareZoneDNSRecord
New-CloudflareZonePageRule
Remove-CloudflareZone
Remove-CloudflareZoneDNSRecord
Remove-CloudflareZonePageRule
Set-CloudflareZone
Set-CloudflareZoneDNSRecord
```

```
# Set your credentials as environment variables.
# This needs to be done every time you start your shell and are using the PSCloudflare module.
PS C:\> $env:CloudflareEmail = 'tomohulk@github.io'
PS C:\> $env:CloudflareAPIKey = 'c2547eb745079dac9320b638f5e225cf483cc5cfdda41'
```

```
# Get a Zone.
PS C:\> Get-CloudflareZone -Name im.tomohulk.io

# Get the Proxied records from a Zone.
PS C:\> Get-CloudflareZone -Name im.tomohulk.io | Get-CloudflareDNSRecord -Proxied
```

```
# Get your Cloudflare Account info.
PS C:\> $cfAccount = Get-CloudflareAccount
# Create a new zone.
PS C:\> $zone = New-CloudflareZone -Name tomohulk.io -Account $cfAccount -Jumpstart
# Add a DNSRecord to the zone.
PS C:\> New-CloudflareZoneDNSRecord -Zone $zone -Type A -Name 'blog.tomohulk.io' -Content '127.0.0.1' -Proxied
# Remove the zone.
PS C:\> Remove-CloudflareZone -Zone $zone
```

---

### !!!USE AT YOUR OWN RISK!!! ###
Module is still very much in its infancy and should not be used in production at this time.

More to come.
