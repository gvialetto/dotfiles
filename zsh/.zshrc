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

autoload add2path
# Add paths for standalone apps
if [ -d ~/.local/opt ]; then
  for dir in ~/.local/opt/*; do
    _customapps_path="$dir"
    [ -d ${dir} ] || continue
    if [ -f ${dir}/.mkenv ]; then
      source ${dir}/.mkenv
      continue
    fi
    [ -d ${dir}/bin ] && _customapps_path="${dir}/bin"
    add2path "$_customapps_path"
  done
  unset _customapps_path
fi

# Add paths for local scripts
add2path "$HOME/.bin"
add2path "$HOME/.local/bin"

# Add sources for tools if present
# -- https://github.com/taylor/kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
# -- https://github.com/rbenv/rbenv.git
test -d "$HOME/.rbenv" && {
    add2path "$HOME/.rbenv/bin"
    add2path "$HOME/.rbenv/shims"
    source "$HOME/.rbenv/completions/rbenv.zsh"
}
# Hello Go!
test -d "$HOME/.go" && {
    export GOPATH="$HOME/.go"
    add2path "$GOPATH/bin"
}
# Now that go is configured (maybe) we can use vg
command -v vg >/dev/null 2>&1 && eval "$(vg eval --shell zsh)"

