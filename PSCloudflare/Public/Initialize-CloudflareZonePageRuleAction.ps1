Function Initialize-CloudflareZonePageRuleAction {

    [CmdletBinding()]
    [OutputType( [CloudflareZonePageRuleAction] )]

    Param (
        [Parameter( Mandatory = $true)]
        [String]
        $ID,

        [Parameter( Mandatory = $true)]
        [Hashtable]
        $Value
    )
    
    $object = @{
        ID = $ID
        Value = $Value
    }

    [CloudflareZonePageRuleAction]::new( $object )
}
