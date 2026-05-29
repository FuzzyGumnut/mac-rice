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
# Repositories
# -------------------------
brew tap nikitabobko/tap
brew tap homebrew/cask-fonts

# -------------------------
# Packages
# -------------------------
brew install sketchybar
brew install starship
brew install fastfetch
brew install borders
brew install aerospace

# -------------------------
# Applications
# -------------------------
brew install --cask ghostty
brew install --cask font-jetbrains-mono-nerd-font

# Optional (uncomment if desired)
# brew install --cask spotify
# brew install --cask tailscale

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
# Permissions
# -------------------------
chmod +x ~/.config/sketchybar/plugins/*.sh 2>/dev/null

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
echo "IMPORTANT:"
echo "Open:"
echo "System Settings > Privacy & Security > Accessibility"
echo ""
echo "Enable:"
echo "  • AeroSpace"
echo "  • SketchyBar"
echo ""
echo "Recommended:"
echo "  • Spotify"
echo "  • Tailscale"
echo "  • X-VPN"
echo "  • Raycast"
echo ""
echo "If AeroSpace doesn't start immediately, log out and back in."
