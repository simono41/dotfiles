# For Install this Dotfiles on Fedora

## Dotfiles

~~~
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.wezfurlong.wezterm

flatpak run org.wezfurlong.wezterm

alias wezterm='flatpak run org.wezfurlong.wezterm'

sudo usermod -s /bin/zsh simono41

curl -sS https://starship.rs/install.sh | sh

dnf install jetbrains-mono-fonts tmux perl-Time-HiRes rbw

sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init -v --apply --force https://code.brothertec.eu/simono41/dotfiles.git
chezmoi update -v --force

sudo dnf install fzf zsh-autosuggestions zsh-syntax-highlighting fuzzel papirus-icon-theme rg dkms libdrm-devel htop hplip wtype ydotool pkg-config libxkbcommon-devel scdoc golang inotify-tools docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin vlc vlc-plugin-gstreamer vlc-plugin-pipewire vlc-libs vlc-plugin-ffmpeg ffmpeg ffmpeg-free code gstreamer1-libav gstreamer1-vaapi gstreamer1-plugins-good gstreamer1-plugins-good-extras go libgo-devel net-snmp-utils ncdu yad nvim neovim python3-neovim pwgen pass-otp gopass gopass-jsonapi ansible net-snmp snmpd grim openldap-devel gcc python3-psycopg2 python3-postgresql zbar openh264 mumble kmplayer kernel virt-manager @virtualization gource virt-what links sway nm-applet blueman-applet swaync lxpolkit wob wcp wdisplays hyprland hypridle golang gtk3-devel golang-x-tools-toolstash golang-x-arch-devel.noarch waybar pavucontrol-qt wofi pavucontrol arc-theme hyprlock copyq nwg-dock-hyprland nwg-drawer nwg-panel nwg-launchers cascadia-code-nf-fonts hyprpaper btop atop nmap ICAClient perl-Time-HiRes powerline-fonts tmux-powerline asciiquarium lolcat socat rbw pcmanfm qalculate-gtk
~~~

## tmux helping

~~~
<prefix> means you have to either hit Ctrl + a or Ctrl + b
<prefix> c means you have to hit Ctrl + a or Ctrl + b followed by c
<prefix> C-c means you have to hit Ctrl + a or Ctrl + b followed by Ctrl + c
~~~

https://gist.github.com/rbudiharso/53821b3222c4e7a5f7695d8d13cc6058

For Install new tmux addons run this

~~~
TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins .tmux/plugins/tpm/scripts/install_plugins.sh
~~~

## Sources

https://wezfurlong.org/wezterm/install/linux.html#installing-on-linux-via-flathub

https://flatpak.org/setup/Fedora

https://www.chezmoi.io/install/#one-line-binary-install

https://wiki.ubuntuusers.de/usermod/

https://starship.rs/guide/#%F0%9F%9A%80-installation

https://www.nerdfonts.com/font-downloads

https://github.com/gpakosz/.tmux
