Function New-CloudflareZonePageRule {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter( Mandatory = $true )]
        [String]
        $Target,

        [Parameter( Mandatory = $true )]
        [String]
        $TargetConstraintOperator,

        [Parameter( Mandatory = $true )]
        [String]
        $TargetConstraintValue,

        [Parameter( Mandatory = $true )]
        [String]
        $ActionID,

        [Parameter( Mandatory = $true )]
        [Hashtable]
        $ActionValue,

        [Parameter()]
        [Int]
        $Priority = 1,

        [Parameter()]
        [CloudflareZonePageRuleStatus]
        $Status = 'Disabled',

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    $endpoint = 'zones/{0}/pagerules' -f $Zone.ID

    $data = @{
        targets = @(@{
            target = $Target
            constraint = @{
                operator = $TargetConstraintOperator
                value = $TargetConstraintValue
            }
        })
        actions = @(@{
            id = $ActionID
            value = $ActionValue
        })
        priority = $Priority
        status = ( $Status -as [String] ).ToLower()
    }

    $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Data $data

    Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZonePageRule' -RawResponse $RawResponse.IsPresent
}
