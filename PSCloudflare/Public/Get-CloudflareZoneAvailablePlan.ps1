Function Get-CloudflareZoneAvailabePlan {

    [CmdletBinding()]
    [OutputType()]

    Param (
        [Parameter( HelpMessage = 'A Cloudflare Zone object returned from Get-CloudflareZone.', Mandatory = $true, ValueFromPipeline = $true )]
        [CloudflareZone]
        $Zone,

        [Parameter()]
        [String]
        $ID,

        [Parameter( HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.' )]
        [Switch]
        $RawResponse
    )

    Process {
        $endpoint = 'zones/{0}/available_plans' -f $Zone.ID
        
        $parameterList = [Hashtable]$PSBoundParameters
        $parameterList.Remove( 'Zone' )

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList
        
        $response = Invoke-CloudflareAPI -Method GET -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -CloudflareObjectType 'CloudflareZonePlan' -RawResponse $RawResponse.IsPresent
    }
}
