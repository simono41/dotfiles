# For Install this Dotfiles

~~~
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init -v --apply --force https://code.brothertec.eu/simono41/dotfiles.git
chezmoi update -v --force
~~~

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
