#!/bin/bash

# =============================================================================
#                    Development Environment Setup Script
# =============================================================================
#  Description: Automated setup for development tools and configurations
#  Usage: ./setup.sh
#  Author: Nicolas and Claude
#  Version: 1.0
# =============================================================================

set -e  # Exit on any error

# Banner
echo "=================================================="
echo "  🚀 Development Environment Setup"
echo "=================================================="
echo "  Setting up your development machine..."
echo "  This script will install and configure:"
echo "  • Core development tools (git, neovim, tmux)"
echo "  • Latest Neovim with custom configuration"
echo "  • JetBrains Mono Nerd Font"
echo "  • Zsh with Oh My Zsh and Powerlevel10k"
echo "  • Various utility tools"
echo "=================================================="
echo ""

# =============================================================================
# System Update
# =============================================================================
echo "📦 Step 1/7: Updating system packages..."
echo "   → Running apt update and upgrade..."
sudo apt update && sudo apt upgrade -y
echo "✅ System packages updated successfully"
echo ""

# =============================================================================
# Core Development Tools
# =============================================================================
echo "🔧 Step 2/7: Installing core development tools..."
echo "   → Installing git, fzf, neovim, tig, tmux..."
sudo apt install -y git fzf neovim tig tmux
echo "✅ Core development tools installed successfully"
echo ""

# =============================================================================
# Neovim Dependencies
# =============================================================================
echo "⚙️  Step 3/7: Installing Neovim dependencies..."
echo "   → Installing build tools and utilities..."
sudo apt install -y fd-find fonts-noto-color-emoji
sudo apt install -y make gcc ripgrep unzip xclip curl
echo "✅ Neovim dependencies installed successfully"
echo ""

# =============================================================================
# Neovim Installation (Latest Version)
# =============================================================================
echo "📝 Step 4/7: Installing latest Neovim..."
echo "   → Downloading latest Neovim release..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

echo "   → Removing existing installation (if any)..."
# Remove existing installation
sudo rm -rf /opt/nvim-linux-x86_64

echo "   → Setting up installation directory..."
# Create and setup directory
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64

echo "   → Extracting and installing Neovim..."
# Extract and install
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

echo "   → Creating system-wide symlink..."
# Create symlink to make it available system-wide
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
echo "✅ Latest Neovim installed successfully"
echo ""

# =============================================================================
# JetBrains Mono Nerd Font Installation
# =============================================================================
echo "🔤 Step 5/7: Installing JetBrains Mono Nerd Font..."
echo "   → Installing fontconfig..."
sudo apt install -y fontconfig

echo "   → Creating fonts directory..."
# Create fonts directory if it doesn't exist
sudo rm -rf ~/.local/share/fonts/
mkdir -p ~/.local/share/fonts

echo "   → Downloading and extracting font..."
# Download and install JetBrains Mono Nerd Font
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts/
rm JetBrainsMono.zip

echo "   → Refreshing font cache..."
# Refresh font cache
fc-cache -f -v > /dev/null 2>&1
echo "✅ JetBrains Mono Nerd Font installed successfully"
echo ""

# =============================================================================
# Environment and Utility Tools
# =============================================================================
echo "🌍 Step 6/7: Installing environment and utility tools..."
echo "   → Installing file manager, shell, and monitoring tools..."
sudo apt install -y ranger tree zsh
sudo apt install -y bpytop rsync
echo "✅ Environment and utility tools installed successfully"
echo ""

# =============================================================================
# Configuration Setup
# =============================================================================
echo "⚡ Step 7/7: Setting up configurations..."

DOTFILES_DIR="$HOME/devconf-base"

echo "   → Configuring Git..."
# Remove existing git config and clone new one
sudo rm -rf ~/.gitconfig
# rsync -P ./src/.gitconfig ~/.gitconfig
ln -sf "$DOTFILES_DIR/src/.gitconfig" ~/.gitconfig

echo "   → Configuring Neovim..."
# Remove existing Neovim config and clone new one
sudo rm -rf ~/.config/nvim
# git clone git@github.com:MaistreRenard/devconf-neovim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
ln -sf "$DOTFILES_DIR/src/.config/nvim" ~/.config/nvim

echo "   → Setting up Zsh with Oh My Zsh..."
# Install Oh My Zsh (suppress output to avoid installation prompts)
sudo rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "   → Installing Powerlevel10k theme..."
# Install Powerlevel10k theme
sudo rm -rf ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo "   → Installing zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "   → Installing zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "   → Configuring Git..."
# Remove existing git config and clone new one
sudo rm -rf ~/.zshrc
# rsync -P ./src/.zshrc ~/.zshrc
ln -sf "$DOTFILES_DIR/src/.zshrc" ~/.zshrc

echo "✅ All configurations set up successfully"
echo ""

# =============================================================================
# Completion
# =============================================================================
echo "=================================================="
echo "  🎉 Setup Complete!"
echo "=================================================="
echo ""
echo "📋 Summary:"
echo "  ✅ System updated"
echo "  ✅ Development tools installed"
echo "  ✅ Latest Neovim installed"
echo "  ✅ JetBrains Mono Nerd Font installed"
echo "  ✅ Utility tools installed"
echo "  ✅ Configurations applied"
echo ""
echo "🔄 Next steps:"
echo "  1. The script will now start Zsh"
echo "  2. Configure Powerlevel10k when prompted"
echo "  3. Set your terminal font to 'JetBrainsMono Nerd Font'"
echo ""
echo "=================================================="
echo "Starting Zsh shell..."
exec zsh
