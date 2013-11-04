function Get-PoshWSUSStatus {
    <#  
    .SYNOPSIS  
        Retrieves a list of all updates and their statuses along with computer statuses.
    .DESCRIPTION
        Retrieves a list of all updates and their statuses along with computer statuses.   
    .NOTES  
        Name: Get-PoshWSUSStatus
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE 
    Get-PoshWSUSStatus 

    Description
    -----------
    This command will display the status of the WSUS server along with update statuses.
           
    #> 
    [cmdletbinding()]  
    Param () 
    Process {
        $wsus.getstatus()      
    }
} 
