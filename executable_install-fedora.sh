#!/usr/bin/env bash
set -e

# OS-Überprüfung
if [[ "$(uname -s)" != "Linux" ]] || ! grep -q '^ID_LIKE=fedora' /etc/os-release; then
  echo "Dieses Skript läuft nur unter Fedora Linux" >&2
  exit 1
fi

# DNF Grundkonfiguration
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Paketinstallationen gruppiert
## Shell-Tools
sudo dnf install -y \
  fzf zsh-autosuggestions zsh-syntax-highlighting \
  rg htop ncdu pwgen pass-otp gopass gopass-jsonapi \
  tmux-powerline lolcat socat

## GUI & Desktop
sudo dnf install -y \
  fuzzel papirus-icon-theme waybar pavucontrol-qt \
  arc-theme hyprlock copyq nwg-dock-hyprland nwg-drawer \
  nwg-panel nwg-launchers cascadia-code-nf-fonts \
  jetbrains-mono-fonts la-capitaine-cursor-theme \
  la-capitaine-icon-theme

## Entwicklung
sudo dnf install -y \
  golang libgo-devel neovim python3-neovim \
  ansible openldap-devel gcc python3-psycopg2 \
  python3-postgresql golang-x-tools-toolstash \
  golang-x-arch-devel.noarch

## Systemdienste
sudo dnf install -y \
  dkms libdrm-devel hplip ydotool pkg-config \
  libxkbcommon-devel scdoc inotify-tools \
  net-snmp-utils net-snmp snmpd virt-manager \
  @virtualization virt-what

## Multimedia
sudo dnf install -y \
  vlc vlc-plugin-gstreamer vlc-plugin-pipewire \
  vlc-libs vlc-plugin-ffmpeg ffmpeg ffmpeg-free \
  gstreamer1-libav gstreamer1-vaapi \
  gstreamer1-plugins-good gstreamer1-plugins-good-extras

## Docker
sudo dnf install -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

# Flatpak Setup
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Systemkonfiguration
sudo usermod -s /bin/zsh simono41

# Chezmoi Installation mit Prüfung
if ! command -v chezmoi &>/dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)"
  chezmoi init -v --apply --force ssh://git@brothertec.eu:1023/simono41/dotfiles.git
else
  echo "chezmoi ist bereits installiert, überspringe Installation"
fi

# Starship Installation mit Prüfung
if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh
else
  echo "Starship ist bereits installiert, überspringe Installation"
fi

# Cliphist mit Prüfung
if [[ ! -f /usr/bin/cliphist ]]; then
  ARCH="$(uname -m)"
  if [[ "$ARCH" == "aarch64" || "$ARCH" == "armv7l" ]]; then
    CLIPHIST_URL="https://github.com/sentriz/cliphist/releases/download/v0.6.1/v0.6.1-linux-arm"
  else
    CLIPHIST_URL="https://github.com/sentriz/cliphist/releases/download/v0.6.1/v0.6.1-linux-amd64"
  fi
  sudo wget -O /usr/bin/cliphist "$CLIPHIST_URL"
  sudo chmod +x /usr/bin/cliphist
else
  echo "cliphist ist bereits installiert, überspringe Download"
fi
