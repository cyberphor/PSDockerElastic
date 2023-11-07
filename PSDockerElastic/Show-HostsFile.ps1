function Show-HostsFile {
  Get-Content "$env:windir\System32\drivers\etc\hosts"
}