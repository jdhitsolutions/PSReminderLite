Function Get-AboutPSReminder {
    [cmdletbinding()]
    [OutputType('AboutPSReminder')]

    Param( )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

    } #begin

    Process {

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

        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Get-AboutPSReminder