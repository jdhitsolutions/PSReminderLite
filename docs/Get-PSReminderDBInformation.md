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

   Database: C:\Users\Jeff\PSReminder.db [20KB]

Age         Reminders Expired Archived
---         --------- ------- --------
00.01:47:55        25       3        2
```

### Example 2

```powershell
PS C:\> Get-PSReminderDBInformation | Select-Object *

Name          : PSReminder.db
Path          : C:\Users\Jeff\PSReminder.db
PageSize      : 4096
PageCount     : 5
Reminders     : 25
Expired       : 3
Archived      : 2
Size          : 20480
Created       : 7/18/2024 9:31:22 AM
Modified      : 7/19/2024 11:09:39 AM
Author        : THINKX1-JH\Jeff
Comment       : PSReminderLite database
Encoding      : UTF-8
SQLiteVersion : 3.42.0
Age           : 01:49:09.5592668
Date          : 7/19/2024 12:58:48 PM
Computername  : THINKX1-JH
```

The information object has additional properties not seen in the default display.

## PARAMETERS

### -DatabasePath

The path to the SQLite database

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
