function Get-PoshWSUSGroup {
    <#  
    .SYNOPSIS  
        Retrieves specific WSUS target group.
    .DESCRIPTION
        Retrieves specific WSUS target group.
    .PARAMETER Name
        Name of group to search for. No wildcards allowed. 
    .PARAMETER Id
        GUID of group to search for. No wildcards allowed.       
    .NOTES  
        Name: Get-PoshWSUSGroups
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE  
    Get-PoshWSUSGroup -name "Domain Servers"

    Description
    ----------- 
    This command will search for the group and display the information for Domain Servers"

    .EXAMPLE  
    Get-PoshWSUSGroup -ID "0b5ba818-021e-4238-8098-7245b0f90557"

    Description
    ----------- 
    This command will search for the group and display the information for the WSUS 
    group guid 0b5ba818-021e-4238-8098-7245b0f90557"
    
    .EXAMPLE
    Get-PoshWSUSGroup

    Description
    -----------
    This command will list out all of the WSUS Target groups and their respective IDs.    
           
    #> 
    [cmdletbinding(
        DefaultParameterSetName = 'Name'
    )]
        Param(
            [Parameter(
                Position = 0,ParameterSetName = 'Name',
                ValueFromPipeline = $False)]
                [string]$Name,
            [Parameter(
                Position = 0,ParameterSetName = 'Id',
                ValueFromPipeline = $False)]
                [string]$Id            
            )
    Process {            
        If ($PSBoundParameters['Name']) {
            $wsus.GetComputerTargetGroups() | Where {
                    $_.name -eq $name
                }
        } ElseIf ($PSBoundParameters['Id']) {
            $wsus.GetComputerTargetGroup($Id)
        } Else {
            $wsus.GetComputerTargetGroups()
        }
    }
} 
