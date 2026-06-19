#!/bin/bash

clear

echo "⚠️  Ayu Mac Rice Uninstaller"
echo ""
echo "This will remove:"
echo "  • AeroSpace"
echo "  • SketchyBar"
echo "  • Borders"
echo "  • Ghostty"
echo "  • Fastfetch"
echo "  • btop"
echo "  • Starship"
echo "  • Obsidian"
echo "  • JetBrainsMono Nerd Font"
echo "  • Ayu configuration files"
echo ""
read -p "Continue? (y/N): " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
exit 0
fi

clear

echo "Stopping services..."

brew services stop sketchybar 2>/dev/null
brew services stop borders 2>/dev/null

killall SketchyBar 2>/dev/null
killall borders 2>/dev/null

echo "Removing packages..."

brew uninstall sketchybar 2>/dev/null || true
brew uninstall aerospace 2>/dev/null || true
brew uninstall borders 2>/dev/null || true
brew uninstall fastfetch 2>/dev/null || true
brew uninstall btop 2>/dev/null || true
brew uninstall starship 2>/dev/null || true

echo "Removing applications..."

brew uninstall --cask ghostty 2>/dev/null || true
brew uninstall --cask obsidian 2>/dev/null || true
brew uninstall --cask spotify 2>/dev/null || true
brew uninstall --cask tailscale 2>/dev/null || true
brew uninstall --cask raycast 2>/dev/null || true
brew uninstall --cask font-jetbrains-mono-nerd-font 2>/dev/null || true

echo "Removing configuration files..."

rm -rf ~/.config/sketchybar
rm -rf ~/.config/aerospace
rm -rf ~/.config/ghostty

rm -f ~/.config/starship.toml

echo "Restoring macOS settings..."

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

defaults write com.apple.finder CreateDesktop -bool true

defaults write NSGlobalDomain _HIHideMenuBar -bool false

defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock show-recents -bool true

defaults delete NSGlobalDomain NSWindowResizeTime 2>/dev/null
defaults delete com.apple.dock expose-animation-duration 2>/dev/null

killall Finder 2>/dev/null
killall Dock 2>/dev/null
killall SystemUIServer 2>/dev/null

echo ""
echo "Removing Homebrew taps..."

brew untap FelixKratz/formulae 2>/dev/null || true
brew untap nikitabobko/tap 2>/dev/null || true

echo ""
echo "Cleaning Homebrew..."

brew autoremove
brew cleanup

echo "Restoring power settings..."

sudo pmset -b lowpowermode 0 2>/dev/null || true

defaults write com.apple.universalaccess reduceTransparency -bool false
defaults write com.apple.universalaccess reduceMotion -bool false

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "      AYU MAC RICE REMOVED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "A logout/login is recommended."
echo ""

