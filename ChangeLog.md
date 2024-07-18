# Changelog for PSReminderLite

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]
### Added
- Added `ArchivedPSReminder` class and updated format file with a custom display for archived items. Also added a private function to define an instance of the object."
- Initial files and module structure.

### Changed
- Updated `Export-PSReminderDatabase` to use `Export-MySqlDB` and save to a JSON file.
- Updated `Import-PSReminderDatabase` to import from the exported JSON file.
- Updated `README`.

