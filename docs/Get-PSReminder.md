---
external help file: PSReminderLite-help.xml
Module Name: PSReminderLite
online version:
schema: 2.0.0
---

# Get-PSReminder

## SYNOPSIS

Get one or more PSReminder entries.

## SYNTAX

### Days (Default)

```yaml
Get-PSReminder [-Next <Int32>] [-DatabasePath <String>] [<CommonParameters>]
```

### ID

```yaml
Get-PSReminder [-Id <Int32>] [-DatabasePath <String>] [<CommonParameters>]
```

### Name

```yaml
Get-PSReminder [-EventName <String>] [-DatabasePath <String>] [<CommonParameters>]
```

### All

```yaml
Get-PSReminder [-All] [-DatabasePath <String>] [<CommonParameters>]
```

### Expired

```yaml
Get-PSReminder [-Expired] [-DatabasePath <String>] [<CommonParameters>]
```

### Archived

```yaml
Get-PSReminder [-Archived] [-DatabasePath <String>] [<CommonParameters>]
```

### Month

```yaml
Get-PSReminder [-Month <Int32>] [-Year <Int32>]  [-DatabasePath <String>] [<CommonParameters>]
```

### Tag

```yaml
Get-PSReminder [-Tag <String>] [-DatabasePath <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will query the PSReminder database and return matching events. The parameters are used to fine-tune the query and should be self-explanatory.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminder


ID   Event                      Comment                 Date    Countdown
--   -----                      -------                 ----    ---------
19   Migration Planning meeting prep docs  8/7/2024 12:00 PM     00:52:30
21   Vendor phone call                     8/11/2024 7:30 PM   4.08:22:30
2    Haircut                    Joe        8/13/2024 9:30 AM   5.22:22:30
```

The default is to get reminders due in the next number of days defined in $PSReminderDefaultDays. The output will be color code. Events due within 24 hours will be red, and events due within 48 hours will be yellow.

### Example 2

```powershell
PS C:\> Get-PSReminder -id 19 | Select-Object *

Name    : Migration Planning meeting
Event   : Migration Planning meeting
Date    : 8/7/2024 12:00:00 PM
Comment : prep docs
ID      : 19
Expired : False
```

The object has extended properties defined.

### Example 3

```powershell
PS C:\> Get-PSReminder -All | Format-Table -view date

   Month: Aug 2024

   <events>

   Month: Sep 2024

   <events>
...
```

The module includes a custom formatting view.

## PARAMETERS

### -All

Show all events in the EventData table. This will include expired events.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archived

Show all events from the ArchivedEvent table.

```yaml
Type: SwitchParameter
Parameter Sets: Archived
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventName

The name of an event to search for.

```yaml
Type: String
Parameter Sets: Name
Aliases: Name

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Expired

Show expired events.

```yaml
Type: SwitchParameter
Parameter Sets: Expired
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Select an event by its ID number.

```yaml
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Next

Find events scheduled for the next number of days as defined by $PSReminderDefaultDays.

```yaml
Type: Int32
Parameter Sets: Days
Aliases: days

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag

Select reminders by a tag. Wildcards are supported.

```yaml
Type: String
Parameter Sets: Tag
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Month

Select unexpired reminders by month.

```yaml
Type: Int32
Parameter Sets: Month
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Year

Select the year for unexpired reminders by month. The default is the current year.

```yaml
Type: Int32
Parameter Sets: Month
Aliases:

Required: False
Position: Named
Default value: Current year
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

### System.String

## OUTPUTS

### PSReminder

## NOTES

This command has an alias of gpsr.

## RELATED LINKS

[Add-PSReminder](Add-PSReminder.md)

[Set-PSReminder](Set-PSReminder.md)

[Move-PSReminder](Move-PSReminder.md)
