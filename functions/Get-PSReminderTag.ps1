#list PSReminderTags showing the tag name and the ANSI sequence formatted using the ANSI escape sequence

Function Get-PSReminderTag {
    [cmdletbinding()]
    [OutputType('PSReminderTag')]
    [alias('gprt')]
    Param()

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.GetTags)
        $pref = Get-PSReminderPreference
        $pref.ShowTags()

        _verbose $($strings.GetUndefinedTags)
        (Invoke-MySQLiteQuery -Query "select tags from $PSReminderTable where tags like '%'" -Path $PSReminderDB).foreach({ $_.tags.split(',') }) |
        Select-Object -Unique |
        Where-Object { $PSReminderTag.keys -notContains $_ } |
        ForEach-Object {
            [PSCustomObject]@{
                PSTypeName = 'PSReminderTag'
                Tag        = $_
                Style      = $Null
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

} #close Get-PSReminderTag


