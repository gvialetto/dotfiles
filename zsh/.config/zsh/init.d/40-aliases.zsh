export PAGER="less -R -S -F -X"
export EDITOR="vim"
export VISUAL="vim"
[[ $commands[nvim] ]] && {
  export EDITOR="nvim"
  export VISUAL="nvim"
  alias vim='nvim'
}

alias ls=" ls -hF  --color=always"
[[ "$(uname -s)" = Darwin && $commands[gls] ]] && {
  # if coreutils is installed in OSX, use it
  alias ls=" gls -hF --group-directories-first --color=always"
}
[[ $commands[eza] ]] && {
  # if we have eza, use it
  alias ls=" eza -hF --group-directories-first --color=always"
}
[[ $commands[unarchive] ]] && { alias ex=" unarchive" }
alias mkdir="mkdir -p -v"
alias md="mkdir"
alias rmd="rm -r"
alias x=" exit"