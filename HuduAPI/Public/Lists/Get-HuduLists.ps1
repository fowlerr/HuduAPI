function Get-HuduLists {
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