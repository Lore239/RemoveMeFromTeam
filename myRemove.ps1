#!/usr/bin/pwsh

function Write-ListTeams {
    param (
        $account
    )

    $teams = @(Get-Team -User $account)
    for ($i = 0; $i -lt $teams.Count; $i++) {
        $teamName = $teams[$i].DisplayName
        Write-Host "$i : $teamName"
    }

}


if (Get-Module -ListAvailable -Name MicrosoftTeams) {
    Write-Host ""
} 
else {
    Install-Module -Name MicrosoftTeams -Force
}

$account = Connect-MicrosoftTeams | Select -ExpandProperty "Account"

$scelta = ""
while ($scelta -ne 0){
    $scelta = Read-Host -Prompt "1: Lista Teams`n2: Rimuovi dal team`n0: Esci`n"
    Write-Host ""


if ($scelta -eq 1){
    Write-ListTeams($account)
}

if ($scelta -eq 2){
    Write-ListTeams($account)
    [int]$t = Read-Host -Prompt "Da quale team vuoi essere rimosso?"
    $team = $teams[$t].DisplayName
    $group_id = (Get-Team -DisplayName $team).GroupId
    Remove-TeamUser -GroupId $group_id -User $account

}

Write-Host "`n#################################################`n"
}


