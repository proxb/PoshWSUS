function Approve-PoshWSUSUpdate {
    <#  
    .SYNOPSIS  
        Approves a WSUS update for a specific group with an optional deadline.
        
    .DESCRIPTION
        Approves a WSUS update for a specific group with an optional deadline.
        
    .PARAMETER InputObject
        Update object that is being approved. 
           
    .PARAMETER Update
        Name of update being approved.
        
    .PARAMETER Group
        Name of group which will receive the update.   
            
    .PARAMETER Deadline
        Optional deadline for client to install patch.
        
    .PARAMETER Action
        Type of approval action to take on update. Accepted values are Install, Approve, Uninstall and NotApproved 
        
    .PARAMETER PassThru
        Display output object of approval action 
         
            
    .NOTES  
        Name: Approve-PoshWSUSUpdate
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Approve-PoshWSUSUpdate -update "KB979906" -Group "Domain Servers" -Action Install

    Description
    ----------- 
    This command will approve all updates with the KnowledgeBase number of KB979906 for the 'Domain Servers' group and
    the action command of 'Install'.
    
    .EXAMPLE  
    Approve-PoshWSUSUpdate -update "KB979906" -Group "Domain Servers" -Action Install -Deadline (get-Date).AddDays(3)

    Description
    ----------- 
    This command will approve all updates with the KnowledgeBase number of KB979906 for the 'Domain Servers' group and
    the action command of 'Install' and sets a deadline for 3 days from when this command is run.
    
    .EXAMPLE  
    Get-PoshWSUSUpdate -Update "KB979906" | Approve-PoshWSUSUpdate -Group "Domain Servers" -Action Install

    Description
    ----------- 
    This command will take the collection of objects from the Get-PoshWSUSUpdate command and then approve all updates for 
    the 'Domain Servers' group and the action command of 'Install'.
           
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
            [ValidateNotNullOrEmpty()]
            [Microsoft.UpdateServices.Internal.BaseApi.Update]$InputObject,     
        [Parameter(
            Mandatory = $True,
            Position = 0,
            ParameterSetName = 'string',
            ValueFromPipeline = $False)]
            [string]$Update,           
        [Parameter(
            Mandatory = $True,
            Position = 1,
            ParameterSetName = '',
            ValueFromPipeline = $False)]
            [ValidateSet("Install", "All", "NotApproved","Uninstall")]
            [Microsoft.UpdateServices.Administration.UpdateApprovalAction]$Action,              
        [Parameter(
            Mandatory = $True,
            Position = 2,
            ParameterSetName = '',
            ValueFromPipeline = $False)]
            [string]$Group,
        [Parameter(
            Mandatory = $False,
            Position = 3,
            ParameterSetName = '',
            ValueFromPipeline = $False)]
            [datetime]$Deadline,
        [Parameter(
            Mandatory = $False,
            Position = 4,
            ParameterSetName = '')]
            [switch]$PassThru                                   
        )
    Begin {       
        #Search for group specified
        Write-Verbose "Searching for group"        
        $targetgroup = $wsus.getcomputertargetgroups() | Where {
            $_.Name -eq $group
        }
        If (-Not $targetgroup) {
            Write-Warning "Group $group does not exist in WSUS!"
            Break
        }       
    }                    
    Process {
        #Perform appropriate action based on Parameter set name
        Switch ($pscmdlet.ParameterSetName) {            
            "collection" {
                Write-Verbose "Using 'Collection' set name"
                #Change the variable that will hold the objects
                $patches = $inputobject    
            }                
            "string" {
                Write-Verbose "Using 'String' set name"
                #Search for updates
                Write-Verbose "Searching for update/s"
                $patches = @($wsus.SearchUpdates($update))
                If ($patches -eq 0) {
                    Write-Warning "Update $update could not be found in WSUS!"
                    Break
                }                     
            }                
        } 
        ForEach ($patch in $patches) {
            #Accept any licenses, if required
            If ($patch.RequiresLicenseAgreementAcceptance) {
                #Approve License
                Write-Verbose ("Accepting license aggreement for {0}" -f $Patch.title)
                $Patch.AcceptLicenseAgreement()
            }
            #Determine if Deadline is required
            If ($PSBoundParameters['deadline']) {
                Write-Verbose "Approving update with a deadline."
                If ($pscmdlet.ShouldProcess($($patch.title))) {
                    #Create the computer target group
                    $Data = $patch.Approve($action,$targetgroup,$deadline)
                    #Print out report of what was approved
                }        
            } Else {    
                #Approve the patch
                Write-Verbose "Approving update without a deadline."                              
                If ($pscmdlet.ShouldProcess($($patch.title))) {
                    #Create the computer target group
                    $Data = $patch.Approve($action,$targetgroup)
                    #Print out report of what was approved               
                }
            }
            If ($PSBoundParameters['PassThru']) {
                Write-Output $Data
            }
        }
    }                
} 
