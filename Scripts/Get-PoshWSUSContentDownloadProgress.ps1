function Get-PoshWSUSContentDownloadProgress {
    <#  
    .SYNOPSIS  
        Retrieves the progress of currently downloading updates. Displayed in bytes downloaded.
        
    .DESCRIPTION
        Retrieves the progress of currently downloading updates. Displayed in bytes downloaded.
   
    .NOTES  
        Name: Get-PoshWSUSContentDownloadProgress
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Get-PoshWSUSContentDownloadProgress

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
