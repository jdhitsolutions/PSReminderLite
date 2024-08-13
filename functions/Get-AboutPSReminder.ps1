Function Get-AboutPSReminder {
    [cmdletbinding()]
    [OutputType('AboutPSReminder')]

    Param( )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose ($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose ($strings.PSVersion -f $($PSVersionTable.PSVersion))
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $strings.GetVer
        [PSCustomObject]@{
            PSTypeName    = 'AboutPSReminder'
            ModuleName    = 'PSReminderLite'
            Version       = (Get-Module PSReminderLite).Version
            MySQLite      = (Get-Command Invoke-MySQLiteQuery).Version
            SQLiteVersion = (Get-MySQLiteDB -Path $PSReminderDB).SQLiteVersion
            PSVersion     = $PSVersionTable.PSVersion
            Platform      = $PSVersionTable.Platform
            Host          = $Host.Name
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose ($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

} #close Get-AboutPSReminder
