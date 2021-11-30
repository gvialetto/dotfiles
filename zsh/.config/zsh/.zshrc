# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install zinit if not present
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
ZINIT_REPO="https://github.com/zdharma-continuum/zinit.git"

if [[ ! -d "${ZINIT_HOME}" ]]; then
    mkdir -p "$(dirname ${ZINIT_HOME})"
    git clone "${ZINIT_REPO}" "${ZINIT_HOME}"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Loads language/SDK related environment/completions/etc.
source "${ZDOTDIR}/init-tools.zsh"

# Prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Oh my zsh plugins
zinit wait lucid for \
	OMZL::clipboard.zsh \
	OMZL::compfix.zsh \
	OMZL::completion.zsh \
	OMZL::correction.zsh \
    atload"
        alias ..='cd ..'
        alias ...='cd ../..'
        alias ....='cd ../../..'
        alias .....='cd ../../../..'
    " \
	OMZL::directories.zsh \
	OMZL::git.zsh \
	OMZL::grep.zsh \
	OMZL::history.zsh \
	OMZL::key-bindings.zsh \
	OMZL::spectrum.zsh \
	OMZL::termsupport.zsh \
	OMZP::git \
	OMZP::fzf \
    OMZP::kubectl 

# Plugins
zinit wait lucid for \
    light-mode depth=1 atinit'ZVM_INIT_MODE=sourcing' \
        jeffreytse/zsh-vi-mode \
    light-mode blockf atpull'zinit creinstall -q .' \
    atinit"
        zstyle ':completion:*' completer _expand _complete _ignored _approximate
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*' menu select=2
        zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
        zstyle ':completion:*:descriptions' format '-- %d --'
        zstyle ':completion:*:processes' command 'ps -au\$USER'
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:*:*:*:*:processes' command 'ps -u \$USER -o pid,user,comm,cmd -w -w'
    " \
        zsh-users/zsh-completions \
    light-mode atinit"
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always \$realpath'
        zstyle ':fzf-tab:complete:exa:*' fzf-preview 'exa -1 --color=always \$realpath'
        zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man \$word'
    " \
        Aloxaf/fzf-tab \
    light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20;" atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    light-mode atinit"typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    light-mode bindmap"^R -> ^H" atinit"
        zstyle :history-search-multi-word page-size 20
        zstyle :history-search-multi-word highlight-color fg=red,bold
        zstyle :plugin:history-search-multi-word reset-prompt-protect 1
    " \
        zdharma-continuum/history-search-multi-word

export EDITOR='nvim'
export VISUAL="nvim"
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

alias vim='nvim'
alias ls=" exa -hF --group-directories-first --color=always"
alias ex=" unarchive"
alias mkdir="mkdir -p -v"
alias md="mkdir"
alias rmd="rm -r"
alias x=" exit"

typeset -gU cdpath fpath mailpath path

# Disable bells
unsetopt beep

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
