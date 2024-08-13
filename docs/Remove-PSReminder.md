---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Remove-PSReminder

## SYNOPSIS

Delete a PSReminder from the database.

## SYNTAX

```yaml
Remove-PSReminder [-ID] <Int32> [-DatabasePath <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Events in the PSReminder database remain, even though they may not be displayed by default. Normally, you can archive expired events. However, you can also delete entries with this command.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-PSReminder -id 11
```

Delete an event from the database by ID number. This will NOT archive it but permanently delete it from the database.

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

The path to the SQLite database

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### None

## NOTES

This command has an alias of rpsr.

## RELATED LINKS

[Add-PSReminder](Add-PSReminder.md)

[Set-PSReminder](Set-PSReminder.md)

[Move-PSReminder](Move-PSReminder.md)
