#localized string data for verbose messaging, errors, and warnings.

ConvertFrom-StringData @'
    ParameterSet = Detected parameter set {0}
    Ending = Ending module function {0}
    PSVersion = Running the command with PowerShell version {0}
    Starting = Starting module function {0}
    Adding = Adding event "{0}"
    Processing = Processing EventID {0}
    Deleting = Deleting PSReminder event -f {0}
    DBExists = A file was already found at {0}. Please remove it or specify a different path. Initialization aborted.
    CreateDB = Creating SQLite database {0}
    CreateTables = Creating SQLite database tables
    CreateEventData = Create tables {0} and {1}
    ExportPref = Exporting PSReminder preferences to {0}
    ExportDB = Exporting PSReminder database from {0} to {1}
    GetDBInfo = Getting database information from {0}
    ByID = Using PSReminder ID {0}
    ByName = Using PSReminder EventName {0}
    ByDays = For the next {0} days
    ByExpiration = Using the PSReminder expiration date
    ByArchive = Getting data from {0}
    ByAll = Getting all non-archived events.
    ByTag = Using PSReminder tag {0}
    ImportFrom = Importing events from {0}
    Found = Found {0} matching events
    GetTags = Getting PSReminder Tags from $PSReminderTag
    GetUndefinedTags = Getting defined tags from the database not in $PSReminderTag
    ImportData = Importing database data from {0}
    ImportComplete = Data import complete.
    InitComplete = PSReminder Database initialization complete.
    ImportTD = Importing TickleData
    ImportTDPath = Importing Tickle data from {0}
    ImportCount = Importing {0{ events
    ImportTickle = Importing Tickle event [{0}] {1}
    ArchiveTickle = Archiving Tickle event  [{0}] {1}
    InvokeQuery = Invoking SQLite query {0}
    OpenDB = Opening the database connection
    CloseDB = Closing the database connection
    GetVer = Getting version information for related modules and dependencies
    GettingPreference = Getting PSReminder preferences
    Default = Default
    ByMonth = Getting unexpired events for {0}/{1}
'@