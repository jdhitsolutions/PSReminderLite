---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Get-PSReminderTag

## SYNOPSIS

Get defined PSReminder tags

## SYNTAX

```yaml
Get-PSReminderTag [<CommonParameters>]
```

## DESCRIPTION

This command makes it easier to view the $PSReminderTag variable. The output of the command will show the ANSI escape sequence formatted with the sequence. The output will show NULL styles for tags defined in the database as part of saved event reminders, but not in the $PSReminderTag variable.

There are no commands to add or remove tags. The $PSReminderTag variable is a hashtable that you can modify using PowerShell. If you want to make the changes persistent, use Export-PSreminderPreference to save the changes.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminderTag

Tag      Style
---      -----
Personal `e[94m
Event    `e[33m
Testing  `e[3;92m
Priority `e[1;3;38;5;199m
Work     `e[38;5;156m
travel
```

The style will be formatted with the corresponding style. In this example, the travel tag was found in the database as part of one or more event reminders, but not in the $PSReminderTag variable.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSReminderTag

## NOTES

This command has an alias of gprt.

## RELATED LINKS

[Get-PSReminderPreference](Get-PSReminderPreference.md)

[Export-PSReminderPreference](Export-PSReminderPreference.md)
