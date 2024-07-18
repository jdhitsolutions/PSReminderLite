---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Get-AboutPSReminder

## SYNOPSIS

Get module information.

## SYNTAX

```yaml
Get-AboutPSReminder [<CommonParameters>]
```

## DESCRIPTION

This is a simple command to provide summary information about the PSReminder module. This can be used for troubleshooting purposes.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AboutPSReminder

ModuleName    : PSReminderLite
Version       : 0.1.0
MySQLite      : 0.13.0
SQLiteVersion : 3.42.0
PSVersion     : 7.5.0-preview.3
Platform      : Win32NT
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### AboutPSReminder

## NOTES

## RELATED LINKS

[Get-PSReminderDbInformation](Get-PSReminderDbInformation.md)