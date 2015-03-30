Function Connect-PSWSUSServer
{
    <#  
		.SYNOPSIS  
			Make the initial connection to a WSUS Server.
			
		.DESCRIPTION
			Make the initial connection to a WSUS Server. Only one concurrent connection is allowed.
			
		.PARAMETER WsusServer
			Name of WSUS server to connect to. Defaults to local host.
				  
		.PARAMETER SecureConnection
			Determines if a secure connection will be used to connect to the WSUS server. Defaults to un-secured.
			 
		.PARAMETER Port
			Port number to connect to. Default is Port 8530 if not used. Typical ports are 80 (http), 443 (https), 8350 (http) and 8351 (https)
			   
		.NOTES  
			Name: Connect-PSWSUSServer
			Author: Boe Prox
			Editor: Friedrich Weinmann
			DateCreated: 24SEPT2010 
			DateModified: 26MAR2015
				   
		.LINK  
			https://learn-powershell.net

		.EXAMPLE
			Connect-PSWSUSServer "server1"

			Description
			-----------
			This command will establish the connection to the WSUS using an unsecure connection on port 8530.
		
		.EXAMPLE
			Connect-PSWSUSServer "server1" $true 443

			Description
			-----------
			This command will establish a secure connection to the WSUS server on port 443.
		
		.EXAMPLE
			Connect-PSWSUSServer "server1" -port 8530

			Description
			-----------
			This command will make the connection to the WSUS using a defined port 8530.  
			   
    #>
	[cmdletbinding(ConfirmImpact = 'low')]
	Param (
		[Parameter(Position = 0, ValueFromPipeline = $True)]
		[Alias('WSUS', 'WSUSServer', 'Server', 'Name', 'Computer')]
		[string]
		$ComputerName = $env:COMPUTERNAME,
		
		[Parameter(Position = 1)]
		[Alias('SSL')]
		[bool]
		$SecureConnection = $false,
	
		[Parameter(Position = 2)]
		[int]
		$Port = 8530
	)
	Begin
	{
		Write-Debug "[Start] Connecting to WSUS"
	}
	Process
	{
		if ($PSCmdlet.ShouldProcess($ComputerName, "Establishing Connection to WSUS $ComputerName using Port $Port ($(if ($SecureConnection) { "SSL" } else { "no SSL" }))"))
		{
			# Make connection to WSUS server
			Try
			{
				$Global:wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer($ComputerName, $SecureConnection, $Port)
				Write-Output $Wsus
			}
			Catch
			{
				Write-Warning "Unable to connect to $($ComputerName)!`n$($error[0])"
			}
		}
	}
	End
	{
		Write-Debug "[End] Connecting to WSUS"
	}
}
