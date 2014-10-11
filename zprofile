emulate sh -c 'source /etc/profile'
emulate sh -c 'source ~/.base-config/etc/profile'

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
