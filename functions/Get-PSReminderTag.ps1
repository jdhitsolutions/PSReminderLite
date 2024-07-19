#list PSReminderTags showing the tag name and the ANSI sequence formatted using the ANSI escape sequence

Function Get-PSReminderTag {
    [cmdletbinding()]
    [OutputType('PSReminderTag')]
    Param()

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting PSReminder Tags from ``$PSReminderTag"
        #TODO get tags from the database not defined here
        $PSReminderTag.GetEnumerator() | ForEach-Object {
            $stringValue = $_.Value.Replace("$([char]27)", "``e")
            [PSCustomObject]@{
                PSTypeName = 'PSReminderTag'
                Tag        = $_.Key
                Style      = '{0}{1}{2}' -f $($_.Value), $stringValue, $("`e[0m")
            }
        }

        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting defined tags from the database not in `$PSReminderTag"
        (Invoke-MySQLiteQuery -query "select tags from $PSReminderTable where tags like '%'" -Path $PSReminderDB).foreach({$_.tags.split(",")}) |
        Select-Object -unique |
        Where-Object {$PSReminderTag.keys -notContains $_} |
        Foreach-Object {
            [PSCustomObject]@{
                PSTypeName = 'PSReminderTag'
                Tag        = $_
                Style      = $Null
            }
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Get-PSReminderTag


