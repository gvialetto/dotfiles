# --- OH MY ZSH CONFIGURATION
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gvialetto"
# CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="false"
plugins=(git mercurial github gitignore.io aliases zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# --- exported ENV
if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

export BROWSER='firefox'
export PAGER=less
export EDITOR='vim'
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:c:"
export PATH=$PATH:$HOME/.bin

if [ -d /usr/share/source-highlight ]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
fi
