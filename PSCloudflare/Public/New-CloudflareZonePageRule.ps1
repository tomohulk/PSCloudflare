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
        $ConstraintOperator,

        [Parameter( Mandatory = $true )]
        [String]
        $ConstraintValue,

        [Parameter( Mandatory = $true )]
        [String]
        $ActionID,

        [Parameter( Mandatory = $true )]
        [String]
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

    $data = ConvertTo-Json -InputObject @{
        Targets = @{
            Target = $Target
            Constraint = @{
                Operator = $ConstraintOperator
                Value = $ConstraintValue
            }
        }
        Actions = @{
            ID = $ActionID
            Value = $ActionValue
        }
        Priority = $Priority
        Status = $Status
    }

    $response = Invoke-CloudflareAPI -Method POST -Endpoint $endpoint -Data $data

    Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZonePageRule' -RawResponse $RawResponse.IsPresent
}
