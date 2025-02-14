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
        $name
    )

    $listToDelete = Get-HuduLists -name $name

    if ($listToDelete -and $PSCmdlet.ShouldProcess($listToDelete.name)) {       
        $HuduRequest = @{
            Resource = "/api/v1/lists/$($listToDelete.id)"
            Method   = 'DELETE'
        }                 
        
        Invoke-HuduRequest @HuduRequest    
    }
}