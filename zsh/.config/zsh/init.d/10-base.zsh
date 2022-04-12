# Set up basic configuration

typeset -gU cdpath fpath mailpath path

# Disable bells
unsetopt beep

mkdir -p "$HOME/.local/bin" "$ZDOTDIR/bin" "$ZDOTDIR/data/completions"
path=("$HOME/.local/bin" "$ZDOTDIR/bin" $path)
fpath=("$ZDOTDIR/data/completions" $fpath)

export EDITOR='vim'
export VISUAL="vim"
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# replace vim with nvim if available
[[ $commands[nvim] ]] && {
    export EDITOR='nvim'
    export VISUAL="nvim"
    alias vim='nvim'
}

alias ls=" exa -hF --group-directories-first --color=always"
alias ex=" unarchive"
alias mkdir="mkdir -p -v"
alias md="mkdir"
alias rmd="rm -r"
alias x=" exit"