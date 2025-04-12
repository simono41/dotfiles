#!/usr/bin/env bash

set -e

# OS-Überprüfung
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Dieses Skript läuft nur unter macOS" >&2
  exit 1
fi

# Terminal Tools Installation
brew install --cask wezterm
brew install neovim tmux reattach-to-user-namespace starship \
    zsh-completions zsh-autosuggestions zsh-autocomplete fzf ruby \
    gnupg htop btop asciiquarium lolcat openjdk@17 python python-tk@3.11 \
    python-gdbm@3.11 pinentry-mac
pip3 install pyobjc

# Java Symlinks erstellen
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Clipboard Tools Installation
brew install jq choose-gui rg
brew install --cask flycut

# Tailscale Installation und Konfiguration
brew install tailscale
sudo tailscaled install-system-daemon
tailscale up --login-server=https://vpn.brothertec.eu --ssh --accept-routes

# Fonts Installation (Nerd Fonts)
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font

# Entwicklungswerkzeuge für JetBrains installieren (optional)
brew install kdoctor cocoapods

# Optionale Tools installieren (Visual Studio Code, Prism Launcher)
brew install --cask visual-studio-code prismlauncher

# RBW (Rust Bitwarden CLI) Installation und Konfiguration
brew install rbw
rbw config set email simon@rieger.app
rbw config set base_url https://vaultwarden.brothertec.eu
rbw config set pinentry pinentry-mac
