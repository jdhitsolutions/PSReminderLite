function Remove-PSReminder {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]
    [Alias('rpsr')]

    param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [int32]$ID,

        [Parameter(Mandatory,HelpMessage = 'Specify the reminder category: Archived, Expired, or Reminder.')]
        [ValidateSet('Reminder', 'Expired', 'Archived')]
        [string]$Category,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )
    begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))

        $InvokeParams = @{
            Query       = $null
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

        $tableHash = @{
            Reminder  = 'EventData'
            Expired   = 'EventData'
            Archived  = 'ArchivedEvent'
        }

    } #begin

    process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        $tableName = $tableHash[$Category]
        _verbose $($strings.Deleting -f $ID,$tableName)
        $InvokeParams.query = "DELETE From $tableName where EventID='$ID'"
        Write-Information $InvokeParams -Tags Process
        if ($PSCmdlet.ShouldProcess("Event ID $ID")) {
            try {
                Invoke-MySQLiteQuery @InvokeParams
            }
            catch {
                throw $_
            }
        } #should process
    } #process

    end {
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end
}
