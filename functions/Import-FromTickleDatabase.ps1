#import a TickleDatabase exported to a cliXML file into the PSReminder database

Function Import-FromTickleDatabase {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = 'The path to the exported Tickle database file. It should be an XML file.'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern('\.xml$')]
        [ValidateScript({ Test-Path $_ })]
        [String]$Path,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB,

        [Parameter(HelpMessage = 'Specify an optional comment for the database')]
        [string]$Comment = 'Imported from a Tickle database'
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))
        $InvokeParams = @{
            Query       = $null
            KeepAlive   = $True
            ErrorAction = 'Stop'
        }
        $ProgParams = @{
            Activity        = $strings.ImportTD
            Status          = ''
            PercentComplete = 0
        }
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.ImportTDPath -f $Path)
        Try {
            $in = Import-Clixml -Path $Path -ErrorAction Stop
        }
        Catch {
            Throw $_
        }
        If ($In.count -gt 0) {
            #Initialize a new database
            If (Test-Path -Path $DatabasePath) {
                Write-Warning $($strings.DBExists -f $DatabasePath)
                return
            }
            else {
                Initialize-PSReminderDatabase -DatabasePath $DatabasePath -comment $Comment

                #open connection
                $conn = Open-MySQLiteDB -Path $DatabasePath
                $InvokeParams.Add('Connection', $conn)
            }

            _verbose $($strings.ImportCount -f $($In.Count))
            #initialize a counter
            $i = 0
            foreach ($item in $in) {
                #format the event date
                $evtDate = $item.EventDate.ToString('yyyy-MM-dd HH:mm:ss')
                #parse out any apostrophes in the event
                $evt = $item.EventName.Replace("'", '')

                $i++
                $ProgParams.PercentComplete = $i / $in.count * 100
                $ProgParams.Status = $strings.ImportTickle -f $($item.EventID). $($item.EventName)
                Write-Progress @ProgParams
                If ($Item.Archived) {
                    #Import events where archived into the ArchiveData table
                    _verbose $($strings.ArchiveTickle -f $($Item.EventID), $($Item.EventName))
                    If ($PSCmdlet.ShouldProcess("[$($item.EventID)] $($Item.EventName)", "`e[38;5;222mArchive event`e[0m")) {
                        #Archive the event
                        $InvokeParams.Query = "Insert into $PSReminderArchiveTable (EventID,EventName,EventDate,EventComment,Tags,ArchivedDate) values ('$($item.EventID)','$($evt)','$($evtDate)','$($item.EventComment)','','$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))')"
                        Write-Verbose $InvokeParams.query
                        Invoke-MySQLiteQuery @InvokeParams
                    }
                } #if archived
                else {
                    #Import events where not archived into the EventData table
                    _verbose $($strings.ImportTickle -f $($Item.EventID), $($Item.EventName))

                    If ($PSCmdlet.ShouldProcess("[$($item.EventID)] $($Item.EventName)", 'Import event')) {
                        #Add the event
                        $InvokeParams.Query = "Insert into $PSReminderTable (EventID,EventName,EventDate,EventComment,Tags) values ('$($item.EventID)','$($evt)','$($evtDate)','$($item.EventComment)','')"
                        Write-Verbose $InvokeParams.query
                        Invoke-MySQLiteQuery @InvokeParams
                    }
                }
            } #foreach item

        } #if item count > 0
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        if ($conn.State -eq 'Open') {
            _verbose $($strings.CloseDB)
            $conn.Close()
        }
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

} #close Import-FromTickleDatabase
