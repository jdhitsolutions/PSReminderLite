---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Add-PSReminder

## SYNOPSIS

Add a PSReminder to the database.

## SYNTAX

```yaml
Add-PSReminder [-EventName] <String> [-Date] <DateTime> [[-Comment] <String>] [-Tags <String[]>]
 [-DatabasePath <String>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Add a PSReminder to the database. The command will use the global PSReminder variables, although you can override the server instance parameter. It is strongly recommended that you avoid using special characters, especially apostrophes and commas, in your event name or comment.

## EXAMPLES

### Example 1

```powershell
PS C:\> Add-PSReminder -EventName "HR Review" -Date "9/1/2024 4:00PM" -Tags "Work"
```

Add a reminder to the database.

## PARAMETERS

### -Comment

Specify an optional comment or description for the event.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -Date

Enter the date and time for the event

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: EventDate

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EventName

Enter the name of the event

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Show the event that was added to the database.

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

### -Tags

Specify an optional array of tags

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.String

### System.DateTime

## OUTPUTS

### None

### PSReminder

## NOTES

## RELATED LINKS

[Get-PSReminder](Get-PSReminder.md)

[Set-PSReminder](Set-PSReminder.md)
