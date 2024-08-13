Function Get-PSReminderPreference {
    [cmdletbinding()]
    [OutputType('PSReminderPreference')]
    Param()

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose $($strings.Starting -f $($MyInvocation.MyCommand))
        _verbose $($strings.PSVersion -f $($PSVersionTable.PSVersion))
    } #begin

    Process {
        _verbose $strings.GettingPreference
        [PSReminderPreference]::new()

    } #process

    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $($strings.Ending -f $($MyInvocation.MyCommand))
    } #end

} #close Get-PSReminderPreference {