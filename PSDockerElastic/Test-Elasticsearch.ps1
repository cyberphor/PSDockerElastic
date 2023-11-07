function Test-Elasticsearch {
  Param(
      [string]$ContainerName = "elasticsearch",
      [string]$CaCertificateName = "ca.crt",
      [string]$CaCertificateDirectory = "/usr/share/elasticsearch/config/certs/",
      [string]$HostsFile = "$env:windir\System32\drivers\etc\hosts",
      [string]$Username = "elastic",
      [string]$Password = "elasticsearch"
  )

  $CaCertificatePath = $($CaCertificateDirectory + $CaCertificate)
  $Credentials = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$($Username):$($Password)"))
  $Headers = @{Authorization = "Basic $Credentials"}
  $Uri = "https://" + $Container + ":9200/_cat/health"
  $DNSEntry = "127.0.0.1`t$Container"

  docker cp $($Container + ":" + $CaCertificatePath) $CaCertificate
  
  Import-Certificate -FilePath $CaCertificate -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
  if (-not (Select-String -Path $HostsFile -Pattern $DNSEntry)) {
      Add-Content -Path $HostsFile -Value $DNSEntry -Force
  } 
  
  Invoke-RestMethod -Uri $Uri -Headers $Headers
  
  Remove-Item $CaCertificate
}