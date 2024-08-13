Function Set-PSReminder {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('None', 'PSReminder')]
    [Alias('spsr')]

    Param(
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName,
            Mandatory
        )]
        [int32]$ID,
        [Parameter(HelpMessage = 'The new name of the event')]
        [alias('Name')]
        [String]$EventName,
        [Parameter(HelpMessage = 'The new date of the event')]
        [DateTime]$Date,
        [Parameter(HelpMessage = 'The new comment for the event')]
        [String]$Comment,
        [Parameter(HelpMessage = 'Specify an optional array of tags')]
        [String[]]$Tags,
        [Parameter(HelpMessage = 'Return the updated event')]
        [Switch]$PassThru,
        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB

    )
    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))

        $update = @'
UPDATE EventData
SET {0} Where EventID='{1}'
'@

        $InvokeParams = @{
            Query       = $null
            Path        = $DatabasePath
            ErrorAction = 'Stop'
        }

    } #begin

    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        _verbose $($strings.Processing -f $ID)
        $cols = @()
        if ($EventName) {
            $cols += "EventName='$EventName'"
        }
        if ($Comment) {
            $cols += "EventComment='$Comment'"
        }
        if ($Date) {
            $isoDate = $Date.ToString('yyyy-MM-dd HH:mm:ss')
            $cols += "EventDate='$isoDate'"
        }
        if ($Tags) {
            $tagArray = $Tags -join ','
            $cols += "Tags='$tagArray'"
        }

        $data = $cols -join ','

        $query = $update -f $data, $ID
        $InvokeParams.query = $query
        if ($PSCmdlet.ShouldProcess($query)) {
            Invoke-MySQLiteQuery @InvokeParams
            if ($PassThru) {
                Get-PSReminder -Id $ID
            }
        }
    } #process

    End {
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end
}
