# Sets up applications/commands for a variety of purposes

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
test -d "$HOME/.local/opt/rbenv" && {
    eval "$(rbenv init -)"
}

# -- Python -- https://github.com/pyenv/pyenv
test -d "$HOME/.local/opt/pyenv" && {
    export PYENV_ROOT="$HOME/.local/opt/pyenv"
    eval "$(pyenv init -)"
}

# -- Go
test -d "$HOME/.go" && {
    export GOPATH="$HOME/.go"
    PATH="$GOPATH/bin:${PATH}"
}

# -- Rust
test -d "$HOME/.cargo/bin" && {
    PATH="$HOME/.cargo/bin:${PATH}"
    command -v racer >/dev/null 2>&1 && {
        export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
    }
}

# -- Android SDK
test -d "$HOME/.local/opt/android-sdk" && {
    export ANDROID_HOME="$HOME/.local/opt/android-sdk"
}

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi