---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Import-FromTickleDatabase

## SYNOPSIS

Import data from a Tickle database

## SYNTAX

```yaml
Import-FromTickleDatabase [[-Path] <String>] [-DatabasePath <String>] [-Comment <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

If you have been using the MyTickle module and want to import those events in a PSReminder database, run Export-TickleDatabase to export to a Clixml file. Then use this command to import the Clixml file into a new PSReminder database. This command will fail if a PSReminder database already exists. It is assumed you are starting a new PSReminder database from an import of Tickle events.

## EXAMPLES

### Example 1

```powershell
PS C:\> Import-FromTickleDatabase -path c:\temp\TickleDb.xml
```

Archived events will be imported into the archived table. You can then tag items and archive expired events.

## PARAMETERS

### -Path

The path to the exported Tickle database file.
It should be an XML file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

### -Comment

Specify an optional comment for the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Imported from a Tickle database
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

### None

## OUTPUTS

### Nsone

## NOTES

## RELATED LINKS
