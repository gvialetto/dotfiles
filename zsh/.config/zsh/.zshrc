# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Local zshrc
[ -d "${ZDOTDIR}/local.d" ] && for f in ${ZDOTDIR}/local.d/*.zsh; do source $f; done
[ -d "${ZDOTDIR}/init.d" ] && for f in ${ZDOTDIR}/init.d/*.zsh; do source $f; done

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[ -f "${ZDOTDIR}/.p10k.zsh" ] && source "${ZDOTDIR}/.p10k.zsh"
