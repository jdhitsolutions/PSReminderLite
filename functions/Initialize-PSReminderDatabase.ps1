Function Initialize-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None', 'System.IO.FileInfo')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the full path for the SQLite database file. It should end in .db'
        )]
        [ValidatePattern('.*\.db$')]
        [ValidateNotNullOrEmpty()]
        [String]$DatabasePath = $PSReminderDB,

        [Parameter(HelpMessage = 'Specify an optional comment for the database')]
        [string]$Comment = 'PSReminderLite database',

        [Parameter(HelpMessage = 'Write the database file object to the pipeline')]
        [switch]$Passthru
    )
    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))

        $NewTables = @"
CREATE TABLE $PSReminderTable (
    EventID INTEGER PRIMARY KEY AUTOINCREMENT,
    EventDate TEXT NOT NULL,
    EventName TEXT NOT NULL,
    EventComment TEXT,
    Tags TEXT
);
CREATE TABLE $PSReminderArchiveTable (
    ArchivedEventID INTEGER PRIMARY KEY AUTOINCREMENT,
    EventID INTEGER NOT NULL,
    EventDate TEXT NOT NULL,
    EventName TEXT NOT NULL,
    EventComment TEXT,
    Tags TEXT,
    ArchivedDate TEXT NOT NULL
);
"@

    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        if (Test-Path -Path $DatabasePath) {
            Write-Warning $($strings.DBExists -f $DatabasePath)
            #bail out if the database file already exists
            return
        }

        _verbose $($strings.CreateDB -f $DatabasePath)

        Try {
            #need to explicitly pass the WhatIf preference to these commands
            New-MySQLiteDB -Path $DatabasePath -Comment $Comment -Force -ErrorAction Stop -WhatIf:$WhatIfPreference
            _verbose $($strings.CreateTables -f $PSReminderTable, $PSReminderArchiveTable)
            Write-Verbose $NewTables
            if ($PSCmdlet.ShouldProcess($DatabasePath, $($strings.CreateEventData))) {
                Invoke-MySQLiteQuery -Query $NewTables -Path $DatabasePath -ErrorAction Stop
            }
        } #Try
        Catch {
            Throw $_
        }

        Write-Information $strings.InitComplete
        if ((-not $WhatIfPreference) -and $Passthru) {
            Get-Item -Path $DatabasePath
        }

    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

}
