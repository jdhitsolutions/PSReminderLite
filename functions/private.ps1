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
        [String]$EventComment
    )
    Process {
        New-Object -TypeName PSReminder -ArgumentList @($eventID, $EventName, $EventDate, $EventComment)
    }
} #close _NewPSReminder

