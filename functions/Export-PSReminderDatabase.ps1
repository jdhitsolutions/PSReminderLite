#TODO Export Archive Table
Function Export-PSReminderDatabase {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None')]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = 'The path and filename for the export xml file.'
        )]
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
            Query       = "Select * from $PSReminderTable"
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Exporting database $DatabasePath to $Path "
        if ($PSCmdlet.ShouldProcess($Path,"Exporting database $DatabasePath")) {
            Try {
                Invoke-MySQLiteQuery @InvokeParams | Export-Clixml -Path $Path
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
