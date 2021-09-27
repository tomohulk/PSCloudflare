Function Initialize-CloudflareZonePageRuleTarget {

    [CmdletBinding()]
    [OutputType([CloudflareZonePageRuleTarget])]

    Param (
        [Parameter(Mandatory = $true)]
        [String]
        $Target,

        [Parameter(Mandatory = $true)]
        [String]
        $Operator,

        [Parameter(Mandatory = $true)]
        [String]
        $Value
    )
    
    $object = @{
        Target = $Target
        Constraint = @{
            Operator = $Operator
            Value = $Value
        }
    }

    [CloudflareZonePageRuleTarget]::new($object)
}
