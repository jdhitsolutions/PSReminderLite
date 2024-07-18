Function Initialize-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None','System.IO.FileInfo')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'Enter the full path for the SQLite database file. It should end in .db'
        )]
        [ValidateScript( { Test-Path $_ })]
        [ValidatePattern('.*\.db$')]
        [ValidateNotNullOrEmpty()]
        [String]$DatabasePath = $PSReminderDB,

        [Parameter(HelpMessage = 'Specify an optional comment for the database')]
        [string]$Comment = 'PSReminderLite database',

        [Parameter(HelpMessage = 'Write the database file object to the pipeline')]
        [switch]$Passthru
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

        $NewTables = @"
CREATE TABLE $PSReminderTable (
    EventID INTEGER PRIMARY KEY AUTOINCREMENT,
    EventDate TEXT NOT NULL,
    EventName TEXT NOT NULL,
    EventComment TEXT
);
CREATE TABLE $PSReminderArchiveTable (
    ArchivedEventID INTEGER PRIMARY KEY AUTOINCREMENT,
    EventID INTEGER NOT NULL,
    EventDate TEXT NOT NULL,
    EventName TEXT NOT NULL,
    EventComment TEXT,
    ArchivedDate TEXT NOT NULL
);
"@

    } #begin

    Process {
        if (Test-Path -Path $DatabasePath) {
            Write-Warning "A file was already found at $DatabasePath. Initialization aborted."
            #bail out if the database file already exists
            return
        }

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating SQLite database $DatabasePath"

        Try {
            #need to explicitly pass the WhatIf preference to these commands
            New-MySQLiteDB -Path $DatabasePath -Comment $Comment -Force -ErrorAction Stop -WhatIf:$WhatIfPreference
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating tables"
            Write-Verbose $NewTables
            if ($PSCmdlet.ShouldProcess($DatabasePath, 'Create table EventData')) {
                Invoke-MySQLiteQuery -Query $NewTables -Path $DatabasePath -ErrorAction Stop
            }
        } #Try
        Catch {
            Throw $_
        }

        Write-Host 'Database initialization complete.' -ForegroundColor Green
        if ((-not $WhatIfPreference) -and $Passthru) {
            Get-Item -Path $DatabasePath
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
