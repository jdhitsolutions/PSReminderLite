Function Export-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The path and filename for the export JSON file.'
        )]
        [ValidatePattern('\.json$')]
        [String]$Path,

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

    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.ExportDB -f $DatabasePath, $Path)
        if ($PSCmdlet.ShouldProcess($Path, "Exporting database $DatabasePath")) {
            Try {
                Export-MySQLiteDB -Destination $Path -Path $DatabasePath -ErrorAction Stop
            }
            Catch {
                throw $_
            }
        } #should process
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

}
