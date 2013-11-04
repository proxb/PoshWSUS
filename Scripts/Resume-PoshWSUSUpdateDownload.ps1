function Resume-PoshWSUSUpdateDownload {
    <#  
    .SYNOPSIS  
        Resumes previously cancelled update download after approval.
        
    .DESCRIPTION
        Resumes previously cancelled update download after approval.
        
    .PARAMETER Update
        Name of cancelled update download to resume download.    
           
    .NOTES  
        Name: Resume-PoshWSUSUpdateDownload
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Resume-PoshWSUSUpdateDownload -update "KB965896"

    Description
    ----------- 
    This command will resume the download of update KB956896 that was previously cancelled.       
    #> 
    [cmdletbinding(
    	DefaultParameterSetName = 'update',
    	ConfirmImpact = 'low',
        SupportsShouldProcess = $True
    )]
    Param(
        [Parameter(
            Mandatory = $True,
            Position = 0,
            ParameterSetName = 'update',
            ValueFromPipeline = $True)]
            [string]$Update                                          
            ) 
    Begin {
        #Gather all updates from given information
        Write-Verbose "Searching for updates"
        $patches = $wsus.SearchUpdates($update)
    }                
    Process {
        If ($patches) {
            ForEach ($patch in $patches) {
                Write-Verbose "Resuming update download"                
                If ($pscmdlet.ShouldProcess($($patch.title))) {
                    $patch.ResumeDownload()
                    "$($patch.title) download has been resumed."
                }         
            }
        } Else {
            Write-Warning "No patches found needing to resume download!"
        }        
    }    
} 
