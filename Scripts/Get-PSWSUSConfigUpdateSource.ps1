function Get-PSWSUSConfigUpdateSource {
<#
	.SYNOPSIS
		Gets configuration server from which to synchronize updates.

	.EXAMPLE
		Get-PSWSUSConfigUpdateSource

	.OUTPUTS
		Microsoft.UpdateServices.Internal.BaseApi.UpdateServerConfiguration

	.NOTES
		Name: Get-PSWSUSConfigUpdateSource
        Author: Dubinsky Evgeny
        DateCreated: 1DEC2013

	.LINK
		http://blog.itstuff.in.ua/?p=62#Get-PSWSUSConfigUpdateSource

#>

    [CmdletBinding()]
    Param()

    Begin
    {
        if($wsus)
        {
            $config = $wsus.GetConfiguration()
            $config.ServerId = [System.Guid]::NewGuid()
            $config.Save()
        }#endif
        else
        {
            Write-Warning "Use Connect-PSWSUSServer for establish connection with your Windows Update Server"
            Break
        }
    }
    Process
    { 
        Write-Verbose "Getting WSUS update files configuration"
        $config | select SyncFromMicrosoftUpdate, `
                         UpstreamWsusServerName, `
                         UpstreamWsusServerPortNumber, `
                         UpstreamWsusServerUseSsl, `
                         IsReplicaServer
    }
    End{}
}
