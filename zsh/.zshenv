export ZDOTDIR="$HOME/.config/zsh"
export DOTFILES="$HOME/.dotfiles"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

[ -z "${LANG}" ] && export LANG='en_US.UTF-8'
[ -f "${ZDOTDIR}/.zshenv-local" ] && source "${ZDOTDIR}/.zshenv-local"
