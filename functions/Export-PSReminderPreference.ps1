Function Export-PSReminderPreference {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None','System.IO.FileInfo')]
    Param(
        [Parameter(HelpMessage = "Write the preference file to the pipeline")]

        [Switch]$Passthru
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
        $PSReminderVariables = @('PSReminderDefaultDays', 'PSReminderDB', 'PSReminderTable',
        'PSReminderArchiveTable','PSReminderTag')
    } #begin

    Process {
        #$ExportPath is a module scoped variable defined in the root module
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Exporting PSReminder preferences to $ExportPath"
        Get-Variable $PSReminderVariables |
        Select-Object Name,Value |
        ConvertTo-Json |
        Out-File -FilePath $ExportPath -Force

        if ((-Not $WhatIfPreference) -AND $Passthru) {
            Get-Item -Path $ExportPath
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Export-TicklePreference {