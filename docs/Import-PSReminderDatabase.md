---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Import-PSReminderDatabase

## SYNOPSIS

Import PSReminder data from a Clixml file.

## SYNTAX

```yaml
Import-PSReminderDatabase [-Path] <String> [-DatabasePath <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

If you export a PSReminder database with the Export-PSReminderDatabase command, you can re-import it into a new or different SQLite database file with this command.

## EXAMPLES

### Example 1

```powershell
PS C:\> Import-PSReminderDatabase c:\temp\PSReminderExport.xml
```

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

The path and filename for the exported XML file. It is assumed this file was created with Export-PSReminderDatabase.

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

[Export-PSReminderDatabase](Export-PSReminderDatabase.md)