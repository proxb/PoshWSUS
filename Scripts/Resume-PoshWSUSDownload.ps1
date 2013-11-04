function Resume-PoshWSUSDownload {
    <#  
    .SYNOPSIS  
        Resumes all current WSUS downloads.
    .DESCRIPTION
        Resumes all current WSUS downloads that had been cancelled.
    .NOTES  
        Name: Resume-PoshWSUSDownloads
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE 
    Resume-PoshWSUSDownload

    Description
    ----------- 
    This command will resume the downloading of updates to the WSUS server. 
           
    #> 
    [cmdletbinding()]
        Param() 
    Process {    
        #Resume all downloads running on WSUS       
        If ($pscmdlet.ShouldProcess($($wsus.name))) {
            $wsus.ResumeAllDownloads()
            "Downloads have been resumed on {0}." -f $wsus.name
        }
    }
}
