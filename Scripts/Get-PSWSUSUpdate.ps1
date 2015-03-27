function Get-PSWSUSUpdate {
    <#  
    .SYNOPSIS  
        Retrieves information from a wsus update.
        
    .DESCRIPTION
        Retrieves information from a wsus update. Depending on how the information is presented in the search, more
        than one update may be returned.
         
    .PARAMETER Update
        String to search for. This can be any string for the update to include
        KB article numbers, name of update, category, etc... Use of wildcards (*,%) not allowed in search!
        
    .NOTES  
        Name: Get-PSWSUSUpdate
        Author: Boe Prox
        DateCreated: 24SEPT2010 
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE 
    Get-PSWSUSUpdate -update "Exchange"

    Description
    -----------  
    This command will list every update that has 'Exchange' in it.
    
    .EXAMPLE
    Get-PSWSUSUpdate -update "925474"

    Description
    -----------  
    This command will list every update that has '925474' in it.
    
    .EXAMPLE
    Get-PSWSUSUpdate

    Description
    -----------  
    This command will list every update on the WSUS Server.    
    #> 
    [cmdletbinding(DefaultParameterSetName = 'Null')]
        Param(
            [Parameter(
                Position = 0,
                ValueFromPipeline = $True,
				ParameterSetName = 'Update')]
			[string]
			$Update,
			[Parameter(
                Position = 0,
                ValueFromPipeline = $True,
				ParameterSetName = 'Id')]
			[Microsoft.UpdateServices.Administration.UpdateRevisionId[]]
			$Id,
            [Parameter(
                Position = 0,
                ValueFromPipeline = $True,
				ParameterSetName = 'UpdateObject')]
			[Microsoft.UpdateServices.Administration.UpdateScope]
			$UpdateScope                                                  
        )
    Begin {                
        $ErrorActionPreference = 'stop' 
        $hash = @{}  
    }
    Process {
        If ($PSBoundParameters['Update'])
		{
            Write-Verbose "Creating Update Scope with update data"
            $hash['UpdateScope'] = New-PSWSUSUpdateScope -TextIncludes $Update
        }
		ElseIf
		($PSBoundParameters['UpdateScope'])
		{
            $hash['UpdateScope'] = $UpdateScope                                                  
        }
		
        If ($PSCmdlet.ParameterSetName -eq 'Null')
		{
            Write-Verbose "Getting all updates"
            $wsus.getupdates()
        }
		ElseIf ($PSCmdlet.ParameterSetName -eq 'Id')
		{
			Write-Verbose "Getting specified updates"
			foreach ($i in $Id){ $wsus.GetUpdate($i) }
		}
		Else
		{
            Write-Verbose "Getting specified updates"
            $wsus.getupdates($hash['UpdateScope'])
        }
    }
    End {
        $ErrorActionPreference = 'continue' 
    }   
}
