#requires -Modules PSCloudflare

$zones = Get-CloudflareZone

foreach ($zone in $zones) {
    # Enabled HTTP to HTTPS redirect.
    if ((Get-CloudflareZoneSetting -Zone $zone -Setting AllwaysUseHTTPS).Value -eq 'Off') {
        Set-CloudflareZoneSetting -Zone $zone -Setting AllwaysUseHTTPS -Value On
    }

    # Enabled Web Application Firewall.
    if ((Get-CloudflareZoneWAF -Zone $zone).Value -eq 'Off') {
        Set-CloudflareZoneWAF -Zone $zone -Value 'On'
    }

    # Set the OWASP Package settings.
    $owaspWAFPackage = Get-CloudflareZoneWAFPackage -Zone $zone -Name 'OWASP ModSecurity Core Rule Set'
    if ($owaspWAFPackage.Sensitivity -ne 'Medium' -or $owaspWAFPackage.ActionMode -ne 'Simulate') {
        Set-CloudflareZoneWAFPackage -FirewallPackage $owaspWAFPackage -Sensitivity Medium -ActionMode Simulate
    }

    # Enabled the Cloudflare Miscellaneous Rule Group.
    $cloudflareWAFPackage = Get-CloudflareZoneWAFPackage -Zone $zone -Name 'CloudFlare'
    $miscRuleGroup = Get-CloudflareZoneWAFRuleGroup -FirewallPackage $cloudflareWAFPackage -Name 'Cloudflare Miscellaneous'
    if ($miscRuleGroup.Mode -ne 'On') {
        Set-CloudflareZoneWAFRuleGroup -FirewallPackage $cloudflareWAFPackage -RuleGroup $miscRuleGroup -Mode On
    }
}
