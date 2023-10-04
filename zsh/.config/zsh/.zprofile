[ -s "/opt/homebrew/bin/brew" ] && {
    eval "$(/opt/homebrew/bin/brew shellenv)"

    fpath=("/opt/homebrew/share/zsh/site-functions" $fpath)
}