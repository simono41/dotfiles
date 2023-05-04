#!/usr/bin/env bash
# Use fuzzel to find a password from password-store and copy it to clipboard.
# inpired by: https://gist.github.com/igemnace/2b8609d280752e8a1b173204c14f6892

pass_name=$(cd $HOME/.password-store && rg --files | sed 's/\.gpg$//' | fuzzel -d -w 60 -D yes)

[[ $pass_name != "" ]] && pass show -c $pass_name
