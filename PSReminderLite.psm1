
#region Main

Get-ChildItem -path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName}

#endregion

#region Define module variables

$ExportPath = Join-Path -Path $HOME -ChildPath '.psreminder.json'
If (Test-Path -Path $ExportPath) {
    #use the preference file
    Get-Content -Path $ExportPath | ConvertFrom-Json |
    ForEach-Object {
        Set-Variable -name $_.Name -value $_.Value -Force
    }
}
else {
    #the default number of days to display for Show-TickleEvents
    $PSReminderDefaultDays = 7

    #database defaults
    $PSReminderDB = Join-Path -path $HOME -ChildPath PSReminder.db
    $PSReminderTable = 'EventData'
    $PSReminderArchiveTable = 'ArchivedEvent'
}

If (-Not (Test-Path -Path $PSReminderDB)) {
    Write-Warning "The database file $PSReminderDB does not exist or could not be found. Please run Initialize-PSReminderDatabase to create the database."
}

#endregion

#region Class definition

Class PSReminder {
    [String]$Event
    [DateTime]$Date
    [String]$Comment
    [int32]$ID
    [boolean]$Expired = $False
    hidden [TimeSpan]$Countdown

    #constructor
    PSReminder([int32]$ID, [String]$Event, [DateTime]$Date, [String]$Comment) {
        $this.ID = $ID
        $this.Event = $Event
        $this.Date = $Date
        $this.Comment = $Comment
        if ($Date -lt (Get-Date)) {
            $this.Expired = $True
        }
        $ts = $this.Date - (Get-Date)
        if ($ts.TotalMinutes -lt 0) {
            $ts = New-TimeSpan -Minutes 0
        }
        $this.Countdown = $ts
    }
} #close class

Update-TypeData -TypeName PSReminder -DefaultDisplayPropertySet ID, Date, Event, Comment -Force
Update-TypeData -TypeName PSReminder -MemberType AliasProperty -MemberName Name -Value Event -force

#endregion

$export = @{
    Variable = @('PSReminderDefaultDays', 'PSReminderDB', 'PSReminderTable',
    'PSReminderArchiveTable')
    Function = @('Export-PSReminderPreference','Initialize-PSReminderDatabase',
    'Add-PSReminder','Get-PSReminder','Get-PSReminderDBInformation','Set-PSReminder',
    'Remove-PSReminder','Export-PSReminderDatabase','Import-PSReminderDatabase',
    'Move-PSReminder','Get-AboutPSReminder')
    Alias    = @('apsr','gpsr','spsr','rpsr','Archive-PSReminder')
}
Export-ModuleMember @export