# private module functions

function _NewPSReminder {
    [CmdletBinding()]
    [OutputType('PSReminder')]

    Param(
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('ID')]
        [int32]$EventID,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('Event', 'Name')]
        [String]$EventName,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('Date')]
        [DateTime]$EventDate,
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Comment')]
        [String]$EventComment,
        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Tags,
        [string]$Source
    )
    Process {
        [string[]]$TagArray = $Tags -split ',' | Foreach-Object {$_.Trim()}
        $obj = New-Object -TypeName PSReminder -ArgumentList @($eventID, $EventName, $EventDate, $EventComment,$TagArray)
        $obj.Source = $Source
        $obj
    }
} #close _NewPSReminder

function _NewArchivePSReminder {
    [CmdletBinding()]
    [OutputType('ArchivePSReminder')]

    Param(
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('ID')]
        [int32]$EventID,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('Event', 'Name')]
        [String]$EventName,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('Date')]
        [DateTime]$EventDate,
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Comment')]
        [String]$EventComment,
        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Tags,
        [Parameter(ValueFromPipelineByPropertyName)]
        [DateTime]$ArchivedDate,
        [string]$Source
    )
    Process {
        [string[]]$TagArray = $Tags -split ',' | Foreach-Object {$_.Trim()}
        $obj = New-Object -TypeName ArchivePSReminder -ArgumentList @($eventID, $EventName, $EventDate, $EventComment,$TagArray,$ArchivedDate)
        $obj.Source = $Source
        $obj
    }
} #close _NewPSReminder

#my custom verbose function
function _verbose {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Message,
        [string]$Block = 'PROCESS',
        [string]$Command
    )

    [string]$ANSI =  "`e[48;5;226;38;5;232m"

    $BlockString = $Block.ToUpper().PadRight(7, ' ')
    $Reset = "$([char]27)[0m"
    $ToD = (Get-Date).TimeOfDay
    $AnsiCommand = "$([char]27)$Ansi$($command)"
    $Italic = "$([char]27)[3m"
    #Write-Verbose "[$((Get-Date).TimeOfDay) $BlockString] $([char]27)$Ansi$($command)$([char]27)[0m: $([char]27)[3m$message$([char]27)[0m"
    $msg = '[{0} {1}] {2}{3}-> {4} {5}{3}' -f $Tod, $BlockString, $AnsiCommand, $Reset, $Italic, $Message

    Write-Verbose -Message $msg

}