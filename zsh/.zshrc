# Source /etc/profile and related distro files
emulate sh -c 'source /etc/profile'

# Add custom functions to ZSH (this is also used for prompt)
export fpath=("$HOME/.config/zsh/functions" $fpath)

# Initialize zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
else
  # Install prezto (obviously without overriding this file)
  echo "Prezto not found. Initializing..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Environment variables
export BROWSER="$(which google-chrome chromium firefox links 2>/dev/null| grep -Pm1 '^/')"
export PAGER='less'
export EDITOR="$(which vim vi | grep -Pm1 '^/')"

if [ -d /usr/share/source-highlight ]; then
  export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
  export LESS=' -R '
fi

# Set shell options
setopt pushd_ignore_dups
setopt no_correct_all
setopt no_share_history
setopt no_nomatch
setopt no_cdable_vars

# Fix ls colors
if [[ -f ~/.config/zsh/dircolors ]] ; then
  eval $(dircolors -b ~/.config/zsh/dircolors)
fi

# Aliases
alias ls=" ls -hF --group-directories-first --color"
alias ex=" unarchive"
alias mkdir="mkdir -p -v"
alias md="mkdir"
alias rmd="rm -r"
alias x=" exit"

# Bindkeys
bindkey "^R" history-incremental-pattern-search-backward
