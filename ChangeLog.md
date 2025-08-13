# Changelog for PSReminderLite

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [1.1.0] - 2025-08-13

### Added

- Added style variables `PSReminderAlertStyle`,`PSReminderExpiredStyle`, and `PSReminderWarningStyle`. These are used to format reminders due in 24 or 48 hours, and expired reminders. Updated `Export-PSReminderPreference` to export these variables. Updated `Get-PSReminderPreference` to display these variables. Updated custom formatting file for preference display.
- Added command `Open-PSReminderLiteHelp` to launch the module's help PDF.
- Added alias `New-PSReminder` for `Add-PSReminder`.
- Added a command called `Get-PSReminderPreference` and a custom formatting file to display preference variables and tag information.
- Added a hidden property called `ComputerName` to the `PSReminder` and `ArchivePSReminder` objects to capture the computer name.
- Added a hidden property called `Source` to the `PSReminder` and `ArchivePSReminder` objects to capture the path to the source database file.
- Added a module icon.
- Added alias `gprt` for `Get-PSReminderTag`.

### Changed

- Revised `Remove-PSReminder` to support deleting archived events.[[Issue #1](https://github.com/jdhitsolutions/PSReminderLite/issues/1)]
- Expanded verbose messaging.
- Updated root module to dynamically retrieve the module version number.
- Added argument completers for `Tag` parameters.
- Defined `PSReminderDBInfo` as a PowerShell class. Updated `Get-PSReminderDBInfo` to create an instance of the class. This class has a `RefreshInfo()` method that can be used to update a saved object.
- Made the `Age` property on `PSReminderDBInfo` to be a script property.
- Updated `Get-PSReminder` with a parameter set to get unexpired reminders for a given month and year. The default year is the current year.
- Modified `Get-PSReminderDBInformation` to get a count of non-expired reminders
- Modified `Get-PSReminderDBInformation` to be an advanced function and added verbose messaging.
- Modified `Get-PSReminderDBInformation` to keep the database open for all queries. This improves performance by 50%.
- Moved all messaging strings to localized data.
- Updated default formatting to display date using `g` format specifier and right-align the date and ID columns. I'd prefer an option to format the date with leading zeros but it would have to support multiple cultures. I am open to PRs if someone wants to tackle that.
- Updated module manifest private data.
- Documentation corrections.
- Help updates

## 1.0.0 - 2024-08-13

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


[Unreleased]: https://github.com/jdhitsolutions/PSReminderLite/compare/v1.1.0..HEAD
[1.1.0]: https://github.com/jdhitsolutions/PSReminderLite/compare/v1.0.0..v1.1.0
