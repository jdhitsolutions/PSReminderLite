---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version: https://jdhitsolutions.com/yourls/307d69
schema: 2.0.0
---

# Remove-PSReminder

## SYNOPSIS

Delete a PSReminder from the database.

## SYNTAX

```yaml
Remove-PSReminder [-ID] <Int32> -Category <String> [-DatabasePath <String>]
[-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Events in the PSReminder database remain, even though they may not be displayed by default. Normally, you will archive expired events. However, you can delete entries with this command. You will need to specify the table or category from which you want to delete the event. If you specify the wrong category, the command will complete successfully but will not delete anything.

You might want to export items before deleting them:

Get-PSReminder -Archived | where tags -contains holiday | ConvertTo-Json | Out-File d:\temp\archived-holidays.json

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-PSReminder -id 11 -Category Reminder
```

Delete an event from the database by ID number. This will NOT archive it but permanently delete it from the database.

### Example 2

```powershell
PS C:\> Get-PSReminder -Archived | Select-Object -first 5 | Remove-PSReminder -Category Archived -Verbose
VERBOSE: [14:56:51.4386945 BEGIN  ] Remove-PSReminder->  Starting module function Remove-PSReminder
VERBOSE: [14:56:51.4389814 BEGIN  ] Remove-PSReminder->  Running the command with PowerShell version 7.5.2
VERBOSE: [14:56:51.6022072 PROCESS] Get-PSReminder->  Deleting PSReminder event 105 from ArchivedEvent
VERBOSE: [14:56:51.6029188 PROCESS] Get-PSReminder->  Deleting PSReminder event 101 from ArchivedEvent
VERBOSE: [14:56:51.6036329 PROCESS] Get-PSReminder->  Deleting PSReminder event 123 from ArchivedEvent
VERBOSE: [14:56:51.6041176 PROCESS] Get-PSReminder->  Deleting PSReminder event 102 from ArchivedEvent
VERBOSE: [14:56:51.6046435 PROCESS] Get-PSReminder->  Deleting PSReminder event 124 from ArchivedEvent
VERBOSE: [14:56:51.6051111 END    ] Get-PSReminder->  Ending module function Remove-PSReminder
```

Permanently delete the first five archived reminders from the database. You must specify the appropriate category. If you specify the wrong category, the command will complete successfully but will not delete anything.

## PARAMETERS

### -ID

The ID number of the event you want to delete.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DatabasePath

The path to the SQLite database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $PSReminderDB
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category

Specify the reminder category: Archived, Expired, or Reminder.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### None

## NOTES

This command has an alias of rpsr.

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Add-PSReminder](Add-PSReminder.md)

[Set-PSReminder](Set-PSReminder.md)

[Move-PSReminder](Move-PSReminder.md)
