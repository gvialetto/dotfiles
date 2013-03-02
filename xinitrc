#!/bin/sh

#
# ~/.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


#xset +fp /usr/share/fonts/artwiz-fonts &
xrdb -merge ~/.config/Xresources &
#exec ssh-agent ck-launch-session awesome
#feh --bg-scale ~/images/papers/background.png &
setxkbmap -option layout: it
xmodmap ~/.config/Xmodmap
urxvtd &
eval $(gpg-agent --daemon) &
feh --bg-max "$(find ~/images/wallpapers/|shuf -n1)"
redshift -l 45.61:8.9 &
exec ssh-agent i3
