Function Import-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("None")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "The path and filename for the export xml file."
        )]
        [ValidateScript( { Test-Path $_ })]
        [ValidatePattern('\.xml$')]
        [String]$Path,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

        $InvokeParams = @{
            Query          = ""
            Path        = $DatabasePath
            ErrorAction    = "Stop"
        }

        #turn off identity_insert
#        $InvokeParams.query = "Set identity_insert EventData On"
#        [void](_InvokeSqlQuery @InvokeParams)
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Importing database data from $Path "
        Try {
            Import-Clixml -Path $path | ForEach-Object {
<#                 $query = @"
Set identity_insert EventData On
INSERT INTO EventData (EventID,EventDate,EventName,EventComment,Archived) VALUES ('$($_.EventID)','$($_.EventDate)','$(($_.EventName).replace("'",""))','$($_.EventComment)','$($_.Archived)')
Set identity_insert EventData Off
"@ #>
                $query = @"
INSERT INTO EventData (EventID,EventDate,EventName,EventComment) VALUES ('$($_.EventID)','$($_.EventDate)','$(($_.EventName).replace("'",""))','$($_.EventComment)')
"@
                $InvokeParams.query = $query

                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($InvokeParams.query)"

                if ($PSCmdlet.ShouldProcess("VALUES ('$($_.EventID)','$($_.EventDate)','$($_.EventName)','$($_.EventComment)','$($_.Archived)'")) {
                    Invoke-MySQLiteQuery @InvokeParams
                }
            }
        }
        Catch {
            throw $_
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
