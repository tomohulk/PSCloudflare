Function Set-CloudflareApiToken {
    
    [CmdletBinding(
        ConfirmImpact = 'High',
        SupportsShouldProcess = $true
    )]
    [OutputType(
        [Void]
    )]

    Param (
        [Parameter(
            HelpMessage = 'The email of the user to act on behalf of.',
            Mandatory = $true
        )]
        [String]
        $Email,

        [Parameter(
            HelpMessage = 'The value of a token from https://dash.cloudflare.com/profile/api-tokens.',
            Mandatory = $true
        )]
        [String]
        $Token
    )

    Begin {
        try {
            [Void][Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
            
            $vault = New-Object -TypeName Windows.Security.Credentials.PasswordVault -ErrorAction Stop
        } catch {
            $_
            return
        }

        try {
            if (($vault.FindAllByResource('https://api.cloudflare.com')).Count -gt 0) {
                if ($PSCmdlet.ShouldProcess($vault, 'Setting Cloudflare API Token.  There is already an API Token present, do you wish to update the value?')) {
                    $vault.Add((New-Object -TypeName Windows.Security.Credentials.PasswordCredential -ArgumentList 'https://api.cloudflare.com', $Email, $Token))
                }
            }
        } catch {
            try {
                $vault.Add((New-Object -TypeName Windows.Security.Credentials.PasswordCredential -ArgumentList 'https://api.cloudflare.com', $Email, $Token))
            } catch {
                $_
                return
            }
        }
    }

    End {
        Remove-Variable -Name Token -Force -Confirm:$false
        
        [GC]::Collect()
    }
}
