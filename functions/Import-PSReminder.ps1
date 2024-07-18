Function Import-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The path and filename for the export JSON file.'
        )]
        [ValidateScript( { Test-Path $_ })]
        [ValidatePattern('\.json$')]
        [String]$Path,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [string]$DatabasePath = $PSReminderDB,

        [Parameter(HelpMessage = 'Specify an optional comment for the database')]
        [string]$Comment = 'Imported PSReminderLite database'
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

        $InvokeParams = @{
            Query       = ''
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Importing database data from $Path "
        Try {
            #Create the new database
            Initialize-PSReminderDatabase -DatabasePath $DatabasePath -Comment $Comment
            #import event data
            $Import = Get-Content -Path $Path | ConvertFrom-Json
            $Import.EventData | ForEach-Object {
                $InvokeParams.Query = "INSERT INTO $PSReminderTable (EventID,EventDate,EventName,EventComment) VALUES ('$($_.EventID)','$($_.EventDate)','$($_.EventName)','$($_.EventComment)')"
                Invoke-MySQLiteQuery @InvokeParams
            }
            #import the archive data
            $Import.ArchivedEvent | ForEach-Object {
                $InvokeParams.Query = "INSERT INTO $PSReminderArchiveTable (ArchivedEventID,EventID,EventDate,EventName,EventComment,ArchivedDate) VALUES ('$($_.ArchivedEventID)','$($_.EventID)','$($_.EventDate)','$($_.EventName)','$($_.EventComment)','$($_.ArchivedDate)')"
                Invoke-MySQLiteQuery @InvokeParams
            }
        } #Try
        Catch {
            throw $_
        }
    } #process

    End {
        Write-Host 'Import complete' -ForegroundColor Green
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
