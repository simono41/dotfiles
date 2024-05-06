# For Install this Dotfiles on Fedora

## Dotfiles

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

## Install Browserpass

~~~
sudo dnf install go

git clone https://github.com/browserpass/browserpass-native.git

cd browserpass-native

make configure
sudo make hosts-firefox-user 
sudo make install

and install this plugin in firefox

https://addons.mozilla.org/de/firefox/addon/browserpass-ce/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search
~~~

## Install Shortcuts in Plasma

~~~
sudo dnf install papirus-icon-theme ripgrep fuzzel
~~~

add the kde-autostart.sh script in scripts folder to the autostart in the plasma settings.

add fuzzel for showing programs
and .config/fuzzel/fuzzel-pass.sh (with ~/.config/fuzzel/fuzzel-pass.sh >> /home/simono41/password-store.log) for showing passwords
and instead of using that .config/fuzzel/fuzzel-clipman.sh (with clipman alternative clipman pick --tool=CUSTOM --tool-args="fuzzel -d") for showing clipboards to the shourtcuts in the plasma settings

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
