function New-HuduList {
    <#
    .DESCRIPTION
    Create a new list.

    .PARAMETER name
    The name of the list.

    .PARAMETER list_items_attributes
    A string array of list items to add to the list.

    .EXAMPLE
    New-HuduList -name 'test' -list_items_attributes 'item1', 'item2'
    #>
    [CmdletBinding()]
    param (
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
        Resource = '/api/v1/lists'
        Method   = 'POST'
        Body     = $JSON
    }

    Invoke-HuduRequest @HuduRequest

}