#!/bin/bash
clear

if [ -f "./ayu-intro" ]; then
    chmod +x ./ayu-intro

    ./ayu-intro &
    PID=$!

    sleep 5

    kill $PID 2>/dev/null
    wait $PID 2>/dev/null
fi

clear

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "          Ayu Mac Rice"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1) Full Install"
echo "2) Exit"
echo ""

read -p "Select option: " OPTION

case $OPTION in
    1) ;;
    *) exit 0 ;;
esac

clear
# -------------------------
# Homebrew Check
# -------------------------
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Refresh shell environment after Homebrew install
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# -------------------------
# Wallpaper
# -------------------------

WALLPAPER="$(pwd)/screenshots/background.png"

if [ -f "$WALLPAPER" ]; then
osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to "$WALLPAPER"
    end tell
end tell
EOF
fi

# -------------------------
# macOS UI Tweaks
# -------------------------
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock show-recents -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write com.apple.dock expose-animation-duration -float 0.1

defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.finder CreateDesktop -bool false
killall Finder
killall Dock
# -------------------------
# Repositories
# -------------------------
brew tap nikitabobko/tap
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae

brew trust FelixKratz/formulae 2>/dev/null || true
brew trust nikitabobko/tap 2>/dev/null || true

# -------------------------
# SCREENSHOT FOLDER
# -------------------------
mkdir -p ~/Pictures/Screenshots

defaults write com.apple.screencapture location ~/Pictures/Screenshots

killall SystemUIServer

# -------------------------
# Packages
# -------------------------
brew install sketchybar || true
brew install starship || true
brew install fastfetch || true
brew install borders || true
brew install aerospace || true

# ------------------------ 
# Trust
# ------------------------
# -------------------------
# Applications
# -------------------------
brew install --cask ghostty || true
brew install --cask font-jetbrains-mono-nerd-font || true
brew install --cask obsidian || true

hash -r
# -------------------------
# Optional Applications
# -------------------------

clear

echo ""
read -p "🎵 Install Spotify? (y/N): " INSTALL_SPOTIFY

if [[ "$INSTALL_SPOTIFY" =~ ^[Yy]$ ]]; then
    brew install --cask spotify
fi

clear

echo ""
read -p "🔒 Install Tailscale? (y/N): " INSTALL_TAILSCALE

if [[ "$INSTALL_TAILSCALE" =~ ^[Yy]$ ]]; then
    brew install --cask tailscale
fi

clear

echo ""
read -p "⚡ Install Raycast? (y/N): " INSTALL_RAYCAST

if [[ "$INSTALL_RAYCAST" =~ ^[Yy]$ ]]; then
    brew install --cask raycast
fi

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
brew services start borders || true
# -------------------------
# Reload AeroSpace
# -------------------------
if command -v aerospace >/dev/null 2>&1; then
    aerospace reload-config 2>/dev/null
fi
clear
# -------------------------
# Install steps
# -------------------------
open -a AeroSpace 2>/dev/null || true
clear
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
echo ""
echo "⚠️ For AeroSpace, Borders and permissions to work correctly:"
echo "   Log out and back in after enabling permissions."
