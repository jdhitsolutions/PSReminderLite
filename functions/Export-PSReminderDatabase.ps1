#TODO Export Archive Table
Function Export-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The path and filename for the export JSON file.'
        )]
        [ValidatePattern('\.json$')]
        [String]$Path,

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
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Exporting database $DatabasePath to $Path "
        if ($PSCmdlet.ShouldProcess($Path,"Exporting database $DatabasePath")) {
            Try {
                Export-MySQLiteDB -Destination $Path -Path $DatabasePath -ErrorAction Stop
            }
            Catch {
                throw $_
            }
        } #should process

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

}
