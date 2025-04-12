#!/usr/bin/env bash
set -e

# OS-Überprüfung
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Dieses Skript läuft nur unter macOS" >&2
  exit 1
fi

# Homebrew mit Prüfung
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew ist bereits installiert, überspringe Installation"
fi

# Terminal Tools Installation
brew install --cask wezterm
brew install git neovim tmux reattach-to-user-namespace starship \
    zsh-completions zsh-autosuggestions zsh-autocomplete fzf ruby \
    gnupg htop btop asciiquarium lolcat openjdk@17 python python-tk@3.11 \
    python-gdbm@3.11
pip3 install pyobjc

# Chezmoi mit Prüfung
if ! command -v chezmoi &>/dev/null; then
  brew install chezmoi
  chezmoi init -v --apply ssh://git@brothertec.eu:1023/simono41/dotfiles.git
else
  echo "chezmoi ist bereits installiert, überspringe Installation"
fi

# Java Symlinks erstellen
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# Clipboard Tools Installation
brew install jq choose-gui rg

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
