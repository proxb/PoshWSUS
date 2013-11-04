function Deny-PoshWSUSUpdate {
    <#  
    .SYNOPSIS  
        Declines an update on WSUS.
    .DESCRIPTION
        Declines an update on WSUS. Use of the -whatif is advised to be sure you are declining the right patch or patches.
    .PARAMETER InputObject
        Collection of update/s being declined. This must be an object, otherwise it will fail.      
    .PARAMETER Update
        Name of update/s being declined.    
    .NOTES  
        Name: Deny-PoshWSUSUpdate
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE
    Get-PoshWSUSUpdate -update "Exchange 2010" | Deny-PoshWSUSUpdate 

    Description
    -----------  
    This command will decline all updates with 'Exchange 2010' in its metadata.
    .EXAMPLE
    Deny-PoshWSUSUpdate  -Update "Exchange 2010"

    Description
    -----------  
    This command will decline all updates with 'Exchange 2010' in its metadata.
    .EXAMPLE
    $updates = Get-PoshWSUSUpdate -update "Exchange 2010" 
    Deny-PoshWSUSUpdate -InputObject $updates

    Description
    -----------  
    This command will decline all updates with 'Exchange 2010' in its metadata.   
    .EXAMPLE
    Get-PoshWSUSUpdate -update "Exchange 2010" | Deny-PoshWSUSUpdate

    Description
    -----------  
    This command will decline all updates with 'Exchange 2010' in its metadata via the pipeline.    
    #> 
    [cmdletbinding(
    	DefaultParameterSetName = 'collection',
    	ConfirmImpact = 'low',
        SupportsShouldProcess = $True
    )]
        Param(
            [Parameter(
                Mandatory = $True,
                Position = 0,
                ParameterSetName = 'collection',
                ValueFromPipeline = $True)]
                [system.object]$InputObject,                                          
            [Parameter(
                Mandatory = $False,
                Position = 1,
                ParameterSetName = 'string',
                ValueFromPipeline = $False)]
                [string]$Update                                          
                )                       
    Process {
        Switch ($pscmdlet.ParameterSetName) {
            "Collection" {
                Write-Verbose "Using 'Collection' set name"        
                #Change the collection to patches for use in loop
                $patches = $inputobject        
            }
            "String" {
                Write-Verbose "Using 'String' set name"        
                #Gather all updates from given information
                Write-Verbose "Searching for updates"
                $patches = $wsus.SearchUpdates($update)       
            }
        } 
        ForEach ($patch in $patches) {
            #Decline the update
            Write-Verbose "Declining update"                
            If ($pscmdlet.ShouldProcess($Patch.Title,"Decline Update")) {
                $patch.Decline($True) | out-null
                #Print out report of what was declined
                New-Object PSObject -Property @{
                    Patch = $patch.title
                    ApprovalAction = "Declined"
                }
            }         
        }
    }    
}
