function Remove-PoshWSUSClient {
    <#  
    .SYNOPSIS  
        Removes client from WSUS.
    .DESCRIPTION
        Removes client from WSUS.
    .PARAMETER Computer
        Name of the client to remove from WSUS.
    .PARAMETER InputObject
        Computer object that is being removed.     
    .NOTES  
        Name: Remove-PoshWSUSClient
        Author: Boe Prox
        DateCreated: 12NOV2010 
               
    .LINK  
        https://learn-powershell.net
    .EXAMPLE  
    Remove-PoshWSUSClient -computer "server1"

    Description
    -----------      
    This command will remove 'server1' from WSUS. 
    .EXAMPLE  
    Get-PoshWSUSClient -computer "server1" | Remove-PoshWSUSClient

    Description
    -----------      
    This command will remove 'server1' from WSUS. 
    .EXAMPLE  
    Get-PoshWSUSClient -computer "serv" | Remove-PoshWSUSClient 
    
    Description
    -----------      
    This command will remove multiple servers from WSUS. 
           
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
                [system.object[]]$Computername                                            
                )  
    Process {    
        ForEach ($Computer in $Computername) {
            Try {
                If ($Computer -is [Microsoft.UpdateServices.Internal.BaseApi.ComputerTarget]) {
                    If ($pscmdlet.ShouldProcess($computer.FullDomainName)) {
                        Write-Verbose "Removing $($computer.FullDomainName) from WSUS"
                        $computer.Delete()
                    }                
                } Elseif ($Computer -is [string]) {
                    $client = Get-PoshWSUSClient $Computer
                    If ($pscmdlet.ShouldProcess($client.FullDomainName)) {
                        Write-Verbose "Removing $($client.FullDomainName) from WSUS"
                        $client.Delete()
                    }                
                } Else {
                    Write-Warning ("Invalid type: {0}`nMust be a string value or ComputerTarget object!" -f $computer.gettype().ToString())
                }
            } Catch {
                Write-Warning ("Unable to remove {0} from WSUS." -f $computer)
            }
        }             
    }               
}
