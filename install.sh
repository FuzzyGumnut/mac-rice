#!/bin/bash

brew install sketchybar
brew install borders
brew install aerospace
brew install starship
brew install fastfetch

mkdir -p ~/.config

cp -R .config/* ~/.config/
cp .zshrc ~/

brew services restart sketchybar
