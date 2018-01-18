export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Add paths for standalone apps
test -d ~/.local/opt && {
    for dir in ~/.local/opt/*; do
        test -d "${dir}" || continue
        if [ -d "${dir}/bin" ]; then
            PATH="${dir}/bin:${PATH}"
        else
            PATH="${dir}:${PATH}"
        fi
    done
}

# Add paths for local scripts
PATH="$HOME/.bin:$HOME/.local/bin:${PATH}"
# Add paths for language tools if present
# -- Erlang -- https://github.com/kerl/kerl
command -v kerl >/dev/null 2>&1 && {
    test "$(kerl list installations)" && {
        # HACK: this should work as long as we install all version under the
        # same path
        . $(kerl list installations | sort | cut -d' ' -f2 | tail -1)/activate
    }
}
# -- Elixir -- https://github.com/taylor/kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
# -- Ruby -- https://github.com/rbenv/rbenv.git
test -d "$HOME/.rbenv" && {
    PATH="$HOME/.rbenv/bin:${PATH}"
    PATH="$HOME/.rbenv/shims:${PATH}"
    source "$HOME/.rbenv/completions/rbenv.zsh"
}
# -- Go
test -d "$HOME/.go" && {
    export GOPATH="$HOME/.go"
    PATH="$GOPATH/.bin:${PATH}"
    # Now that go is configured (maybe) we can use vg
    command -v vg >/dev/null 2>&1 && eval "$(vg eval --shell zsh)"
}
# -- Rust
test -d "$HOME/.cargo/bin" && {
    PATH="$HOME/.cargo/bin:${PATH}"
    command -v racer >/dev/null 2>&1 && {
        export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
    }
}

typeset -gU cdpath fpath mailpath path

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
