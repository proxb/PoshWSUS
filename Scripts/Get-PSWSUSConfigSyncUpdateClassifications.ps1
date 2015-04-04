function Get-PSWSUSConfigSyncUpdateClassifications {
    <#
    .Synopsis
       The Get-PSWSUSSyncUpdateClassifications cmdlet gets the list of Windows Server Update Services (WSUS) classifications that will be synchronized.
    
    .DESCRIPTION
       ??????? ????????
    
    .NOTES  
        Name: Get-PSWSUSConfigSyncUpdateCategories
        Author: Dubinsky Evgeny
        DateCreated: 10MAY2013

    .EXAMPLE
       Get-PSWSUSConfigSyncUpdateClassifications

       Description
       -----------
       This command gets classification that sync with  Windows Server Update Services (WSUS).

    .LINK
        http://blog.itstuff.in.ua/?p=62#Get-PSWSUSConfigSyncUpdateClassifications
    #>
    [CmdletBinding(DefaultParameterSetName = 'Null')]
    Param()

    Begin {}
    Process
    {
        if ($wsus)
        {
            $wsus.GetSubscription().GetUpdateClassifications()
        }
        else
        {
            Write-Warning "Use Connect-PSWSUSServer for establish connection with your Windows Update Server"
            Break
        }
    }
    End{}
}
