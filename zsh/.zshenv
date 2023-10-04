export ZDOTDIR="$HOME/.config/zsh"
export DOTFILES="$HOME/.dotfiles"

[ -z "${LANG}" ] && export LANG='en_US.UTF-8'
[ -f "${ZDOTDIR}/.zshenv-local" ] && source "${ZDOTDIR}/.zshenv-local"
