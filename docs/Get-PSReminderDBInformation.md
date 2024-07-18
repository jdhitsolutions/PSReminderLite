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
00.00:11:24        25       4        1
```

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
