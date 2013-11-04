function Get-PoshWSUSEvent {
    <#  
    .SYNOPSIS  
        Retrieves all WSUS events.
    .DESCRIPTION
        Retrieves all WSUS events from the WSUS server.  
    .NOTES  
        Name: Get-PoshWSUSEvent
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE
    Get-PoshWSUSEvent  

    Description
    -----------
    This command will show you all of the WSUS events.
           
    #> 
    [cmdletbinding()]  
    Param () 
    Begin {
        $sub = $wsus.GetSubscription()
    }
    Process {
        $sub.GetEventHistory()      
    }
}
