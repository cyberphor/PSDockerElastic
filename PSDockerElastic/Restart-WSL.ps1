function Restart-WSL {
    Get-Service LxssManager | Restart-Service
}