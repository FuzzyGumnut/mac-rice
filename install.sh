#!/bin/bash

echo "🚀 Installing Bowen's Ayu Mac Rice..."

# -------------------------
# Homebrew Check
# -------------------------
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# -------------------------
# Packages
# -------------------------
brew install sketchybar
brew install starship
brew install fastfetch
brew install borders

brew tap nikitabobko/tap
brew install aerospace

# -------------------------
# Config Directories
# -------------------------
mkdir -p ~/.config
mkdir -p ~/.config/sketchybar
mkdir -p ~/.config/aerospace
mkdir -p ~/.config/ghostty

# -------------------------
# Copy Configs
# -------------------------
cp -R .config/* ~/.config/

cp .zshrc ~/

if [ -f starship.toml ]; then
    cp starship.toml ~/.config/
fi

# -------------------------
# Start Services
# -------------------------
brew services restart sketchybar

# -------------------------
# Reload AeroSpace
# -------------------------
aerospace reload-config 2>/dev/null

echo ""
echo "✅ Install Complete"
echo ""
echo "Still Required:"
echo "1. Install JetBrainsMono Nerd Font"
echo "2. System Settings > Privacy & Security > Accessibility"
echo "3. Enable:"
echo "   - AeroSpace"
echo "   - SketchyBar"
echo ""
echo "Optional:"
echo "   - Spotify"
echo "   - Tailscale"
echo "   - X-VPN"
echo "   - Raycast"
