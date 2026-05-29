# Ayu Mac Rice

<p align="center">
  <img src="screenshots/desktop.png" width="90%">
</p>

A clean Ayu-themed macOS setup featuring:

* AeroSpace
* SketchyBar
* Ghostty
* Starship
* Fastfetch
* Borders
* Spotify integration
* Tailscale status
* X-VPN status
* CPU, RAM, Disk, Battery and Volume indicators

---

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/FuzzyGumnut/mac-rice.git

cd mac-rice

chmod +x install.sh

./install.sh
```

---

## What Gets Installed

The installer automatically installs:

* AeroSpace
* SketchyBar
* Ghostty
* Starship
* Fastfetch
* Borders
* JetBrainsMono Nerd Font

It also:

* Copies all configuration files
* Sets the included wallpaper
* Hides the Dock
* Hides the macOS Menu Bar
* Hides Desktop Icons
* Restarts Finder and Dock
* Starts SketchyBar services

---

## Required After Installation

Open:

```text
System Settings → Privacy & Security → Accessibility
```

Enable:

* AeroSpace
* SketchyBar

Open:

```text
System Settings → Privacy & Security → Screen Recording
```

Enable:

* Borders

You may need to log out and back in after granting permissions.

---

## Optional Applications

Install these for full functionality:

* Spotify (Music Widget)
* Tailscale (Tailscale Status Widget)
* X-VPN (VPN Status Widget)
* Raycast

---

## Updating

To update to the latest version:

```bash
cd ~/mac-rice

git pull

./install.sh
```

---

## Included Features

### SketchyBar

* Ayu Dark Theme
* Music Widget
* X-VPN Status
* Tailscale Status
* Disk Usage
* Volume
* Battery
* Clock
* CPU Usage
* RAM Usage
* Current App Indicator

### AeroSpace Workspaces

* WEB
* CODE
* TERM
* FILES
* CHAT
* MEDIA
* NET
* VM
* MISC
* SYS

### Terminal

* Ghostty
* Starship Prompt
* Fastfetch
* JetBrainsMono Nerd Font

### macOS Tweaks

* Auto-Hide Dock
* Auto-Hide Menu Bar
* Hidden Desktop Icons
* Included Ayu Wallpaper

---

## Notes

If AeroSpace does not start immediately after installation, log out and back in.

If icons appear as squares or missing symbols, ensure JetBrainsMono Nerd Font is installed and selected in Ghostty.

Spotify, Tailscale, X-VPN, and Raycast are optional and are not installed automatically.

This setup is designed for macOS and has been tested with AeroSpace, SketchyBar, Borders, Ghostty, Starship, and Fastfetch.

