#region Main

# used for culture debugging
# write-host "Importing with culture $(Get-Culture)"

if ((Get-Culture).Name -match '\w+') {
    Import-LocalizedData -BindingVariable strings
}
else {
    #force using En-US if no culture found, which might happen on non-Windows systems.
    Import-LocalizedData -BindingVariable strings -FileName PSReminderLite.psd1 -BaseDirectory $PSScriptRoot\en-us
}

#dot-source module functions
Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object { . $_.FullName }

#endregion

#region Define module variables

$ExportPath = Join-Path -Path $HOME -ChildPath '.psreminder.json'
If (Test-Path -Path $ExportPath) {
    #use the preference file
    Get-Content -Path $ExportPath | ConvertFrom-Json |
    ForEach-Object {
        if ($_.Value.GetType().Name -ne 'PSCustomObject') {
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
    #add a hidden property that captures the database path
    hidden [string]$Source
    #add a hidden property to capture the computer name'
    hidden [string]$ComputerName = [System.Environment]::MachineName

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
    }
} #close PSReminder class

Class ArchivePSReminder {
    [String]$Event
    [DateTime]$Date
    [String]$Comment
    [int32]$ID
    [string[]]$Tags
    [DateTime]$ArchivedDate
    #add a hidden property that captures the database path
    hidden [string]$Source
    #add a hidden property to capture the computer name'
    hidden [string]$ComputerName = [System.Environment]::MachineName

    ArchivePSReminder([int32]$ID, [String]$Event, [DateTime]$Date, [String]$Comment, [String[]]$Tags, [DateTime]$ArchivedDate) {
        $this.ID = $ID
        $this.Event = $Event
        $this.Date = $Date
        $this.Comment = $Comment
        $this.ArchivedDate = $ArchivedDate
        $this.Tags = $Tags
    }
} #close ArchivePSReminder class

Class PSReminderDBInfo {
    [string]$Name
    [string]$Path
    [int32]$PageSize
    [int32]$PageCount
    [int32]$Reminders
    [int32]$Expired
    [int32]$Archived
    [int32]$Size
    [DateTime]$Created
    [DateTime]$Modified
    [string]$Author
    [string]$Comment
    [string]$Encoding
    [version]$SQLiteVersion
    [DateTime]$Date = (Get-Date)
    [string]$Computername = [System.Environment]::MachineName

    #methods
    hidden [void]GetDBInfo () {
        Try {
            _verbose ($script:strings.GetDBInfo -f $this.Path)
            $r = Get-MySQLiteDB -Path $this.Path -ErrorAction Stop
            $this.Name = Split-Path -Path $r.path -Leaf
            $this.PageSize = $r.PageSize
            $this.PageCount = $r.PageCount
            $this.Size = $r.Size
            $this.Created = $r.Created
            $this.Modified = $r.Modified
            $this.Encoding = $r.Encoding
            $this.SQLiteVersion = $r.SQLiteVersion
        }
        Catch {
            Throw $_
        }
    }

    [PSReminderDBInfo]RefreshInfo () {
        _verbose $script:strings.OpenDB
        $this.GetDBInfo()

        $conn = Open-MySQLiteDB -Path $this.Path
        $InvokeParams = @{
            Connection = $conn
            KeepAlive  = $True
            Query      = ''
        }
        $InvokeParams.Query = 'select Author,comment from metadata'
        _verbose ($script:strings.InvokeQuery -f $InvokeParams.Query)
        $meta = Invoke-MySQLiteQuery @InvokeParams
        $this.Author = $meta.Author
        $this.Comment = $meta.Comment

        $now = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        $InvokeParams.Query = "Select count(*) AS Count from $global:PSReminderTable Where EventDate>= '$now'"
        _verbose ($script:strings.InvokeQuery -f $InvokeParams.Query)
        $this.Reminders = $(Invoke-MySQLiteQuery @InvokeParams).count

        _verbose ($script:strings.InvokeQuery -f $InvokeParams.Query)
        $InvokeParams.Query = "Select count(*) AS Count from $global:PSReminderArchiveTable"
        $this.Archived = (Invoke-MySQLiteQuery @InvokeParams).Count

        _verbose ($script:strings.InvokeQuery -f $InvokeParams.Query)
        $InvokeParams.Query = "Select count(*) AS Count from $global:PSReminderTable Where EventDate< '$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))'"
        $this.Expired = (Invoke-MySQLiteQuery @InvokeParams).count

        If ($conn.state -eq 'Open') {
            _verbose $script:strings.CloseDB
            $conn.Close()
        }
        return $this
    }

    #Constructor
    PSReminderDBInfo([string]$DatabasePath) {
        $this.Path = $DatabasePath
        $this.RefreshInfo()
    }

} #close PSReminderDBInfo class

Class PSReminderPreference {
    [string]$PSReminderDB = $global:PSReminderDB
    [string]$PSReminderDefaultDays = $global:PSReminderDefaultDays
    [string]$PSReminderTable = $global:PSReminderTable
    [string]$PSReminderArchiveTable = $global:PSReminderArchiveTable
    [hashtable]$PSReminderTag = $global:PSReminderTag

    [object]ShowTags () {
        $r = $this.PSReminderTag.GetEnumerator() | Foreach-Object {
            $stringValue = $_.Value.Replace("$([char]27)", '`e')
            [PSCustomObject]@{
                PSTypeName = 'PSReminderTag'
                Tag        = $_.Key
                Style      = '{0}{1}{2}' -f $($_.Value), $stringValue, $("`e[0m")
            }
        }
        return $r
    }
} #close PSReminderPreference class

#custom type extensions. This might be exported to a ps1xml file in a future release
Update-TypeData -TypeName PSReminder -DefaultDisplayPropertySet ID, Date, Event, Comment -Force
Update-TypeData -TypeName PSReminder -MemberType AliasProperty -MemberName Name -Value Event -Force
Update-TypeData -TypeName PSReminder -MemberType ScriptProperty -MemberName Countdown -Value {
    $ts = $this.Date - (Get-Date)
    if ($ts.TotalMinutes -lt 0) {
        $ts = New-TimeSpan -Minutes 0
    }
    $ts
} -Force

Update-TypeData -TypeName PSReminderDBInfo -MemberType ScriptProperty -MemberName Age -Value {
    $ts = New-TimeSpan -Start $this.Modified -End (Get-Date)
    $ts
} -Force
#endregion

#region auto completers

Register-ArgumentCompleter -CommandName Add-PSReminder, Set-PSReminder -ParameterName Tags -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    (Get-PSReminderTag).Where({ $_.Tag -like "$WordToComplete*" }).ForEach({ [System.Management.Automation.CompletionResult]::new($_.Tag.Trim(), $_.Tag.Trim(), 'ParameterValue', $_.Tag) })
}

Register-ArgumentCompleter -CommandName Get-PSReminder -ParameterName Tag -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    (Get-PSReminderTag).Where({ $_.Tag -like "$WordToComplete*" }).ForEach({ [System.Management.Automation.CompletionResult]::new($_.Tag.Trim(), $_.Tag.Trim(), 'ParameterValue', $_.Tag) })
}

#endregion

$export = @{
    Variable = @('PSReminderDefaultDays', 'PSReminderDB', 'PSReminderTable',
        'PSReminderArchiveTable', 'PSReminderTag')
    Function = @('Export-PSReminderPreference', 'Initialize-PSReminderDatabase',
        'Add-PSReminder', 'Get-PSReminder', 'Get-PSReminderDBInformation', 'Set-PSReminder',
        'Remove-PSReminder', 'Export-PSReminderDatabase', 'Import-PSReminderDatabase',
        'Move-PSReminder', 'Get-AboutPSReminder', 'Get-PSReminderTag',
        'Import-FromTickleDatabase','Get-PSReminderPreference')
    Alias    = @('apsr', 'gpsr', 'spsr', 'rpsr', 'Archive-PSReminder', 'gprt','New-PSReminder')
}

Export-ModuleMember @export