# Installation Guide for a good MacOS System
## Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install Config Manager

~~~
brew install chezmoi
chezmoi init -v --apply ssh://git@brothertec.eu:1023/simono41/dotfiles.git
~~~

## Install some Terminal Tools
~~~
brew install starship
brew install zsh-completions
brew install zsh-autosuggestion
brew install zsh-autocomplete
brew install fzf
brew install ruby
brew install gnupg
brew install htop
brew install btop
brew install asciiquarium
brew install lolcat
~~~

## Install Password Manager
~~~
brew install pass
brew install pass-otp
brew install pinentry-mac
brew install qtpass
brew tap amar1729/formulae
brew install browserpass
PREFIX='/opt/homebrew/opt/browserpass' make hosts-firefox-user -f '/opt/homebrew/opt/browserpass/lib/browserpass/Makefile'
change gpg path in firefox to /opt/homebrew/bin/gpg
~~~

## Install Tiny Window Manager
~~~
brew install koekeishiya/formulae/yabai
If you are using the scripting-addition; remember to update your sudoers file:
  sudo visudo -f /private/etc/sudoers.d/yabai

Build the configuration row by running:
  echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa

brew install koekeishiya/formulae/skhd
~~~

## Install Clipboard Manager
~~~
brew install jq
brew install choose-gui
brew install rg
brew install --cask flycut
~~~

## Install Fonts
~~~
brew tap homebrew/cask-fonts
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code
brew install --cask font-finagler
~~~

## Install some Tools for Jetrains
~~~
brew install kdoctor
brew install cocoapods
~~~

