<#
To Do:
    1. New-PSWSUSLocalPackage
    2. Get-PSWSUSLocalPackage
    3. Get-PSWSUSUpdateApproval
    4. Set-PSWSUSConfiguration
    5. New-PSWSUSClient
#>

#Load Functions
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
Try {
    Get-ChildItem "$ScriptPath\Scripts" | Select -Expand FullName | ForEach {
        $Function = Split-Path $_ -Leaf
        . $_
    }
} Catch {
    Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
    Continue
}   

<#
TODO:
$ExecutionContext.SessionState.Module.OnRemove{
    Remove-Variable -Name Wsus -Scope Global -Force
}
#>