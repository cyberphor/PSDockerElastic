function Set-WSLDistro {
    Param([string]$Distro = "docker-desktop")
    wsl --set-default $Distro
}