#!/usr/bin/env bash
# Use fuzzel to find a password from password-store and copy it to clipboard.
# inpired by: https://gist.github.com/igemnace/2b8609d280752e8a1b173204c14f6892

pass_name=$(bw list items | jq -r '.[].name' | fuzzel -d)

[[ $pass_name != "" ]] && bw get item "$pass_name" | jq -r '.login.password' | wl-copy
