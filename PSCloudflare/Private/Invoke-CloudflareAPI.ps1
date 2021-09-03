Function Invoke-CloudflareAPI {
    
    [CmdletBinding(
        ConfirmImpact = 'Low',
        SupportsShouldProcess = $true
    )]
    [OutputType()]

    Param (
        [Parameter(
            Mandatory = $false
        )]
        [HashTable] 
        $Headers = @{},
        
        [Parameter(
            Mandatory = $true
        )]
        [ValidateSet(
            "GET", "POST", "PUT", "PATCH", "DELETE"
        )]
        [String] 
        $Method,

        [Parameter(
            Mandatory = $true
        )]
        [String] 
        $APIQuery
    )

    Begin {
        try {
            [Void][Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
            
            $vault = New-Object -TypeName Windows.Security.Credentials.PasswordVault -ErrorAction Stop
            $email = $vault.FindAllByResource('https://api.cloudflare.com').username
            $password = $vault.Retrieve('https://api.cloudflare.com', $email).password
        } catch {
            Write-Error -Message 'There is no valid Cloudflare API Token stored in the Windows Credential Manager.  Please use the Set-CloudflareAPIToken function to configure an API token.'
            return
        }

        $Headers.Add(
            'X-Auth-Email', $email
        )
        $Headers.Add(
            'X-Auth-Key', $password
        )
        $Headers.Add(
            'Content-type', 'application/json'
        )

        $request = @{
            Headers = $Headers
            Uri = 'https://api.cloudflare.com/client/v4/{0}' -f $APIQuery
            Method = $Method
            ErrorAction = 'Stop'
        }

        try {
            if ($PSCmdlet.ShouldProcess($request)) {
                Invoke-RestMethod @request
            }
        } catch {
            $_
            return
        }
    }

    Process {}

    End {
        Remove-Variable -Name email, password -Force -Confirm:$false

        [GC]::Collect()
    }
}