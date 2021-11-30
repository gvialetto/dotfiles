export ZDOTDIR="$HOME/.config/zsh"
export DOTFILES="$HOME/.dotfiles"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi
