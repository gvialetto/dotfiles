export ZDOTDIR="$HOME/.config/zsh"
export DOTFILES="$HOME/.dotfiles"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Add standalone apps under ~/.local/opt to PATH
test -d ~/.local/opt && {
    for dir in ~/.local/opt/*; do
        test -d "${dir}" || continue
        if [ -d "${dir}/bin" ]; then
            PATH="${dir}/bin:${PATH}"
        else
            PATH="${dir}:${PATH}"
        fi
    done
}