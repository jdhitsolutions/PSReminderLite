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
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))

        $InvokeParams = @{
            ErrorAction = 'Stop'
            Path        = $DatabasePath
            Query       = $null
        }

    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
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
        _verbose $($strings.Processing -f $ID)
        #always try to get the event
        $r = Invoke-MySQLiteQuery "Select * from $PSReminderTable where EventID='$ID'" -Path $PSReminderDB -WhatIf:$False
        $evt = '[{0}] {1}' -f $r.EventID, $r.EventName
        $ArchiveDate = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        if ($r -AND $PScmdlet.ShouldProcess($evt, 'Archiving Event')) {
            #Move the event to the ArchivedEvent table
            Try {
                $InvokeParams.query = "Insert into $PSReminderArchiveTable (EventID, EventName, EventDate, EventComment,Tags,ArchivedDate) values ('$($r.EventID)', '$($r.EventName)', '$($r.EventDate)', '$($r.EventComment)','$($r.tags)','$ArchiveDate')"
                _verbose $($InvokeParams.query)
                Invoke-MySQLiteQuery @InvokeParams
                #delete the event from the EventData table
                $InvokeParams.Query = "Delete from $PSReminderTable where EventID='$ID'"
                _verbose $($InvokeParams.query)
                Invoke-MySQLiteQuery @InvokeParams
            }
            Catch {
                Throw $_
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

} #close Move-PSReminder
