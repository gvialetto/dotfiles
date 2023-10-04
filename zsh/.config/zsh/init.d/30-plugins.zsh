
ZGEN_HOME="$ZDOTDATADIR/zgenom"
ZGEN_DIR="$ZDOTDATADIR/plugins"

[[ -f "$ZGEN_HOME/zgenom.zsh" ]] || {
  mkdir -p "$ZGEN_HOME"
  pushd $ZGEN_HOME
  git clone https://github.com/jandamm/zgenom.git .
  popd
}
source "$ZGEN_HOME/zgenom.zsh"

zgenom autoupdate

if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom ohmyzsh  # removing this will lead to issues later, don't.

    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load zsh-users/zsh-history-substring-search

    zgenom oh-my-zsh plugins/fzf
    [[ "$(uname -s)" = Darwin ]] && {
        zgenom ohmyzsh plugins/brew
        zgenom ohmyzsh plugins/macos
    }

    zgenom load zsh-users/zsh-completions src
    zgenom load zsh-users/zsh-autosuggestions

    zgenom load romkatv/powerlevel10k powerlevel10k

    zgenom save
    zgenom compile $ZDOTDIR
fi
