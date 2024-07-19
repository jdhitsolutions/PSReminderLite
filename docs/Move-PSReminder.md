---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Move-PSReminder

## SYNOPSIS

Archive an expired PSReminder.

## SYNTAX

```yaml
Move-PSReminder [-Id] <Int32> [-DatabasePath <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Expired events will remain in the primary table. Use this command to move expired events to the ArchivedEvent table. If you want to automate this process, add the command

Get-PSReminder -Expired | Archive-PSReminder

to your PowerShell profile. This command has an alias of Archive-PSReminder.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminder -Expired | Move-PSReminder
```

Archive all expired events.

## PARAMETERS

### -Id

Specify an event ID to archive.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

## RELATED LINKS

[Get-PSReminder](Get-PSReminder.md)

[Set-PSReminder](Set-PSReminder.md)
