function Get-PSWSUSConfigUpdateFiles {
<#
	.SYNOPSIS
		Gets config whether updates are stored locally or whether clients download approved updates directly from Microsoft Update. 

	.DESCRIPTION
		Gets config whether updates are stored locally or whether clients download approved updates directly from Microsoft Update.

	.EXAMPLE
		Get-PSWSUSConfigUpdateFiles

	.OUTPUTS
		Microsoft.UpdateServices.Internal.BaseApi.UpdateServerConfiguration

	.NOTES
		Name: Get-PSWSUSConfigUpdateFiles
        Author: Dubinsky Evgeny
        DateCreated: 1DEC2013

	.LINK
		http://blog.itstuff.in.ua/?p=62#Get-PSWSUSConfigUpdateFiles

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
        Write-Verbose "Getting WSUS update source configuration"
        $wsus.GetConfiguration() | select HostBinariesOnMicrosoftUpdate, DownloadExpressPackages, DownloadUpdateBinariesAsNeeded, GetContentFromMU
    }
    End{}
}
