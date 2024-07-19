# PSReminderLite

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSReminderLite.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSReminderLite/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSReminderLite.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSReminderLite/)

This module is a port of the [MyTickle](https://github.com/jdhitsolutions/myTickle) module. The original module used an instance of SQLServer Express to provide a database of event reminders. This version uses SQLite to provide the same functionality. When you install the module from the PowerShell Gallery, it will also install the [MySqlite](https://github.com/jdhitsolutions/MySQLite) module if it isn't already installed.

```powershell
Install-Module PSReminderLite
```

OR

```powershell
Install-PSResource PSReminderLite
```

The module requires a 64-bit PowerShell 7 platform.

>*The module has not been tested extensively on non-windows platforms*.

## Module Commands

- [Add-PSReminder](docs/Add-PSReminder.md)
- [Export-PSReminderDatabase](docs/Export-PSReminderDatabase.md)
- [Export-PSReminderPreference](docs/Export-PSReminderPreference.md)
- [Get-AboutPSReminder](docs/Get-AboutPSReminder.md)
- [Get-PSReminder](docs/Get-PSReminder.md)
- [Get-PSReminderDBInformation](docs/Get-PSReminderDBInformation.md)
- [Get-PSReminderTag](docs/Get-PSReminderTag.md)
- [Import-PSReminderDatabase](docs/Import-PSReminderDatabase.md)
- [Initialize-PSReminderDatabase](docs/Initialize-PSReminderDatabase.md)
- [Move-PSReminder](docs/Move-PSReminder.md)
- [Remove-PSReminder](docs/Remove-PSReminder.md)
- [Set-PSReminder](docs/Set-PSReminder.md)

## Setup the Database

## Module Preferences

### Tags

### Exporting Preferences

## Adding a Reminder

## Getting Reminders

## Modifying a Reminder

## Archiving Reminders

## Database Management

### Exporting the Database

### Importing Data

## Migrating from MyTickle

## Roadmap

There aren't many enhancements planned for this module. If there is something you would like to see or if you have questions or comments, please use the repository's Discussions section. For bugs and other problems, please file an issue.
