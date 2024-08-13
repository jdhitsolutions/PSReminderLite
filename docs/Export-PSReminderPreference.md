---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Export-PSReminderPreference

## SYNOPSIS

Export PSReminder variables.

## SYNTAX

```yaml
Export-PSReminderPreference [-Passthru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

If you customize the PSReminder preference variables, such as the number of default days, instead of setting the value in your profile, you can export the variables to a JSON file stored in $HOME. When importing the module, the JSON file will be imported if found. Otherwise, the module will use the default values.

If you remove this module you will need to manually delete the .psreminder.json file from $HOME.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-PSReminderPreference
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

### -Passthru

Write the preference file to the pipeline

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

### None

## OUTPUTS

### None

### System.IO.FileInfo

## NOTES

## RELATED LINKS

[Get-PSReminderPreference](Get-PSReminderPreference.md)
