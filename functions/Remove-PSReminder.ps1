Function Remove-PSReminder {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType("None")]
    [Alias("rpsr")]

    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [int32]$ID,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"

        $InvokeParams = @{
            Query       = $null
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Deleting tickle event $ID "
        $InvokeParams.query = "DELETE From EventData where EventID='$ID'"
        if ($PSCmdlet.ShouldProcess("Event ID $ID")) {
            Try {
                Invoke-MySQLiteQuery @InvokeParams
            }
            Catch {
                Throw $_
            }
        } #should process
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
