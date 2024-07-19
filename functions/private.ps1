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
        [String]$Tags
    )
    Process {
        [string[]]$TagArray = $Tags -split ',' | Foreach-Object {$_.Trim()}
        New-Object -TypeName PSReminder -ArgumentList @($eventID, $EventName, $EventDate, $EventComment,$TagArray)
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
        [DateTime]$ArchivedDate
    )
    Process {
        [string[]]$TagArray = $Tags -split ',' | Foreach-Object {$_.Trim()}
        New-Object -TypeName ArchivePSReminder -ArgumentList @($eventID, $EventName, $EventDate, $EventComment,$TagArray,$ArchivedDate)
    }
} #close _NewPSReminder