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

# Prompt
zinit ice depth=1 lucid nocd
zinit light romkatv/powerlevel10k

# Plugins
zinit wait lucid depth=1 for \
        urbainvaes/fzf-marks \
        Aloxaf/fzf-tab \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atpull'zinit creinstall -q .' blockf \
        zsh-users/zsh-completions \
    atload'!_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
        softmoth/zsh-vim-mode \
        zdharma-continuum/history-search-multi-word

unset ZINIT_HOME ZINIT_REPO