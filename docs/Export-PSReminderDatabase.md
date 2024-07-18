---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Export-PSReminderDatabase

## SYNOPSIS

Export the PSReminder database.

## SYNTAX

```yaml
Export-PSReminderDatabase [-Path] <String> [-DatabasePath <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

SQLite doesn't have a backup mechanism like SQL Server. You can use this command to export the reminder database to a JSON file. You can use Import-PSReminderDatabase to restore it.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-PSReminderDatabase c:\temp\psrexport.json
```

Export the database to a JSON file.

## PARAMETERS

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

### -Path

The path and filename for the export JSON file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Import-PSReminderDatabase](Import-PSReminderDatabase.md)
