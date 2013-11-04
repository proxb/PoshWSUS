function Get-PoshWSUSSyncProgress {
    <#  
    .SYNOPSIS  
        Displays the current progress of a WSUS synchronization.
        
    .DESCRIPTION
        Displays the current progress of a WSUS synchronization.   
          
    .NOTES  
        Name: Get-PoshWSUSSyncProgress
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE
    Get-PoshWSUSSyncProgress 

    Description
    -----------
    This command will show you the current status of the WSUS sync.
           
    #> 
    [cmdletbinding()]  
    Param ()
    Begin {    
        $sub = $wsus.GetSubscription()    
    }
    Process {
        #Gather all child servers in WSUS    
        $sub.GetSynchronizationProgress() 
    }   
}
