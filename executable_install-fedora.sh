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
flatpak install flathub com.vscodium.codium

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
  mkdir -p ${HOME}/repos
  cd ${HOME}/repos
  git clone https://github.com/sentriz/cliphist.git
  cd cliphist
  go build -o cliphist .
  sudo cp cliphist /usr/bin/
  echo "cliphist wurde auf dem System installiert"
else
  echo "cliphist ist bereits installiert, überspringe Download"
fi

# Spotify Player mit Prüfung
if [[ ! -f /usr/bin/spotify_player ]]; then
  # Architektur ermitteln
  ARCH=$(uname -m)
  if [ "$ARCH" = "aarch64" ]; then
    URL="https://github.com/aome510/spotify-player/releases/download/v0.20.4/spotify_player-aarch64-unknown-linux-gnu.tar.gz"
  elif [ "$ARCH" = "x86_64" ]; then
    URL="https://github.com/aome510/spotify-player/releases/download/v0.20.4/spotify_player-x86_64-unknown-linux-gnu.tar.gz"
  else
    echo "Nicht unterstützte Architektur: $ARCH"
    exit 1
  fi

  # Herunterladen und Entpacken
  echo "Lade spotify_player von $URL herunter..."
  curl -L "$URL" | tar -xz -C /tmp || { echo "Fehler beim Herunterladen oder Entpacken"; exit 1; }

  # Datei verschieben und ausführbar machen
  sudo mv /tmp/spotify_player /usr/bin/spotify_player
  sudo chmod +x /usr/bin/spotify_player
  echo "spotify_player wurde auf dem System installiert"
else
  echo "spotify_player ist bereits installiert, überspringe Download"
fi

