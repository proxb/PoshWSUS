function Set-PSWSUSConfigUpdateClassification {

    <#
    .SYNOPSIS  
        Sets whether the classifications of updates that Windows Server Update Services (WSUS)
        synchronizes are enabled or disabled.
    
    .DESCRIPTION
        The Set-PSWSUSClassification cmdlet enables or disables the category of updates
        (for example security or critical) to be synchronized.

        Using this cmdlet without filtering results. Get-PSWSUSUpdateClassification cmdlet must be run,
        then the results are piped it into this cmdlet.
    
        Using this cmdlet with filtered results. The Get-WsusClassification cmdlet must be run,
        then results are filtered using the Where-Object cmdlet and piped into this cmdlet.

    .PARAMETER Classification
        Specifies the classification of updates that are to be synchronized. If the Disable parameter is used,
        then this parameter specifies the classification of updates that are not to be synchronized. 
        This parameter value is piped from the Get-PSWSUSUpdateClassification cmdlet.
    
    .PARAMETER Disable
        Specifies that updates are not to be synchronized for the specified classification.

    .NOTES  
        Name: Set-PSWSUSConfigUpdateClassification
        Author: Dubinsky Evgeny
        DateCreated: 10MAY2013
    
    .EXAMPLE
        Get-PSWSUSUpdateClassification | Set-PSWSUSConfigUpdateClassification
        
        Description
        -----------
        This command enable all classification, to sync with MS Windows Update.

    .EXAMPLE
        Get-PSWSUSUpdateClassification | where {$_.Title -eq "Drivers" } | Set-PSWSUSConfigUpdateClassification -Disable
        
        Description
        -----------
        This command will disable Drivers class from sync with MS Windows Update.
    
    .EXAMPLE
        Get-PSWSUSUpdateClassification | where {$_.Title -in @( 'Critical Updates', 'Service Packs' )} | Set-PSWSUSConfigUpdateClassification

        Description
        -----------
        This command will enable to sync with MS Windows Update Critical Updates and Service Packs.

    .LINK
        http://blog.itstuff.in.ua/?p=62#Set-PSWSUSConfigUpdateClassification
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory = $True,
            Position = 0,
            ValueFromPipeline = $True)]
            [Microsoft.UpdateServices.Administration.UpdateClassificationCollection]$Classification,
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $false)]
            [switch]$Disable
    )

    Begin
    {
        if($wsus)
        {
            if($PSBoundParameters['Disable'])
            {
                $Collection = $wsus.GetSubscription().GetUpdateClassifications()
            }
            else 
            {
                $Collection = New-Object -TypeName Microsoft.UpdateServices.Administration.UpdateClassificationCollection
                
            }
            $Subscription = $wsus.GetSubscription()
        }
        else
        {
            Write-Warning "Use Connect-PSWSUSServer for establish connection with your Windows Update Server"
            Break
        }
    }
    Process
    { 
        if($PSBoundParameters['Disable'])
        {
            foreach ($Class in $Classification)
            {
                $ClassTitle = $Class.Title
                if ($Collection.Title -notcontains $ClassTitle)
                {
                    Write-Warning "Class $ClassTitle not enable."
                }
                else
                {
                    $Classification | % { $Collection.Remove($_) } 
                }
            }
        }
        else 
        {
            $Classification | % { $Collection.Add($_) | Out-Null }
        }
        $Subscription.SetUpdateClassifications($Collection)
    }
    End
    {
        $Subscription.Save()
    }
}
