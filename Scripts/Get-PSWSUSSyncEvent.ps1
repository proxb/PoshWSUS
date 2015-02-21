function Get-PSWSUSSyncEvent {
    <#  
    .SYNOPSIS  
        Retrieves all WSUS synchronization events.
    .DESCRIPTION
        Retrieves all WSUS synchronization events from the WSUS server.  
    .NOTES  
        Name: Get-PSWSUSSyncEvent 
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE
    Get-PSWSUSSyncEvent 

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
