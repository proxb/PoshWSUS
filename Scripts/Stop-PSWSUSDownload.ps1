function Stop-PSWSUSDownload {
    <#  
    .SYNOPSIS  
        Cancels all current WSUS downloads.
    .DESCRIPTION
        Cancels all current WSUS downloads.      
    .NOTES  
        Name: Stop-PSWSUSDownload
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE 
    Stop-PSWSUSDownload

    Description
    -----------  
    This command will stop all updates being downloaded to the WSUS server.
           
    #> 
    [cmdletbinding()]
    Param()
    Process { 
        #Cancel all downloads running on WSUS       
        If ($pscmdlet.ShouldProcess($($wsus.name))) {
            $wsus.CancelAllDownloads()
            "Downloads have been cancelled on {0}." -f $wsus.name
        }
    }
}
