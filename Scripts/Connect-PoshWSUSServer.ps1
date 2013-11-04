Function Connect-PoshWSUSServer {
    <#  
    .SYNOPSIS  
        Make the initial connection to a WSUS Server.
        
    .DESCRIPTION
        Make the initial connection to a WSUS Server. Only one concurrent connection is allowed.
        
    .PARAMETER WsusServer
        Name of WSUS server to connect to.    
              
    .PARAMETER SecureConnection
        Determines if a secure connection will be used to connect to the WSUS server. If not used, then a non-secure
        connection will be used.   
         
    .PARAMETER Port
        Port number to connect to. Default is Port "80" if not used. Accepted values are "80","443","8350" and "8351" 
           
    .NOTES  
        Name: Connect-PoshWSUSServer
        Author: Boe Prox
        DateCreated: 24SEPT2010 
        DateModified: 23MAR2013
               
    .LINK  
        https://learn-powershell.net

    .EXAMPLE
    Connect-PoshWSUSServer -PoshWSUSserver "server1"

    Description
    -----------
    This command will make the connection to the WSUS using an unsecure port (Default:80).
    .EXAMPLE
    Connect-PoshWSUSServer -WSUSserver "server1"  -SecureConnection 

    Description
    -----------
    This command will make a secure connection (Default: 443) to a WSUS server.   
    .EXAMPLE
    Connect-PoshWSUSServer -WSUSserver "server1" -port 8530

    Description
    -----------
    This command will make the connection to the WSUS using a defined port 8530.  
           
    #> 
    [cmdletbinding(
    	DefaultParameterSetName = 'wsus',
    	ConfirmImpact = 'low'
    )]
        Param(
            [Parameter(
                Mandatory = $True,
                Position = 0,
                ParameterSetName = '',
                ValueFromPipeline = $True)]
                [string]$WsusServer,                     
            [Parameter(
                Mandatory = $False,
                Position = 1,
                ParameterSetName = '')]
                [switch]$SecureConnection,   
            [Parameter(
                Mandatory = $False,
                Position = 2,
                ParameterSetName = 'port')]
                [ValidateSet("80","443","8530","8531" )] 
                [int]$port                                
                )   
    Begin {                         
        $ErrorActionPreference = 'stop'
        If ($PSBoundParameters['SecureConnection']) {
            $Secure = $True
        } Else {
            $Secure = $False
        }
    }
    Process {
        If ($WsusServer -eq ".") {
            $WsusServer = $Env:COMPUTERNAME
        }
        #Make connection to WSUS server  
        Try {
            Switch ($pscmdlet.ParameterSetName) {
                "wsus" {
                    $Global:wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer($wsusserver,$Secure)
                }
                "port" {
                    $Global:wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer($wsusserver,$Secure,$port)              
                }               
            }
            Write-Output $Wsus  
        } Catch {
            Write-Warning "Unable to connect to $($wsusserver)!`n$($error[0])"
        } Finally {
            $ErrorActionPreference = 'continue' 
        } 
    }          
}