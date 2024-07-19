Function Move-PSReminder {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    [alias('Archive-PSReminder')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [int32]$Id,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

        $InvokeParams = @{
            ErrorAction = 'Stop'
            Path        = $DatabasePath
            Query       = $null
        }

    } #begin

    Process {
        <#
        columnIndex ColumnName      ColumnType
        ----------- ----------      ----------
        0           ArchivedEventID INTEGER
        1           EventID         INTEGER
        2           EventDate       TEXT
        3           EventName       TEXT
        4           EventComment    TEXT
        5           Tags            TEXT
        6           ArchivedDate    TEXT
        #>
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing EventID $ID"
        #always try to get the event
        $r = Invoke-MySQLiteQuery "Select * from $PSReminderTable where EventID='$ID'" -Path $PSReminderDB -WhatIf:$False
        $evt = "[{0}] {1}" -f $r.EventID, $r.EventName
        $ArchiveDate = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        if ($r -AND $PScmdlet.ShouldProcess($evt,"Archiving Event")) {
            #Move the event to the ArchivedEvent table
            Try {
                $InvokeParams.query ="Insert into $PSReminderArchiveTable (EventID, EventName, EventDate, EventComment,Tags,ArchivedDate) values ('$($r.EventID)', '$($r.EventName)', '$($r.EventDate)', '$($r.EventComment)','$($r.tags)','$ArchiveDate')"
                #Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($InvokeParams.query)"
                Invoke-MySQLiteQuery @InvokeParams
                #delete the event from the EventData table
                $InvokeParams.Query = "Delete from $PSReminderTable where EventID='$ID'"
                # Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($InvokeParams.query)"
                Invoke-MySQLiteQuery @InvokeParams
            }
            Catch {
                Throw $_
            }
        }

    } #process

    End {

        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Move-PSReminder