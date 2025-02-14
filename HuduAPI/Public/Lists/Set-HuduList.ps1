function Update-HuduList {
    [CmdletBinding()]
    param (
        [string]
        $id,

        [string]
        $name,

        [string[]]
        $list_items_attributes
    )

    $body = [PSCustomObject]@{
        list = @{
            name = $name
            list_items_attributes = $list_items_attributes
        }
    }

    # Prevent unboxing of single-item arrays, using pipeline will unbox single-item arrays
    $JSON = ConvertTo-Json -Depth 10 -InputObject $body

    $HuduRequest = @{
        Resource = "/api/v1/lists/$id"
        Method   = 'PUT'
        Body     = $JSON
    }

    Invoke-HuduRequest @HuduRequest
}