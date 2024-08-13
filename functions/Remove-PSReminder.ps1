Function Remove-PSReminder {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]
    [Alias('rpsr')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [int32]$ID,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )
    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))

        $InvokeParams = @{
            Query       = $null
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.Deleting -f $ID)
        $InvokeParams.query = "DELETE From EventData where EventID='$ID'"
        if ($PSCmdlet.ShouldProcess("Event ID $ID")) {
            Try {
                Invoke-MySQLiteQuery @InvokeParams
            }
            Catch {
                Throw $_
            }
        } #should process
    } #process

    End {
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end
}
