function Copy-PSWSUSUpdateApproval {
    <#  
    .SYNOPSIS  
        Copies approvals
        
    .DESCRIPTION
        Copy appprovals from the SourceComputerTargetGroup to the DestinationComputerTargetGroup
        
    .PARAMETER SourceComputerTargetGroup
         ComputerTargetGroup whose approvals will be retrieved
    
    .PARAMETER TargetComputerTargetGroup
         ComputerTargetGroup whose approvals will be set
    
    .NOTES  
        Name: Copy-PSWSUSUpdateApproval
        Author: Dimitri Janczak
        DateCreated: 09Apr2018 
               
    .LINK  
        https://learn-powershell.net
        https://dimitri.janczak.net
        

        
    .EXAMPLE   
        Copy-PSWSUSApproval -SourceComputerTargetGroup 'Acceptance' -TargetComputerGroup 'Production'

    #> 
    [cmdletbinding(
    	ConfirmImpact = 'low',
        DefaultParameterSetName = '__Default'
    )]
    Param(
        [Parameter(Position = 0, ValueFromPipeline=$True,Mandatory=$true)]
        [string]$SourceComputerTargetGroup,
        [Parameter(Position = 1, Mandatory=$true)]
        [string]$DestinationComputerTargetGroup
    )

    Begin {
        if(-not $wsus)
        {
            Write-Warning "Use Connect-PSWSUSServer to establish connection with your Windows Update Server"
            Break
        }
    }
    Process {
        $approvalsSource = Get-PSWSUSUpdateApproval -ComputerTargetGroups $SourceComputerTargetGroup
        
        
        $targetGroupId = Get-PSWSUSGroup -Name $DestinationComputerTargetGroup
        
        $approvalsSource | ForEach-Object {
            $action = $_.Action
            $kb = $_.UpdateKB
            $updateID = $_.UpdateId
            $deadline = $_.DeadLine
            if ($deadline.ticks -eq 3155378975999999999) { 
                $wsus.GetUpdate($updateID) | Approve-PSWSUSUpdate -Action $action -Group $targetGroupId
                Write-Verbose "$($kb): $Action (no deadline)  $SourceComputerTargetGroup => $DestinationComputerTargetGroup"
            } else {
                $wsus.GetUpdate($updateID) | Approve-PSWSUSUpdate -Action $action -DeadLine $DeadLine -Group $targetGroupId
                Write-Verbose "$($kb): $Action (deadline: $($deadline))  $SourceComputerTargetGroup => $DestinationComputerTargetGroup"
                
            }   
        }
    }
    End{}
}
