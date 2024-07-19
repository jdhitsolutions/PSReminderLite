Function Add-PSReminder {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None', 'PSReminder')]
    [Alias('apsr')]

    Param(
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the name of the event'
        )]
        [Alias('Name')]
        [String]$EventName,
        [Parameter(
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the date and time for the event'
        )]
        [ValidateScript( {
            If ($_ -gt (Get-Date)) {
                $True
            }
            else {
                Throw 'You must enter a future date and time.'
            }
        })]
        [Alias("EventDate")]
        [DateTime]$Date,
        [Parameter(
            Position = 2,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter an optional comment'
        )]
        [String]$Comment,

        [Parameter(
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specify an optional array of tags'
        )]
        [String[]]$Tags,

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB,

        [Switch]$PassThru
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
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Adding event '$EventName'"
        #events with apostrophes will have them stripped off
        $theEvent = $EventName.replace("'", '')

        #The date must for formatted as yyyy-MM-dd HH:mm:ss
        $ISODate = $Date.ToString('yyyy-MM-dd HH:mm:ss')
        [string]$TagString = $Tags -join ","
        $InvokeParams.query = "INSERT INTO EventData (EventDate,EventName,EventComment,Tags) VALUES ('$ISODate','$theEvent','$Comment','$TagString')"

        $short = "[$ISODate] $Event"
        if ($PSCmdlet.ShouldProcess($short)) {
            Try {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] $($InvokeParams.query)"
                Invoke-MySQLiteQuery @InvokeParams
            } #try
            Catch {
                throw $_
            }

            if ($PassThru) {
                $query = 'Select * from EventData Order by EventID Desc Limit 1'
                $InvokeParams.query = $query
                Invoke-MySQLiteQuery @InvokeParams | _NewPSReminder
            } #if PassThru
        } #if should process
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
