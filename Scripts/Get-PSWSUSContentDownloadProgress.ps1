function Get-PSWSUSContentDownloadProgress {
    <#  
    .SYNOPSIS  
        Retrieves the progress of currently downloading updates. Displayed in bytes downloaded.
        
    .DESCRIPTION
        Retrieves the progress of currently downloading updates. Displayed in bytes downloaded.
   
    .NOTES  
        Name: Get-PSWSUSContentDownloadProgress
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Get-PSWSUSContentDownloadProgress

    Description
    ----------- 
    This command will display the current progress of the content download.
           
    #> 
    [cmdletbinding()]  
    Param ()
    Process {
        #Gather all child servers in WSUS    
        $wsus.GetContentDownloadProgress()       
    }
}
