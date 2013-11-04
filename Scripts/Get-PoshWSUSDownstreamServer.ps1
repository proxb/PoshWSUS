function Get-PoshWSUSDownstreamServer {
    <#  
    .SYNOPSIS  
        Retrieves all WSUS downstream servers.
    .DESCRIPTION
        Retrieves all WSUS downstream servers.
    .NOTES  
        Name: Get-PoshWSUSDownstreamServer
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE  
    Get-PoshWSUSDownstreamServer

    Description
    ----------- 
    This command will display a list of all of the downstream WSUS servers.
           
    #> 
    [cmdletbinding()]  
    Param () 
    Process {
        #Gather all child servers in WSUS    
        $wsus.GetDownstreamServers()
    }
}
