---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Get-PSReminderPreference

## SYNOPSIS

Get all PSReminder preferences

## SYNTAX

```yaml
Get-PSReminderPreference [<CommonParameters>]
```

## DESCRIPTION

Preferences for the PSReminderLite module are stored as global variables. Run this command to get a report of all preferences.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminderPreference

PSReminderPreference Settings

   PSReminderDB: C:\Users\Jeff\PSReminder.db

PSReminderDefaultDays PSReminderTable PSReminderArchiveTable
--------------------- --------------- ----------------------
         14              EventData        ArchivedEvent

PSReminderTags

  Tag            Style
  Priority       `e[1;3;38;5;199m
  Testing        `e[3;92m
  Personal       `e[94m
  Work           `e[38;5;156m
  travel         `e[38;5;141m
  Event          `e[38;5;87m
  Holiday        `e[38;5;225m

```

The Style output will be formatted with the corresponding ANSI sequence.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSReminderPreference

## NOTES

## RELATED LINKS

[Export-PSReminderPreference](Export-PSReminderPreference.md)
