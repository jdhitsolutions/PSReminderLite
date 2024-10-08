#
# Module manifest for module 'PSReminderLite'
#
@{
    RootModule           = 'PSReminderLite.psm1'
    ModuleVersion        = '1.0.0'
    CompatiblePSEditions = 'Core'
    GUID                 = 'f28fb1d9-ea07-4c22-a160-570fb3c092d8'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2024 JDH Information Technology Solutions, Inc.'
    Description          = 'This is a port of the MyTickle module that uses a SQLite database to store event or reminder information.'
    PowerShellVersion    = '7.4'
    RequiredModules      = @('MySQLite')
    # TypesToProcess = @()
    FormatsToProcess     = @('formats/psreminder.format.ps1xml','formats/psreminderpreference.format.ps1xml')
    FunctionsToExport    = @('Export-PSReminderPreference', 'Initialize-PSReminderDatabase',
        'Add-PSReminder', 'Get-PSReminder', 'Get-PSReminderDBInformation', 'Set-PSReminder',
        'Remove-PSReminder', 'Export-PSReminderDatabase', 'Import-PSReminderDatabase',
        'Move-PSReminder', 'Get-AboutPSReminder', 'Get-PSReminderTag',
        'Import-FromTickleDatabase','Get-PSReminderPreference')
    CmdletsToExport      = @()
    VariablesToExport    = @('PSReminderDefaultDays', 'PSReminderDB', 'PSReminderTable',
        'PSReminderArchiveTable', 'PSReminderTag')
    AliasesToExport      = @('apsr', 'gpsr', 'spsr', 'rpsr', 'Archive-PSReminder', 'gprt','New-PSReminder')
    PrivateData          = @{
        PSData = @{
            Tags                       = @('psreminder', 'reminder', 'sqlite', 'schedule')
            LicenseUri                 = 'https://github.com/jdhitsolutions/PSReminderLite/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/PSReminderLite'
            IconUri                    = 'https://raw.githubusercontent.com/jdhitsolutions/PSReminderLite/main/images/icons8-reminder-85.png'
            ReleaseNotes               = 'https://github.com/jdhitsolutions/PSReminderLite/blob/main/ChangeLog.md'
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @('MySQLite')
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}
