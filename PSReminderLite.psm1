
#region Main

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName }

#endregion

#region Define module variables

$ExportPath = Join-Path -Path $HOME -ChildPath '.psreminder.json'
If (Test-Path -Path $ExportPath) {
    #use the preference file
    Get-Content -Path $ExportPath | ConvertFrom-Json |
    ForEach-Object {
        if ($_.Value.GetType().Name -ne "PSCustomObject") {
            Set-Variable -Name $_.Name -Value $_.Value -Force
        }
        elseif ($_.name -eq 'PSReminderTag') {
            $Hash = @{}
            $global:t = $_
            $_.Value.PSObject.Properties | ForEach-Object {
                $Hash[$_.Name] = $_.Value
            }
            Set-Variable -Name PSReminderTag -Value $Hash -Force
        }
    }
<#
Get-Content -Path $ExportPath | ConvertFrom-Json |
    ForEach-Object {
        Set-Variable -Name $_.Name -Value $_.Value -Force
    }
#>
}
else {
    #the default number of days to display for Show-TickleEvents
    $PSReminderDefaultDays = 7

    #database defaults
    $PSReminderDB = Join-Path -Path $HOME -ChildPath PSReminder.db
    $PSReminderTable = 'EventData'
    $PSReminderArchiveTable = 'ArchivedEvent'
    #define a default tag list and style settings
    $PSReminderTag = @{
        'Work'     = "`e[38;5;192m"
        'Personal' = "`e[96m"
        'Priority' = "`e[1;3;38;5;199m"
    }
}

If (-Not (Test-Path -Path $PSReminderDB)) {
    Write-Warning "The database file $PSReminderDB does not exist or could not be found. Please run Initialize-PSReminderDatabase to create the database."
}

#endregion

#region Class definitions

Class PSReminder {
    [String]$Event
    [DateTime]$Date
    [String]$Comment
    [int32]$ID
    [string[]]$Tags
    [boolean]$Expired = $False
    hidden [TimeSpan]$Countdown

    #constructor
    PSReminder([int32]$ID, [String]$Event, [DateTime]$Date, [String]$Comment, [String[]]$Tags) {
        $this.ID = $ID
        $this.Event = $Event
        $this.Date = $Date
        $this.Comment = $Comment
        $this.Tags = $Tags
        if ($Date -lt (Get-Date)) {
            $this.Expired = $True
        }
        $ts = $this.Date - (Get-Date)
        if ($ts.TotalMinutes -lt 0) {
            $ts = New-TimeSpan -Minutes 0
        }
        $this.Countdown = $ts
    }
} #close PSReminder class

Class ArchivePSReminder {
    [String]$Event
    [DateTime]$Date
    [String]$Comment
    [int32]$ID
    [string[]]$Tags
    [DateTime]$ArchivedDate

    ArchivePSReminder([int32]$ID, [String]$Event, [DateTime]$Date, [String]$Comment,[String[]]$Tags, [DateTime]$ArchivedDate) {
        $this.ID = $ID
        $this.Event = $Event
        $this.Date = $Date
        $this.Comment = $Comment
        $this.ArchivedDate = $ArchivedDate
        $this.Tags = $Tags
    }
} #close ArchivePSReminder class

Update-TypeData -TypeName PSReminder -DefaultDisplayPropertySet ID, Date, Event, Comment -Force
Update-TypeData -TypeName PSReminder -MemberType AliasProperty -MemberName Name -Value Event -Force

#endregion

#region auto completers

Register-ArgumentCompleter -CommandName Add-PSReminder,Set-PSReminder -ParameterName Tags -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-PSReminderTag | Where-Object { $_.tag -like "$WordToComplete*"} |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_.Tag.Trim(), $_.Tag.Trim(), 'ParameterValue', $_.Tag)
    }
}


#endregion

$export = @{
    Variable = @('PSReminderDefaultDays', 'PSReminderDB', 'PSReminderTable',
        'PSReminderArchiveTable','PSReminderTag')
    Function = @('Export-PSReminderPreference', 'Initialize-PSReminderDatabase',
        'Add-PSReminder', 'Get-PSReminder', 'Get-PSReminderDBInformation', 'Set-PSReminder',
        'Remove-PSReminder', 'Export-PSReminderDatabase', 'Import-PSReminderDatabase',
        'Move-PSReminder', 'Get-AboutPSReminder','Get-PSReminderTag')
    Alias    = @('apsr', 'gpsr', 'spsr', 'rpsr', 'Archive-PSReminder')
}
Export-ModuleMember @export