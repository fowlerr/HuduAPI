function Get-HuduLists {
    <#
    .DESCRIPTION
    Get a list of lists.

    .PARAMETER query
    Filter lists by query.  This supports partial matches on the name field.

    .PARAMETER name
    Filter lists by name.  This must be an exact match

    .EXAMPLE
    Get-HuduLists -query 'test'

    .EXAMPLE
    Get-HuduLists -name 'test'
    
    #>
    [CmdletBinding()]
    param (
        [string]
        $query,

        [string]
        $name
    )

    $HuduRequest = @{
        Resource = '/api/v1/lists'
        Method   = 'GET'
    }

    $Params = @{}

    if ($query) { $Params.query = $query }
    if ($name) { $Params.name = $name } 

    if ($query -or $name) { $HuduRequest.Params = $Params }   

    Invoke-HuduRequestPaginated -HuduRequest $HuduRequest -Property 'lists'

}