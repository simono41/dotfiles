#!/usr/bin/env bash
# Use fuzzel to find a password from password-store and copy it to clipboard.
# inpired by: https://gist.github.com/igemnace/2b8609d280752e8a1b173204c14f6892

clip_name=$(cd $HOME/Library/Containers/com.generalarcade.flycut/Data/Library/Preferences && plutil -convert json com.generalarcade.flycut.plist && cat com.generalarcade.flycut.plist | jq '.store.jcList[] | {Contents} | join(" ")' | sed -e 's/[^.]//;s/.$//' | choose)

[[ $clip_name != "" ]] && echo $clip_name | pbcopy
