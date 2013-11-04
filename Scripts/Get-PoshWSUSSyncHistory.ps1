function Get-PoshWSUSSyncHistory {
    <#  
    .SYNOPSIS  
        Retrieves the synchronization history of the WSUS server.
    .DESCRIPTION
        Retrieves the synchronization history of the WSUS server.    
    .NOTES  
        Name: Get-PoshWSUSSyncHistory 
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE
    Get-PoshWSUSSyncHistory

    Description
    -----------
    This command will list out the entire synchronization history of the WSUS server.  
           
    #> 
    [cmdletbinding()]  
    Param () 
    Begin {
        $sub = $wsus.GetSubscription()
    }
    Process {
        $sub.GetSynchronizationHistory()      
    }
} 
