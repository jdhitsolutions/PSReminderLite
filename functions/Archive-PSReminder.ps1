Function Move-PSReminder {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    [alias('Archive-PSReminder')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [int32]$Id,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing EventID $ID"
        #always try to get the event
        $r = Invoke-MySQLiteQuery "Select * from $PSReminderTable where EventID='$ID'" -Path $PSReminderDB -WhatIf:$False
        $evt = "[{0}] {1}" -f $r.EventID, $r.EventName
        if ($r -AND $PScmdlet.ShouldProcess($evt,"Archiving Event")) {

        }

    } #process

    End {

        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Move-PSReminder