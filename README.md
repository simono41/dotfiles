# For Install this Dotfiles on Fedora

~~~
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.wezfurlong.wezterm

flatpak run org.wezfurlong.wezterm

alias wezterm='flatpak run org.wezfurlong.wezterm'

sudo usermod -s /bin/zsh simono41

curl -sS https://starship.rs/install.sh | sh

dnf install jetbrains-mono-fonts tmux

sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init -v --apply --force https://code.brothertec.eu/simono41/dotfiles.git
chezmoi update -v --force
~~~

## Sources

https://wezfurlong.org/wezterm/install/linux.html#installing-on-linux-via-flathub

https://flatpak.org/setup/Fedora

https://www.chezmoi.io/install/#one-line-binary-install

https://wiki.ubuntuusers.de/usermod/

https://starship.rs/guide/#%F0%9F%9A%80-installation

https://www.nerdfonts.com/font-downloads

https://github.com/gpakosz/.tmux

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
