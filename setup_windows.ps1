##############################################
# Setup Script for Windows Dev Environment
# Author: Nicolas Wirth
# Purpose: Install & configure SSH, Neovim, Git
##############################################

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
