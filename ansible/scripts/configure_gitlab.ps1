param ($GITLAB_TOKEN)
if (!$GITLAB_TOKEN){
  Write-Output "Please unlock Bitwarden"
  break
}

#Gitlab set ssh key

$header = @{
    "PRIVATE-TOKEN"=$GITLAB_TOKEN
}
$GitlabAPI = "https://gitlab.com/api/v4"

$publickey = Get-Content ~/.ssh/id_ed25519.pub

$body = @{
    title = "Ansible Script"
    key = "$publickey"
} | ConvertTo-Json

Try{
    Invoke-RestMethod -Headers $header -Uri $GitlabAPI/user/keys -Body $body -Method Post -ContentType application/json -ErrorVariable gitlabkey | Out-Null
}Catch{
    if($gitlabkey -like "*Token is expired*"){
        Write-Error "Token Has Expired"
        exit -1
    }
    if($gitlabkey -notlike "*has already been taken*"){
        Write-Error "Failed to upload key"
        exit -1
    }
}
