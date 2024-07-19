# Changelog for PSReminderLite

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [0.4.0] - 2024-07-19

### Added

- Added the $host name to the `Get-AboutPSReminder` output.
- Added auto completers for the `-Tags` parameter of `Add-PSReminder` and `Set-PSReminder`.
- Added tag formatting for Archived events to the formatting ps1xml file.
- Added command `Get-PSReminderTag`.
- Added `Priority` to the default tag list.
- Added tag support for Archived events

### Changed

- Updated `Initialize-PSReminderDatabase` to add the `Tags` column to the database tables.

## [0.3.0] - 2024-07-19

### Changed

- Revised `Get-PSReminderDBInformation` to include Author and Comment from the Metadata table.

### Fixed

- Fixed parameter layout in help.

## [0.2.0] - 2024-07-19

### Added

- Added support for Tags. Updated `Add-PSReminder` and `Set-PSReminder` with tag-related parameters. Updated the format file to display tagged items with ANSI formatting stored in a variable called `System.Collections.Hashtable`. Updated preference export to use this variable.
- Added `ArchivedPSReminder` class and updated format file with a custom display for archived items. Added a private function to define an instance of the object."

### Changed

- Updated `Export-PSReminderDatabase` to use `Export-MySqlDB` and save to a JSON file.
- Updated `Import-PSReminderDatabase` to import from the exported JSON file.
- Updated `README`.

## [0.0.1] - 2024-07-18

## Added

- Initial files and module structure.

[Unreleased]: ENTER-URL-HERE
[0.4.0]: ENTER-URL-HERE
[0.3.0]: ENTER-URL-HERE
[0.2.0]: ENTER-URL-HERE