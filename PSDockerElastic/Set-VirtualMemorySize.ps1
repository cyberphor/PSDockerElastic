function Set-VirtualMemorySize {
  <#
  .LINK
  https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_set_vm_max_map_count_to_at_least_262144
  #>
  Write-Output "wsl -d docker-desktop -u root -e sysctl -w vm.max_map_count=262144"
}