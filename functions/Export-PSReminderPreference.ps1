Function Export-PSReminderPreference {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None', 'System.IO.FileInfo')]
    Param(
        [Parameter(HelpMessage = 'Write the preference file to the pipeline')]

        [Switch]$Passthru
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))
        $PSReminderVariables = @('PSReminderDefaultDays', 'PSReminderDB', 'PSReminderTable',
            'PSReminderArchiveTable', 'PSReminderTag')
    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        #$ExportPath is a module scoped variable defined in the root module
        _verbose $($strings.ExportPref -f $ExportPath)
        Get-Variable $PSReminderVariables |
        Select-Object Name, Value |
        ConvertTo-Json |
        Out-File -FilePath $ExportPath -Force

        if ((-Not $WhatIfPreference) -AND $Passthru) {
            Get-Item -Path $ExportPath
        }

    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

} #close function
