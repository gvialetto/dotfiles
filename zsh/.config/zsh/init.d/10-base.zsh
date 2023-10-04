# Set up basic configuration

typeset -gU cdpath fpath mailpath path
 
path=("$HOME/.local/bin" $path)

export ZDOTDATADIR="$ZDOTDIR/data"
[ -d "$ZDOTDATADIR" ] || mkdir -p $ZDOTDATADIR
