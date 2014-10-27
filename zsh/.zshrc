source ~/.local/share/antigen.git/antigen.zsh

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
git
mercurial
github
fasd
gitignore
gpg-agent
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
gvialetto/oh-my-zsh-custom plugins/aliases
EOBUNDLES

antigen theme gvialetto/oh-my-zsh-custom themes/gvialetto

antigen apply

export BROWSER=$(which google-chrome chromium firefox links | grep -Pm1 '^/')
export PAGER='less'
export EDITOR='vim'
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:c:"

if [ -d /usr/share/source-highlight ]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
fi

setopt nocorrectall

