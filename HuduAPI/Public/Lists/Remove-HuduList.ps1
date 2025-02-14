function Remove-HuduList {
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