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
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))

        $InvokeParams = @{
            Query       = ''
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.ImportData -f $Path)
        Try {
            #Create the new database
            Initialize-PSReminderDatabase -DatabasePath $DatabasePath -Comment $Comment
            Start-Sleep -Seconds 2
            #import event data
            $Import = Get-Content -Path $Path | ConvertFrom-Json
            $Import.EventData | ForEach-Object {
                if ($_.Tags -match '\w+') {
                    $TagString = $_.Tags -join ','
                }
                Else {
                    $TagString = ''
                }
                $InvokeParams.Query = "INSERT INTO $PSReminderTable (EventID,EventDate,EventName,EventComment,Tags) VALUES ('$($_.EventID)','$($_.EventDate)','$($_.EventName)','$($_.EventComment)','$($TagString)')"
                Invoke-MySQLiteQuery @InvokeParams
            }
            #import the archive data
            $Import.ArchivedEvent | ForEach-Object {
                if ($_.Tags -match '\w+') {
                    $TagString = $_.Tags -join ','
                }
                Else {
                    $TagString = ''
                }
                $InvokeParams.Query = "INSERT INTO $PSReminderArchiveTable (ArchivedEventID,EventID,EventDate,EventName,EventComment,Tags,ArchivedDate) VALUES ('$($_.ArchivedEventID)','$($_.EventID)','$($_.EventDate)','$($_.EventName)','$($_.EventComment)','($TagString)','$($_.ArchivedDate)')"
                Invoke-MySQLiteQuery @InvokeParams
            }
        } #Try
        Catch {
            throw $_
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        Write-Information $strings.ImportComplete
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end
}
