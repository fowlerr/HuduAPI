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

    if ($PSCmdlet.ShouldProcess($id)) {
        Invoke-HuduRequest @HuduRequest    
    }
}