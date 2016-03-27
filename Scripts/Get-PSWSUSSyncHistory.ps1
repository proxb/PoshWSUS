function Get-PSWSUSSyncHistory {
    <#  
    .SYNOPSIS  
        Retrieves the synchronization history of the WSUS server.
    .DESCRIPTION
        Retrieves the synchronization history of the WSUS server.    
    .NOTES  
        Name: Get-PSWSUSSyncHistory 
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE
    Get-PSWSUSSyncHistory

    Description
    -----------
    This command will list out the entire synchronization history of the WSUS server.  
           
    #> 
    [cmdletbinding()]  
    Param () 
    $Subscription = $wsus.GetSubscription()
    $Subscription.GetSynchronizationHistory()     
} 
