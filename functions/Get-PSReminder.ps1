Function Get-PSReminder {

    [CmdletBinding(DefaultParameterSetName = 'Days')]
    [OutputType('PSReminder')]
    [Alias('gpsr')]

    Param(
        [Parameter(
            ParameterSetName = 'ID',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [int32]$Id,
        [Parameter(
            ParameterSetName = 'Name',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Name')]
        [String]$EventName,
        [Parameter(ParameterSetName = 'All')]
        [Switch]$All,
        [Parameter(ParameterSetName = 'Expired')]
        [Switch]$Expired,
        [Parameter(ParameterSetName = 'Archived')]
        [Switch]$Archived,
        [ValidateScript( { $_ -gt 0 })]
        [Parameter(ParameterSetName = 'Days')]
        [Alias('days')]
        [Int]$Next = $PSReminderDefaultDays,
        [Parameter(ParameterSetName = 'Month',HelpMessage = 'Select the year for unexpired reminders by month. The default is the current year.')]
        [int]$Year = (Get-Date).Year,
        [Parameter(ParameterSetName = 'Month',HelpMessage = 'Select unexpired reminders by month')]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, 12)]
        [ValidateSet(1,2,3,4,5,6,7,8,9,10,11,12)]
        [int]$Month,
        [Parameter(HelpMessage = 'Select reminders by a tag', ParameterSetName = 'Tag')]
        [SupportsWildcards()]
        [ValidateNotNullOrEmpty()]
        [String]$Tag,
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
            Query       = $null
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin
    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.ParameterSet -f $($PSCmdlet.ParameterSetName))
        Switch ($PSCmdlet.ParameterSetName) {
            'ID' {
                _verbose $($strings.ByID -f $ID)
                $filter = "Select * from $PSReminderTable where EventID='$ID'"
            }
            'Name' {
                _verbose $($strings.ByName -f $EventName)
                #get events that haven't expired or been archived by name
                if ($EventName -match '\*') {
                    $EventName = $EventName.replace('*', '%')
                }
                $filter = "Select * from $PSReminderTable where EventName LIKE '$EventName'  AND EventDate>'$(Get-Date)'"
            }
            'Days' {
                <#
                    SELECT * FROM $PSReminderTable
                    WHERE Archived = '0'
                    AND EventDate <= '2024-07-21 00:00:00'
                    AND EventDate > '2024-07-17 15:07:42'
                    ORDER BY EventDate ASC;
                #>
                _verbose $($strings.ByDays -f $Next)
                $target = (Get-Date).Date.AddDays($next).ToString('yyyy-MM-dd HH:mm:ss')
                #(Get-Date).Date.AddDays($next).ToString()
                $filter = "Select * from $PSReminderTable where EventDate<='$target' AND EventDate > '$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))' ORDER by EventDate Asc"
            }
            'Expired' {
                _verbose $($strings.ByExpiration)
                #get expired events that have not been archived
                $filter = "Select * from $PSReminderTable where EventDate<'$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))' ORDER by EventDate Asc"
            }
            'Archived' {
                _verbose $($strings.ByArchive -f $PSReminderArchiveTable)
                $filter = "Select * from $PSReminderArchiveTable ORDER by EventDate Asc"
            }
            'Month' {
                _verbose $($strings.ByMonth -f $Month,$Year)
                $target = (Get-Date -Year $Year -Month $Month -Day 1).ToString('yyyy-MM-dd HH:mm:ss')
                if ($month -eq 12) {
                    $targetEnd = (Get-Date -Year ($Year+1) -Month 1 -Day 1).ToString('yyyy-MM-dd HH:mm:ss')
                }
                else {
                    $targetEnd = $((Get-Date -Year $Year -Month ($Month+1) -Day 1).ToString('yyyy-MM-dd HH:mm:ss'))
                }
                $today = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
                $filter = "Select * from $PSReminderTable where EventDate >='$Today' AND EventDate>='$target' AND EventDate<'$targetEnd' ORDER by EventDate Asc"
            }
            'All' {
                _verbose $($strings.ByAll)
                #get all non archived events
                $filter = "Select * from $PSReminderTable ORDER by EventDate Asc"
            }
            'Tag' {
                $Tag = $Tag -replace '\*', '%'
                _verbose $($strings.ByTag -f $Tag)
                $filter = "Select * from $PSReminderTable where Tags LIKE '%$Tag' ORDER by EventDate Asc"
            }
            Default {
                #this should never get called
                _verbose $($strings.Default)
                #get events that haven't been archived
                $filter = "Select * from $PSReminderTable where EventDate>='$(Get-Date)' ORDER by EventDate Asc"
            }
        } #switch

        _verbose $($strings.ImportFrom -f $DatabasePath)
        #Query database for matching events
        _verbose $filter
        $InvokeParams.query = $filter

        Try {
            $events = Invoke-MySQLiteQuery @InvokeParams
            #convert the data into PSReminder objects
            if ($Archived) {
                $data = $events | _NewArchivePSReminder -Source $DatabasePath
            }
            else {
                $data = $events | _NewPSReminder -Source $DatabasePath
            }
        }
        Catch {
            Throw $_
        }

        _verbose $($strings.Found -f $($data.Count))
        #write event data to the pipeline
        $data
    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end
}
