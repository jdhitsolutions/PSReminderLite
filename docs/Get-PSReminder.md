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
Get-PSReminder [-Next <Int32>] [-DatabasePath <String>]  [<CommonParameters>]
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

### Tag

```yaml
Get-PSReminder [-Tag <String>] [-DatabasePath <String>] [<CommonParameters>]
```

### Archived

```yaml
Get-PSReminder [-Archived] [-DatabasePath <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will query the PSReminder database and return matching events. The parameters are used to fine-tune the query and should be self-explanatory.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReminder

ID   Event                               Comment              Date
--   -----                               -------              ----
19   Migration Planning meeting          prep docs            07/19/2024 02:28:…
23   Vendor phone call                   include Gladys       07/19/2024 13:30:…
1    Haircut                                                  7/24/2024 8:30:00…
```

The default is to get reminders due in the next number of days defined in $PSReminderDefaultDays. The output will be color code. Events due within 24 hours will be red, and events due within 48 hours will be yellow.

### Example 2

```powershell
PS C:\> Get-PSReminder -id 19 | select *

Name    : Migration Planning meeting
Event   : Migration Planning meeting
Date    : 7/19/2024 2:28:06 AM
Comment : prep docs
ID      : 19
Expired : False
```

The object has extended properties defined.

### Example 3

```powershell
PS C:\> Get-PSReminder -All | Format-Table -view date

   Month: Jul 2024

ID     Event                     Comment        Date
--     -----                     -------        ----
19     Migration Planning meeti… prep docs      7/19/2024 2:28:06 AM
23     Vendor phone call         include Gladys 7/19/2024 1:30:00 PM
1      Haircut                                  7/24/2024 8:30:00 AM
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

### System.String

## OUTPUTS

### PSReminder

## NOTES

## RELATED LINKS

[Add-PSReminder](Add-PSReminder.md)

[Set-PSReminder](Set-PSReminder.md)

[Move-PSReminder](Move-PSReminder.md)
