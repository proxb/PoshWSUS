Function Get-PoshWSUSUpdateClassification {
    <#  
    .SYNOPSIS  
        Lists all update classifications under WSUS.
        
    .DESCRIPTION
        Lists all update classifications under WSUS.
        
    .NOTES  
        Name: Get-PoshWSUSUpdateClassification
        Author: Boe Prox
        DateCreated: 24JAN2011 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE 
    Get-PoshWSUSUpdateClassification

    Description
    -----------  
    This command will display all update classifications available under WSUS.
    #> 
    [cmdletbinding()]  
    Param()
    Process {
        $wsus.GetUpdateClassifications()        
    }
}
