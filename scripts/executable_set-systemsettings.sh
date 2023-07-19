#!/bin/bash

set -e

user=user1

if cat /etc/passwd | grep "x:1000" > /dev/null; then
    tempuser=$(cat /etc/passwd | grep "x:1000" | awk '{print $1}')
    user=${tempuser%%:*}
#else
#    user=$(whoami)
fi

for wort in $(cat /proc/cmdline)
do
    echo "Parameter ${wort%=*} = ${wort#*=}"
    if ! export ${wort%=*}=${wort#*=}; then echo "cannot export ${wort}!!!"; fi
done

# set systemconfiguration

if ! cat /etc/locale.conf | grep LANG=${lang}.UTF-8 1>/dev/null 2>&1; then
    echo "LANG=${lang}.UTF-8" > /etc/locale.conf
    echo "LC_COLLATE=C" >> /etc/locale.conf
    echo "LANGUAGE=${lang}" >> /etc/locale.conf

    echo "${lang}.UTF-8 UTF-8" > /etc/locale.gen
    echo "${lang} ISO-8859-1" >> /etc/locale.gen
    #echo "${lang}@euro ISO-8859-15" >> /etc/locale.gen
    if ! grep 'en_US.UTF-8 UTF-8' /etc/locale.gen 1>/dev/null 2>&1; then
        echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    fi

    locale-gen
fi

keytable_short="${keytable:0:2}"
echo "KEYMAP=${keytable_short}" > /etc/vconsole.conf
echo "FONT=lat9w-16" >> /etc/vconsole.conf
if [ -f "/etc/conf.d/keymaps" ]; then
    sed -i 's/keymap=.*$/keymap=\"'$keytable_short'\"/' /etc/conf.d/keymaps
fi

sed -e 's|Option "XkbLayout".*$|Option "XkbLayout" "'$keytable_short'"|' -i /etc/X11/xorg.conf.d/20-keyboard.conf
if [ "$keytable_short" != "de" ]; then
    sed -e 's|    xkb_layout.*$|    xkb_layout '$keytable_short',de|' -i /home/${user}/.config/sway/config
fi

# https://stackoverflow.com/questions/5767062/how-to-check-if-a-symlink-exists
if [ -L /etc/localtime ]; then
    rm /etc/localtime
fi
ln -s /usr/share/zoneinfo/"${tz}" /etc/localtime

