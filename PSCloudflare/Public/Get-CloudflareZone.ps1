Function Get-CloudflareZone {

    [CmdletBinding()]
    [OutputType([CloudflareZone])]

    Param (
        [Parameter()]
        [Alias('Hostname')]
        [ValidateLength(0, 253)]
        [String]
        $Name,

        [Parameter()]
        [CloudflareZoneStatus]
        $Status,

        [Parameter()]
        [ValidateLength(0, 100)]
        [String]
        $AccountName,

        [Parameter()]
        [ValidateLength(0, 32)]
        [String]
        $AccountID,

        [Parameter(HelpMessage = 'Returns the raw WebRequest response opposed to the Cloudflare .net object.')]
        [Switch]
        $RawResponse

    )

    Process {
        $endpoint = 'zones'

        $parameterList = [Hashtable]$PSBoundParameters

        # Increase the pagination threshold from 20 to 50 to ideally make less calls if the the result count is high.
        $parameterList.Add('per_page', '50')

        # Update AccountName and/or AccountID parameter names to match expected format used by the Cloudflare API, but still follow PowerShell best practices.
        if ($PSBoundParameters.ContainsKey('AccountName')) {
            $parameterList.Add('account.name', $parameterList.Item( 'AccountName'))

            $parameterList.Remove('AccountName')
        }

        if ($PSBoundParameters.ContainsKey('AccountID')) {
            $parameterList.Add('account.id', $parameterList.Item('AccountID'))
            
            $parameterList.Remove('AccountID')
        }

        $endpoint += Format-CloudflareEndpointString -ParameterList $parameterList

        $response = Invoke-CloudflareAPI -Method Get -Endpoint $endpoint

        Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent

        # The Cloudflare API maximum result count before pagination is 50.
        # If the result info count is greater then one page, this will loop through each page.
        if ($response.result_info.total_pages -gt 1) {
            for ($i = 2; $i -le $response.result_info.total_pages; $i++) {
                $response = Invoke-CloudflareAPI -Method Get -Endpoint ('{0}&page={1}' -f $endpoint, $i)

                Write-CloudflareResponse -Response $response -ObjectType 'CloudflareZone' -RawResponse $RawResponse.IsPresent
            }
        }
    }
}
