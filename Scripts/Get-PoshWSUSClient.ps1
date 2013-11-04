function Get-PoshWSUSClient {
    <#  
    .SYNOPSIS  
        Retrieves information about a WSUS client.
        
    .DESCRIPTION
        Retrieves information about a WSUS client.
        
    .PARAMETER Computer
        Name of the client to search for. Accepts a partial name. If left blank, then all clients displayed
        
    .NOTES  
        Name: Get-PoshWSUSClient
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Get-PoshWSUSClient -computer "server1"

    Description
    -----------      
    This command will search for and display all computers matching the given input. 
           
    #> 
    [cmdletbinding(
    	ConfirmImpact = 'low'
    )]
        Param(
            [Parameter(
                Position = 0,
                ValueFromPipeline = $True)]
                [string[]]$Computer                                  
                )
    Begin {                
        $ErrorActionPreference = 'stop'    
    }
    Process {
        If ($PSBoundParameters['Computer']) {
            ForEach ($c in $computer) {
                Write-Verbose "Retrieve computer in WSUS"
                Try {      
                    $wsus.SearchComputerTargets($c)
                } Catch {
                    Write-Warning ("Unable to retrieve {0} from database." -f $c)
                }
            }
        } Else {
            Try {
                Write-Verbose "Gather all computers in WSUS"
                $wsus.GetComputerTargets()
            } Catch {
                Write-Warning ("Unable to retrieve updates from database.`n{0}" -f $_.Exception.Message)
            }
        } 
    }   
}
