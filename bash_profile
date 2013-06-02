# Autostart X at login on TTY1
# We don't care what happens after.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
