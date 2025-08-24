##############################################
# Setup Script for Windows Dev Environment
# Author: Nicolas Wirth
# Purpose: Install & configure SSH, Neovim, Git
##############################################

### Install & Configure OpenSSH Server ###
Write-Host "[INFO] Installing and configuring OpenSSH server..."

# Check available OpenSSH capabilities
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'

# Install the OpenSSH server capability
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start and configure the sshd service
Start-Service sshd
Get-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Configure firewall rules for SSH
Write-Host "[INFO] Configuring firewall for SSH..."
Remove-NetFirewallRule -Name sshd -ErrorAction SilentlyContinue
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

### Generate SSH Keys ###
Write-Host "[INFO] Generating SSH keys..."
ssh-keygen -t ed25519 -C "nicolas.wirth7@gmail.com" -f "$HOME/.ssh/id_ed25519"

# Display the public key so you can copy it easily
Write-Host "[INFO] Your SSH Public Key:"
Get-Content "$HOME/.ssh/id_ed25519.pub"

# Configure ssh-agent to manage keys
Write-Host "[INFO] Configuring ssh-agent..."
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
ssh-add "$HOME/.ssh/id_ed25519"

### Install Neovim & Tools ###
Write-Host "[INFO] Installing Neovim and dependencies..."
winget install --force BurntSushi.ripgrep.MSVC
winget install --force GnuWin32.UnZip
winget install --force Neovim.Neovim -e --id Neovim.Neovim

### Configure Neovim ###
Write-Host "[INFO] Setting up Neovim config..."
Remove-Item "${env:LOCALAPPDATA}\nvim" -Recurse -Force
New-Item -Path "${env:LOCALAPPDATA}\nvim" -ItemType SymbolicLink -Value "$HOME/devconf-base/src/.config/nvim"

### Configure Git ###
Write-Host "[INFO] Setting up Git config..."
Remove-Item "${env:ProgramFiles}\Git\etc\gitconfig" -Recurse -Force
New-Item -Path "${env:ProgramFiles}\Git\etc\gitconfig" -ItemType SymbolicLink -Value "$HOME/devconf-base/src/.gitconfig"

# Install MSYS2 using winget (hidden installer mode)
Write-Host "[INFO] Setting up MSYS2 config..."
winget install --force -e --id MSYS2.MSYS2 -h

# Wait a bit to ensure MSYS2 is installed
Start-Sleep -Seconds 5

# Path to MSYS2 bash
$msysPath = "C:\msys64\usr\bin\bash.exe"

# Update MSYS2 system
& $msysPath -lc "pacman -Syu --noconfirm"
& $msysPath -lc "pacman -Su --noconfirm"

# Install GCC and Make
& $msysPath -lc "pacman -S --noconfirm mingw-w64-x86_64-gcc mingw-w64-x86_64-make mingw-w64-x86_64-ripgrep"
Copy-Item "C:\msys64\mingw64\bin\mingw32-make.exe" "C:\msys64\mingw64\bin\make.exe"

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\msys64\mingw64\bin", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files (x86)\GnuWin32\bin", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:LOCALAPPDATA\Programs\ripgrep", "User")

Write-Host "[INFO] Setup complete!"
