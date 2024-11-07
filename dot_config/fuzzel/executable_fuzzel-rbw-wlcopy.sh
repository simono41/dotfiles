#!/usr/bin/env bash
# Use fuzzel to find a password from password-store and copy it to clipboard.
# inpired by: https://gist.github.com/igemnace/2b8609d280752e8a1b173204c14f6892

pass_name=$(rbw list | fuzzel -d)

[[ $pass_name != "" ]] && rbw get "$pass_name" | wl-copy
