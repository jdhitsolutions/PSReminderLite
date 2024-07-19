Function Get-PSReminderDBInformation {
    [CmdletBinding()]
    [OutputType('PSReminderDBInfo')]
    Param(

        [Parameter(HelpMessage = 'The path to the SQLite database')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path $_ })]
        [string]$DatabasePath = $PSReminderDB
    )

    Try {
        $r = Get-MySQLiteDB -Path $DatabasePath -ErrorAction Stop
    }
    Catch {
        Throw $_
    }

    #get information from the metadata table
    $meta = invoke-MySQLiteQuery -Path $PSReminderDB -Query "select Author,comment from metadata"

    #create a composite custom object
    [PSCustomObject]@{
        PSTypename    = 'PSReminderDBInfo'
        Name          = Split-Path -Path $r.path -Leaf
        Path          = $r.path
        PageSize      = $r.PageSize
        PageCount     = $r.PageCount
        Reminders     = (Invoke-MySQLiteQuery 'Select count(*) AS Count from EventData' -database $DatabasePath).Count
        Expired       = (Invoke-MySQLiteQuery "Select count(*) AS Count from EventData Where EventDate< '$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))'" -database $DatabasePath).Count
        Archived      = (Invoke-MySQLiteQuery 'Select count(*) AS Count from ArchivedEvent' -database $DatabasePath).Count
        Size          = $r.Size
        Created       = $r.Created
        Modified      = $r.Modified
        Author        = $meta.Author
        Comment       = $meta.Comment
        Encoding      = $r.Encoding
        SQLiteVersion = $r.SQLiteVersion
        Age           = (New-TimeSpan -Start $r.Modified -End (Get-Date))
        Date          = Get-Date
        Computername  = [System.Environment]::MachineName
    }

}
