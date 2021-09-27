#
# Module manifest for module 'PSCloudflare'
#
# Generated by: Thomas Malkewitz @tomohulk
#
# Generated on: 9/2/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSCloudflare'

# Version number of this module.
ModuleVersion = '0.0.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '7747b7b4-05ff-468f-94f7-fd3f4ff05cdc'

# Author of this module
Author = 'Thomas Malkewitz @tomohulk'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) Thomas Malkewitz @tomohulk. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell Wrapper for the Cloudflare API.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
ScriptsToProcess = @(
    'Private\PSCloudflare.ObjectDefinitions.ps1'
)

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Export-CloudflareZoneDNSRecord',
    'Get-CloudflareAccount',
    'Get-CloudflareOrganization',
    'Get-CloudflareZone',
    'Get-CloudflareZoneAlwaysUseHTTPS',
    'Get-CloudflareZoneAvailablePlan',
    'Get-CloudflareZoneAvailableRatePlan',
    'Get-CloudflareZoneDNSRecord',
    'Get-CloudflareZonePageRule',
    'Get-CloudflareSubscription',
    'Get-CloudflareZoneWAF',
    'Get-CloudflareZoneWAFPackage',
    'Get-CloudflareZoneWAFRuleGroup',
    'Import-CloudflareZoneDNSRecord',
    'Initialize-CloudflareZonePageRuleAction',
    'Initialize-CloudflareZonePageRuleTarget',
    'Invoke-CloudflareZoneActivation',
    'New-CloudflareZone',
    'New-CloudflareZoneDNSRecord',
    'New-CloudflareZonePageRule',
    'Remove-CloudflareZone',
    'Remove-CloudflareZoneDNSRecord',
    'Remove-CloudflareZonePageRule',
    'Set-CloudflareZone',
    'Set-CloudflareZoneAlwaysUseHTTPS',
    'Set-CloudflareZoneDNSRecord',
    'Set-CloudflareZonePageRule',
    'Set-CloudflareZoneWAF',
    'Set-CloudflareZoneWAFPackage',
    'Set-CloudflareZoneWAFRuleGroup'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
# CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
# AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = @(
    'Private\Format-CloudflareEndpointString.ps1',
    'Private\Invoke-CloudflareAPI.ps1',
    'Private\PSCloudflare.ObjectDefinitions.ps1',
    'Private\Write-CloudflareResponse.ps1',
    'Public\Export-CloudflareZoneDNSRecord.ps1',
    'Public\Get-CloudflareAccount.ps1',
    'PUblic\Get-CloudflareOrganization.ps1',
    'Public\Get-CloudflareZone.ps1',
    'Public\Get-CloudflareZoneAlwaysUseHTTPS.ps1',
    'Public\Get-CloudflareZoneAvailablePlan.ps1',
    'Public\Get-CloudflareZoneAvailableRatePlan.ps1',
    'Public\Get-CloudflareZoneDNSRecord.ps1',
    'Public\Get-CloudflareZonePageRule.ps1',
    'Public\Get-CloudflareSubscription.ps1',
    'Public\Import-CloudflareZoneDNSRecord.ps1',
    'Public\Get-CloudflareZoneWAF.ps1',
    'Public\Get-CloudflareZoneWAFPackage.ps1',
    'Public\Get-CloudflareZoneWAFRuleGroup.ps1',
    'Public\Initialize-CloudflareZonePageRuleAction.ps1',
    'Public\Initialize-CloudflareZonePageRuleTarget.ps1',
    'Public\Invoke-CloudflareZoneActivation.ps1',
    'Public\New-CloudflareZone.ps1',
    'Public\New-CloudflareZoneDNSRecord.ps1',
    'Public\New-CloudflareZonePageRule.ps1',
    'Public\Remove-CloudflareZone.ps1',
    'Public\Remove-CloudflareZoneDNSRecord.ps1',
    'Public\Remove-CloudflareZonePageRule.ps1',
    'Public\Set-CloudflareZone.ps1',
    'Public\Set-CloudflareZoneAlwaysUseHTTPS.ps1',
    'Public\Set-CloudflareZoneDNSRecord.ps1',
    'Public\Set-CloudflareZonePageRule.ps1',
    'Public\Set-CloudflareZoneWAF.ps1',
    'Public\Set-CloudflareZoneWAFPackage.ps1',
    'Public\Set-CloudflareZoneWAFRuleGroup.ps1',
    'PSCloudflare.psd1',
    'PSCloudflare.psm1'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

