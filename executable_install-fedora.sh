#!/usr/bin/env bash
set -e

# OS-Überprüfung
if [[ "$(uname -s)" != "Linux" ]] || ! grep -Eq '^ID=fedora|^ID_LIKE=.*fedora' /etc/os-release; then
  echo "Dieses Skript läuft nur unter Fedora Linux oder Fedora-ähnlichen Distributionen." >&2
  exit 1
fi

# DNF Grundkonfiguration
sudo dnf update
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
  la-capitaine-icon-theme flatseal qt5ct qt6ct pcmanfm-qt swappy

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
  @virtualization virt-what SwayNotificationCenter

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

## Aktiviere das COPR-Repository von solopasha/hyprland:
if dnf copr list | grep -q 'solopasha/hyprland'; then
  echo "solopasha/hyprland Copr-Repo ist bereits aktiviert"
else
  sudo dnf copr enable solopasha/hyprland
  echo "solopasha/hyprland Copr-Repo wurde hinzugefügt"
fi
sudo dnf install satty nwg-look cliphist
sudo dnf update

## VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
if [ ! -e /etc/yum.repos.d/vscodium.repo ]; then
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | sudo tee -a /etc/yum.repos.d/vscodium.repo
fi
sudo dnf install codium

# Flatpak Setup
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#flatpak install flathub com.spotify.Client
flatpak install flathub io.github.dweymouth.supersonic
flatpak install flathub com.bitwarden.desktop
flatpak install flathub org.prismlauncher.PrismLauncher
flatpak install flathub com.github.IsmaelMartinez.teams_for_linux

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

# MinIO Client mit Prüfung
if [[ ! -f $HOME/minio-binaries/mc ]]; then
  curl https://dl.min.io/client/mc/release/linux-$(uname -m)/mc \
    --create-dirs \
    -o $HOME/minio-binaries/mc
  echo "MinIO Client wurde auf dem System installiert"
else
  echo "MinIO Client ist bereits installiert, überspringe Download"
fi

# dotool mit Prüfung
if [[ ! -f /usr/local/bin/dotool ]]; then
  mkdir -p ${HOME}/repos
  cd ${HOME}/repos
  git clone https://git.sr.ht/~geb/dotool
  cd dotool
  ./build.sh && sudo ./build.sh install
  sudo udevadm control --reload && sudo udevadm trigger
  cd
  echo "dotool wurde auf dem System installiert"
else
  echo "dotool ist bereits installiert, überspringe Download"
fi

echo "Installationscript abgeschlossen!!!"
