# Local zshrc
[ -d "${ZDOTDIR}/local.d" ] && for f in ${ZDOTDIR}/local.d/*.zsh; do source $f; done
[ -d "${ZDOTDIR}/init.d" ] && for f in ${ZDOTDIR}/init.d/*.zsh; do source $f; done

[[ $commands[oh-my-posh] ]] && {
  [ "$TERM_PROGRAM" != "Apple_Terminal" ] && eval "$(oh-my-posh init zsh --config ~/.config/zsh/oh-my-posh/lean.omp.json)"
}