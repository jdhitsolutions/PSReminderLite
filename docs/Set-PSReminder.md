---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Set-PSReminder

## SYNOPSIS

Modify a PSReminder.

## SYNTAX

```yaml
Set-PSReminder [-ID] <Int32> [-EventName <String>] [-Date <DateTime>] [-Comment <String>] [-PassThru] [-DatabasePath <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to update or modify an existing PSReminder. This command will use the PSReminder variables for its defaults.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-PSReminder -ID 11 -Comment "Room 404" -date "8/18/2024 2:00PM"
```

Update the comment and date for the event with ID 11.

## PARAMETERS

### -Comment

The new comment for the event.

```yaml
Type: String
Parameter Sets: column
Aliases:

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

### -Date

The new date for the event.

```yaml
Type: DateTime
Parameter Sets: column
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventName

The new name for the event.

```yaml
Type: String
Parameter Sets: column
Aliases: Name

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID

The event ID. This is used to identify the event to update.

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

### -PassThru

Write the updated event to the pipeline.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### None

### PSReminder

## NOTES

## RELATED LINKS

[Get-PSReminder](Get-PSReminder.md)

[Moving-PSReminder](Move-PSReminder.md)

[Remove-PSReminder](Remove-PSReminder.md)
