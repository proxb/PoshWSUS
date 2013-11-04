function Stop-PoshWSUSUpdateDownload {
    <#  
    .SYNOPSIS  
        Stops update download after approval.
    .DESCRIPTION
        Stops update download after approval.
    .PARAMETER update
        Name of update to cancel download.       
    .NOTES  
        Name: Stop-PoshWSUSUpdateDownload
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE  
    Stop-PoshWSUSUpdateDownload -update "KB965896"

    Description
    ----------- 
    This command will cancel the download of update KB956896.       
    #> 
    [cmdletbinding(
    	ConfirmImpact = 'low',
        SupportsShouldProcess = $True
    )]
        Param(
            [Parameter(
                Mandatory = $True,
                Position = 0,
                ValueFromPipeline = $True)]
                [string]$update                                          
                ) 
    Begin {
        #Gather all updates from given information
        Write-Verbose "Searching for updates"
        $patches = $wsus.SearchUpdates($update)
    }            
    Process {
        If ($patches) {
            ForEach ($patch in $patches) {
                Write-Verbose "Cancelling update download"                
                If ($pscmdlet.ShouldProcess($($patch.title))) {
                    $patch.CancelDownload()
                    "$($patch.title) download has been cancelled."
                }         
            }
        } Else {
            Write-Warning "No patches found that need downloading cancelled."
        }        
    }    
} 
