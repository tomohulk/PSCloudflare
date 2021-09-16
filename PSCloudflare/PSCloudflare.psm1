#region ProviderPath

$paths = @(
    'Private',
    'Public'
)

foreach ($path in $paths) {
    "$(Split-Path -Path $MyInvocation.MyCommand.Path)\$path\*.ps1" | 
        Resolve-Path | 
            ForEach-Object { 
                . $_.ProviderPath 
            }
}

#endregion ProviderPath

#region ApiCredentials

if ($null -eq $env:CloudflareEmail) {
    $env:CloudflareEmail = Read-Host -Prompt 'Enter Cloudflare Email'
}

if ($null -eq $env:CloudflareAPIKey) {
    $env:CloudflareAPIKey = Read-Host -Prompt 'Enter Cloudflare API Key' -MaskInput
}
