function Remove-HuduList {
    <#
    .DESCRIPTION
    Delete a list.

    .PARAMETER id
    The ID of the list to delete.

    .EXAMPLE
    Remove-HuduList -id '1'
    
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param (
        [string]
        $id
    )

    $HuduRequest = @{
        Resource = "/api/v1/lists/$list_id"
        Method   = 'DELETE'
    }


    $listToDelete = Get-HuduLists -id $id

    if ($listToDelete -and $PSCmdlet.ShouldProcess($listToDelete.name)) {        
        Invoke-HuduRequest @HuduRequest    
    }
}