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
Get-CloudflareZoneSetting
Get-CloudflareZoneSubscription
Get-CloudflareZoneWAFPackage
Get-CloudflareZoneWAFRuleGroup
Import-CloudflareZoneDNSRecord
Initialize-CloudflareZonePageRuleAction
Initialize-CloudflareZonePageRuleTarget
Invoke-CloudflareZoneActivation
New-CloudflareZone
New-CloudflareZoneDNSRecord
New-CloudflareZonePageRule
Remove-CloudflareZone
Remove-CloudflareZoneDNSRecord
Remove-CloudflareZonePageRule
Set-CloudflareZone
Set-CloudflareZoneDNSRecord
Set-CloudflareZoneFirewallPackage
Set-CloudflareZonePageRule
Set-CloudflareZoneSetting
Set-CloudflareZoneWAFPackage
Set-CloudflareZoneWAFRuleGroup
```

You will be prompted to input your Cloudflare Email and API key when you import the module.
This will need to be done every time you start a new shell and load the PSCloudflare module.
You could also set the `$env:CloudflareEmail` and `$env:CloudflareAPIKey` variables in a profile script.
![ModuleImport](/Docs/Images/ModuleImport.png?raw=true)


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

More examples can be found in /Docs/Examples.

---

### !!!USE AT YOUR OWN RISK!!! ###
Module is still very much in its infancy and should not be used in production at this time.

More to come.
