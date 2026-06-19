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

# ──────────────────────────────────────────────────────────
# AYU THEME INTERACTIVE ARROW-KEY MENU (macOS Fixed Syntax)
# ──────────────────────────────────────────────────────────

# Ayu Dark Palette
AYU_GOLD=$(printf '\033[38;5;214m')
AYU_ORANGE=$(printf '\033[38;5;208m')
AYU_BLUE=$(printf '\033[38;5;73m')
AYU_GRAY=$(printf '\033[38;5;244m')
AYU_WHITE=$(printf '\033[38;5;253m')
RESET=$(printf '\033[0m')

options=("Full Install" "Uninstall" "Exit")
selected=0

draw_menu() {
    clear
    printf "${AYU_GRAY}┌────────────────────────────────────────────────────────┐${RESET}\n"
    printf "${AYU_GOLD}   __   _  _  _  _      ____  __  ___  ____ ${RESET}\n"
    printf "${AYU_GOLD}  / _\ ( \/ )/ )( \ ___(  _ \(  )/ __)(  __)${RESET}\n"
    printf "${AYU_GOLD} /    \ )  / ) \/ ((___))   / )(( (__  ) _) ${RESET}\n"
    printf "${AYU_GOLD} \_/\_/(__/  \____/    (__\_)(__)\___)(____)${RESET}\n"
    printf "${AYU_GRAY}└────────────────────────────────────────────────────────┘${RESET}\n"
    printf "\n"

    for i in "${!options[@]}"; do
        if [ "$i" -eq "$selected" ]; then
            printf "  ${AYU_ORANGE}➔ [${options[$i]}]${RESET}\n"
        else
            printf "      ${AYU_GRAY}${options[$i]}${RESET}\n"
        fi
    done

    printf "\n${AYU_GRAY}──────────────────────────────────────────────────────────${RESET}\n"
    printf "  ${AYU_BLUE}Use ↑/↓ Arrow Keys and press Enter${RESET}\n"
}

#Initial drawing
draw_menu

# Safe key interception loop
while true; do
    read -rsn1 key
    
    if [[ $key == $'\033' ]]; then
        read -rsn2 -t 1 sequence
        case "$sequence" in
            "[A") # Up Arrow
                if [ $selected -gt 0 ]; then
                    ((selected--))
                    draw_menu
                fi
                ;;
            "[B") # Down Arrow
                if [ $selected -lt $((${#options[@]} - 1)) ]; then
                    ((selected++))
                    draw_menu
                fi
                ;;
        esac
    elif [[ $key == "" || $key == $'\n' ]]; then
        break
    fi
done

clear

case $selected in
    0)
        printf "${AYU_GOLD}🚀 Initializing Full Install...${RESET}\n\n"
        sleep 1
        ;;
    1)
        printf "${AYU_ORANGE}🗑️ Running Uninstaller...${RESET}\n\n"
        sleep 1

        ./uninstall.sh

        exit 0
        ;;
    2)
        printf "${AYU_GRAY}Exiting setup. Goodbye!${RESET}\n\n"
        exit 0
        ;;
esac

# ──────────────────────────────────────────────────────────

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
brew install btop || true

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
clear

echo ""
read -p "🦊 Install Firefox? (y/N): " INSTALL_FIREFOX

if [[ "$INSTALL_FIREFOX" =~ ^[Yy]$ ]]; then
    brew install --cask firefox

    brew install defaultbrowser || true
    defaultbrowser firefox

    echo ""
    echo "✓ Firefox set as default browser"

    echo ""
    echo "Creating Firefox profile..."
    open -a Firefox

    sleep 10

    killall Firefox 2>/dev/null || true

    PROFILE=$(find "$HOME/Library/Application Support/Firefox/Profiles" \
        -maxdepth 1 \
        -type d \
        -name "*.default-release*" | head -n 1)

    if [ -n "$PROFILE" ]; then
        mkdir -p "$PROFILE/extensions"

        (
            cd theme_files
            zip -qr "../ayu-dark-mirage.xpi" .
        )

        cp ayu-dark-mirage.xpi \
        "$PROFILE/extensions/{898990db-1075-4dcd-b34a-c26a2bcf074b}.xpi"

        rm -f ayu-dark-mirage.xpi

        echo "✓ Installed Ayu Dark Mirage theme"
    fi
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
# SPICETIFY
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
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

clear

sleep 1
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "              INSTALL COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo ""
read -p "🚀 Launch showcase desktop? (Y/n): " SHOWCASE

if [[ ! "$SHOWCASE" =~ ^[Nn]$ ]]; then

# -------------------------
# Hide Existing Apps
# -------------------------

osascript <<EOF
tell application "System Events"
    repeat with p in (every process whose background only is false)
        try
            set visible of p to false
        end try
    end repeat
end tell
EOF

sleep 1
open -a Spotify

sleep 2

open -na Ghostty

sleep 1

osascript <<EOF
tell application "Ghostty" to activate
tell application "System Events"
    keystroke "clear && fastfetch"
    key code 36
end tell
EOF

sleep 1
open -na Ghostty

sleep 1

osascript <<EOF
tell application "Ghostty" to activate
tell application "System Events"
    keystroke "btop"
    key code 36
end tell
EOF
aerospace move right
aerospace move right
aerospace move right
aerospace move right
aerospace move right
fi

sleep 2
