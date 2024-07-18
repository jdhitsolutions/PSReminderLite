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
        [Parameter(ParameterSetName = 'Offline')]
        [Alias('days')]
        [Int]$Next = $PSReminderDefaultDays,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

        $InvokeParams = @{
            Query       = $null
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using parameter set $($PSCmdlet.ParameterSetName)"
        Switch ($PSCmdlet.ParameterSetName) {
            'ID' {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] by ID"
                $filter = "Select * from $PSReminderTable where EventID='$ID'"
            }
            'Name' {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] by Name"
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
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] for the next $next days"
                $target = (Get-Date).Date.AddDays($next).ToString('yyyy-MM-dd HH:mm:ss')
                #(Get-Date).Date.AddDays($next).ToString()
                $filter = "Select * from $PSReminderTable where EventDate<='$target' AND EventDate > '$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))' ORDER by EventDate Asc"
            }
            'Expired' {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] by Expiration"
                #get expired events that have not been archived
                $filter = "Select * from $PSReminderTable where EventDate<'$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))' ORDER by EventDate Asc"
            }
            'Archived' {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] by Archive"
                $filter = "Select * from $PSReminderArchiveTable  ORDER by EventDate Asc"
            }
            'All' {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] All"
                #get all non archived events
                $filter = "Select * from $PSReminderTable ORDER by EventDate Asc"
            }
            Default {
                #this should never get called
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Default"
                #get events that haven't been archived
                $filter = "Select * from $PSReminderTable where EventDate>='$(Get-Date)' ORDER by EventDate Asc"
            }
        } #switch

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Importing events from $DatabasePath"
        #Query database for matching events
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $filter"
        $InvokeParams.query = $filter

        Try {
            $events = Invoke-MySQLiteQuery @InvokeParams
            #convert the data into PSReminder objects
            if ($Archived) {
                $data = $events | _NewArchivePSReminder
            }
            else {
                $data = $events | _NewPSReminder
            }
        }
        Catch {
            Throw $_
        }

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Found $($events.count) matching events"
        #write event data to the pipeline
        $data
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
