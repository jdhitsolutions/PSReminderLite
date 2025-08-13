Function Get-PSReminderDBInformation {
    [CmdletBinding()]
    [OutputType('PSReminderDBInfo')]
    Param(
        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose ($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose ($strings.PSVersion -f $($PSVersionTable.PSVersion))
        _verbose ($strings.UsingHost -f $host.Name)
        _verbose ($strings.UsingOS -f $PSVersionTable.OS)
        _verbose ($strings.UsingModule -f $ModuleVersion)
        _verbose ($strings.UsingMySQLite -f (Get-Module mySQLite).version)
    } #begin
    Process {
            [PSReminderDBInfo]::New($DatabasePath)
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        If ($conn.state -eq 'Open') {
            _verbose $strings.CloseDB
            $conn.Close()
        }
        _verbose ($strings.Ending -f $($MyInvocation.MyCommand))
    } #end
}
