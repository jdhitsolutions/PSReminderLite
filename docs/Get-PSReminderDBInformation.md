---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Get-PSReminderDBInformation

## SYNOPSIS

Get information about the PSReminderEventDB database.

## SYNTAX

```yaml
Get-PSReminderDBInformation [[-DatabasePath] <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will display information about the PSReminder database.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminderDBInformation

   Database: C:\Users\Jeff\PSReminder.db [84KB]

Age         Reminders Expired Archived
---         --------- ------- --------
00.20:40:17        25      12      807
```

### Example 2

```powershell
PS C:\> Get-PSReminderDBInformation | Select-Object *

Age           : 20:42:20.3258389
Name          : PSReminder.db
Path          : C:\Users\Jeff\PSReminder.db
PageSize      : 4096
PageCount     : 21
Reminders     : 25
Expired       : 12
Archived      : 807
Size          : 86016
Created       : 7/23/2024 3:59:03 PM
Modified      : 7/24/2024 1:53:00 PM
Author        : THINKX1-JH\Jeff
Comment       : Imported from a Tickle database
Encoding      : UTF-8
SQLiteVersion : 3.42.0
Date          : 7/25/2024 10:35:21 AM
Computername  : PROSPERO
```

The information object has additional properties not seen in the default display.
The Age property is a script property and will always update.
The object also has a RefreshInfo() method you can invoke to refresh a saved object.

## PARAMETERS

### -DatabasePath

The path to the SQLite database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: $PSReminderDB
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSReminderDBInfo

## NOTES

## RELATED LINKS

[Get-AboutPSReminder](Get-AboutPSReminder.md)

[Initialize-PSReminderDatabase](Initialize-PSReminderDatabase.md)
