export HISTFILE="$ZDOTDATADIR/zsh_history"    # History filepath
export HISTSIZE=10000000                   # Maximum events for internal history
export SAVEHIST=10000000                # Maximum events in history file

setopt HIST_IGNORE_SPACE
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Dump the last 20 history entries to make !number more convenient to use.
alias zh="fc -l -d -D"