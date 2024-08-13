# Changelog for PSReminderLite

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [1.0.0] - 2024-08-13

### Added

- Added alias `New-PSReminder` for `Add-PSReminder`.
- Added a command called `Get-PSReminderPreference` and a custom formatting file to display preference variables and tag information.
- Added a hidden property called `ComputerName` to the `PSReminder` and `ArchivePSReminder` objects to capture the computer name.
- Added a hidden property called `Source` to the `PSReminder` and `ArchivePSReminder` objects to capture the path to the source database file.
- Added a module icon.
- Added alias `gprt` for `Get-PSReminderTag`.

### Changed

- Defined `PSReminderDBInfo` as a PowerShell class. Updated `Get-PSReminderDBInfo` to create an instance of the class. This class has a `RefreshInfo()` method that can be used to update a saved object.
- Made the `Age` property on `PSReminderDBInfo` to be a script property.
- Updated `Get-PSReminder` with a parameter set to get unexpired reminders for a given month and year. The default year is the current year.
- Modified `Get-PSReminderDBInformation` to get a count of non-expired reminders
- Modified `Get-PSReminderDBInformation` to be an advanced function and added verbose messaging.
- Modified `Get-PSReminderDBInformation` to keep the database open for all queries. This improves performance by 50%.
- Moved all messaging strings to localized data.
- Updated default formatting to display date using `g` format specifier and right-align the date column. I'd prefer an option to format with leading zeros but it would have to support multiple cultures.
- Updated module manifest private data.
- Documentation corrections.

## [0.5.0] - 2024-07-23

### Added

- Added an `about_psreminderlite` help topic.
- Added function `Import-FromTickleDatabase` to import Tickle items.

### Changed

- Changed the PSReminder object's `Countdown` property from a defined class property to a type extension.
- Updated default table view to use tag highlighting for all columns.
- Modified default formatted view of reminders to auto-size.
- Updated `README.md`

### Fixed

- "Fixed bugs in `Import-PSReminderDatabase`to account for tags.

## 0.4.0 - 2024-07-19

### Added

- Added the $host name to the `Get-AboutPSReminder` output.
- Added auto completers for the `-Tags` parameter of `Add-PSReminder` and `Set-PSReminder`.
- Added tag formatting for Archived events to the formatting ps1xml file.
- Added command `Get-PSReminderTag`.
- Added `Priority` to the default tag list.
- Added Tags auto-completer to `Get-PSReminder`
- Added tag support for Archived events

### Changed

- Updated `Initialize-PSReminderDatabase` to add the `Tags` column to the database tables.

## 0.3.0 - 2024-07-19

### Changed

- Revised `Get-PSReminderDBInformation` to include Author and Comment from the Metadata table.

### Fixed

- Fixed parameter layout in help.

## 0.2.0 - 2024-07-19

### Added

- Added support for Tags. Updated `Add-PSReminder` and `Set-PSReminder` with tag-related parameters. Updated the format file to display tagged items with ANSI formatting stored in a variable called `System.Collections.Hashtable`. Updated preference export to use this variable.
- Added `ArchivedPSReminder` class and updated format file with a custom display for archived items. Added a private function to define an instance of the object."

### Changed

- Updated `Export-PSReminderDatabase` to use `Export-MySqlDB` and save to a JSON file.
- Updated `Import-PSReminderDatabase` to import from the exported JSON file.
- Updated `README`.

## 0.0.1 - 2024-07-18

## Added

- Initial files and module structure.

[Unreleased]: https://github.com/jdhitsolutions/PSReminderLite/compare/v1.0.0..HEAD
[1.0.0]: https://github.com/jdhitsolutions/PSReminderLite/compare/v0.5.0..v1.0.0
