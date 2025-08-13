---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version: https://jdhitsolutions.com/yourls/2db9d2
schema: 2.0.0
---

# Get-PSReminderPreference

## SYNOPSIS

Get PSReminder preferences

## SYNTAX

```yaml
Get-PSReminderPreference [<CommonParameters>]
```

## DESCRIPTION

Preferences for the PSReminderLite module are stored as global variables. Run this command to get a report of all preferences. These settings are defined as variables. You can change them like any other variable in PowerShell.

If you customize the preferences, you can export them to a JSON file using `Export-PSReminderPreference`. If the file exists, it will be used the next time you import the module to define your preference variables.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminderPreference

PSReminderPreference Settings

   PSReminderDB: C:\Users\Jeff\PSReminder.db

PSReminderDefaultDays PSReminderTable PSReminderArchiveTable
--------------------- --------------- ----------------------
         14              EventData        ArchivedEvent

PSReminderStyle

  Name                     Style
  PSReminderAlertStyle     `e[91m
  PSReminderWarningStyle   `e[93m
  PSReminderExpiredStyle   `e[9;38;5;171m

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

### Example 2

```powershell
PS C:\> $p = Get-PSReminderPreference
PS C:\> $p.showStyle()

Name                   Style
----                   -----
PSReminderAlertStyle   `e[91m
PSReminderWarningStyle `e[93m
PSReminderExpiredStyle `e[9;38;5;171m
```

You can use the `showStyle()` method to display just the style information. The output will for styled with the corresponding ANSI sequence.

### Example 3

```powershell
PS C:\> $p.showTags()

Tag      Style
---      -----
Event    `e[38;5;87m
Priority `e[1;3;38;5;199m
Holiday  `e[38;5;225m
Testing  `e[3;92m
Personal `e[94m
travel   `e[38;5;141m
Family   `e[38;5;156m
Work     `e[38;5;192m
```

Or use the `showTags()` method to display just the tag information. The output will for styled with the corresponding ANSI sequence.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSReminderPreference

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Export-PSReminderPreference](Export-PSReminderPreference.md)
