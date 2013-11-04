function Get-PoshWSUSClientGroupMembership {
    <#  
    .SYNOPSIS  
        Lists all Target Groups that a client is a member of in WSUS.
        
    .DESCRIPTION
        Lists all Target Groups that a client is a member of in WSUS.
        
    .PARAMETER Computer
        Name of the client to check group membership.
        
    .PARAMETER InputObject
        Computer object being used to check group membership.   
          
    .NOTES  
        Name: Get-PoshWSUSClientGroupMembership
        Author: Boe Prox
        DateCreated: 12NOV2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Get-PoshWSUSClientGroupMembership -computer "server1"

    Description
    -----------      
    This command will retrieve the group membership/s of 'server1'. 
    
    .EXAMPLE  
    Get-PoshWSUSClient -computer "server1" | Get-PoshWSUSClientGroupMembership

    Description
    -----------      
    This command will retrieve the group membership/s of 'server1'. 
    
    .EXAMPLE  
    Get-PoshWSUSClient -computer "servers" | Get-PoshWSUSClientGroupMembership

    Description
    -----------      
    This command will retrieve the group membership/s of each server. 
           
    #> 
    [cmdletbinding(
    	DefaultParameterSetName = 'collection' 
    )]
        Param(
            [Parameter(
                Mandatory = $True,
                Position = 0,
                ParameterSetName = 'string',
                ValueFromPipeline = $True)]
                [string]$Computer,
            [Parameter(            
                Mandatory = $True,
                Position = 0,
                ParameterSetName = 'collection',
                ValueFromPipeline = $True)]
                [system.object]
                [ValidateNotNullOrEmpty()]
                $InputObject                                              
                )   
    Process {             
        Switch ($pscmdlet.ParameterSetName) {        
           "string" {
                Write-Verbose "String parameter"
                #Retrieve computer in WSUS
                Try { 
                    Write-Verbose "Searching for computer"     
                    $client = Get-PoshWSUSClient -Computer $Computer
                } Catch {
                    Write-Error "Unable to retrieve $($computer) from database."
                } 
            }
            "Collection" {
                Write-Verbose "Collection parameter"
                $client = $inputobject
            }
        } 
        #List group membership of client
        $client | ForEach {
            $Data = $_.GetComputerTargetGroups()
            $data | Add-Member -MemberType NoteProperty -Name FullDomainName -Value $_.fulldomainname -PassThru 
        }
    }
}
