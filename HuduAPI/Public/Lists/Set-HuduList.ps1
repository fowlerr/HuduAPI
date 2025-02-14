function Set-HuduList {
    <#
    .DESCRIPTION
    Update a list.

    .PARAMETER id
    The ID of the list to update.

    .PARAMETER name
    This is to update the name of the list.

    .PARAMETER list_items_attributes
    This is to update the list items of the list.  If you want to add an item include it without id.  If you want to remove an item include the id and _destroy = true.

    .EXAMPLE
    $listItems = @(
        [PSCustomObject]@{id=833; name='updated item'},
        [PSCustomObject]@{name='New Items'},
        [PSCustomObject]@{id=834;_destroy=$true}
    )
    Set-HuduList -id 20 -name 'testing20nameChange' -list_items_attributes $listItems


    #>
    [CmdletBinding()]
    param (
        [string]
        $id,

        [string]
        $name,

        [PSCustomObject[]]
        $list_items_attributes
    )

    $body = [PSCustomObject]@{
        list = @{            
            list_items_attributes = $list_items_attributes
        }
    }

    if ($name) { $body.list | Add-Member -NotePropertyName name -NotePropertyValue $name }

    # Prevent unboxing of single-item arrays, using pipeline will unbox single-item arrays
    $JSON = ConvertTo-Json -Depth 10 -InputObject $body

    $HuduRequest = @{
        Resource = "/api/v1/lists/$id"
        Method   = 'PUT'
        Body     = $JSON
    }

    Invoke-HuduRequest @HuduRequest
}