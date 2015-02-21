function Get-PSWSUSUpdateApproval {
    <#  
    .SYNOPSIS  
        Lists approval summary for each update.
        
    .DESCRIPTION
        Lists approval summary for each update. If an update has been declined,it will be ignored.
        
    .PARAMETER Update
        Name of the update to get approval summary from. Can be a string of any kind.
        
    .PARAMETER UpdateScope
        Update scope to use to search for updates and retrive approval summary for.
        
    .NOTES  
        Name: Get-PSWSUSUpdateApproval
        Author: Boe Prox
        DateCreated: 08Dec2011 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE   
    Get-PSWSUSUpdateApproval -Update 2546951 

    UpdateTitle          GoLiveTime                Deadline                  AdministratorName    TargetGroup
    -----------          ----------                --------                  -----------------    -----------
    Microsoft SQL Ser... 11/8/2011 2:18:01 PM      12/31/9999 11:59:59 PM    rivendell\administrator    TESTGROUP
    Microsoft SQL Ser... 11/8/2011 2:18:01 PM      12/31/9999 11:59:59 PM    rivendell\administrator    TESTGROUP1
    Microsoft SQL Ser... 11/8/2011 2:18:00 PM      12/31/9999 11:59:59 PM    rivendell\administrator    All Computers    

    Description
    -----------    
    Lists the approval summary for update 2546951
    
    .EXAMPLE
    $updatescope = New-PSWSUSUpdateScope -FromArrivalDate "11/01/2011"
    Get-PSWSUSUpdateApproval -UpdateScope $updatescope
    
    UpdateTitle          GoLiveTime                Deadline                  AdministratorName    TargetGroup
    -----------          ----------                --------                  -----------------    -----------
    Security Update f... 11/10/2011 6:01:15 AM     12/31/9999 11:59:59 PM    WUS Server           Unassigned Computers
    Security Update f... 11/10/2011 6:01:16 AM     12/31/9999 11:59:59 PM    WUS Server           TESTGROUP
    Security Update f... 11/10/2011 6:01:16 AM     12/31/9999 11:59:59 PM    WUS Server           GROUP1
    Security Update f... 11/10/2011 6:01:16 AM     12/31/9999 11:59:59 PM    WUS Server           Exchange
    Security Update f... 11/10/2011 6:01:17 AM     12/31/9999 11:59:59 PM    WUS Server           Server2008    
    ...
    
    Description
    -----------   
    Lists all updates approval summaries for updates approved from 11/01/2011 up to the present day
     
    #> 
    [cmdletbinding(
    	ConfirmImpact = 'low',
        DefaultParameterSetName = 'Update'
    )]
    Param(
        [Parameter(Position = 0, ParameterSetName = 'Update',ValueFromPipeline=$True)]
        [system.object]$Update, 
        [Parameter(Position = 0, ParameterSetName = 'UpdateScope')]
        [Microsoft.UpdateServices.Administration.UpdateScope]$UpdateScope                                                                                         
    )
    Begin {                
        $ErrorActionPreference = 'stop'
    }
    Process {
        If ($PSBoundParameters['Update']) {
            If ($update -is [Microsoft.UpdateServices.Internal.BaseApi.Update]) {
                $patches = $update
            } Else {
                Write-Verbose ("Gathering update data")
                $patches = Get-PSWSUSUpdate -update $Update
            }
        } ElseIf ($PSBoundParameters['UpdateScope']) {
            Write-Verbose ("Gathering update data via update scope")
            $patches = Get-PSWSUSUpdate -UpdateScope $UpdateScope
        } Else {
            #Create default update scope to use for update search
            $patches = Get-PSWSUSUpdate -UpdateScope (New-PSWSUSUpdateScope)
        }
        ForEach ($patch in $patches) {
            $patch.GetUpdateApprovals()
        }
        
    }  
    End {
        $ErrorActionPreference = 'continue'    
    } 
}
