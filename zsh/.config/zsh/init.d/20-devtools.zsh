# Sets up applications/commands for a variety of purposes

# Add standalone apps under ~/.local/opt to PATH
for dir in ~/.local/opt/*(N); do
    [ -d "${dir}/bin" ]; { path=("${dir}/bin" $path); continue }
    [ -d "${dir}" ]; { path=("${dir}" $path) }
done

# -- Erlang -- https://github.com/kerl/kerl
[[ $commands[kerl] ]] && {
    test "$(kerl list installations | grep -v 'no installations')" && {
        # HACK: this should work as long as we install all version under the
        # same path
        . $(kerl list installations | sort | cut -d' ' -f2 | tail -1)/activate
    }
}

# -- Elixir -- https://github.com/taylor/kiex
[ -s "$HOME/.kiex/scripts/kiex" ] && source "$HOME/.kiex/scripts/kiex"

# -- Ruby -- https://github.com/rbenv/rbenv.git
[ -d "$HOME/.local/opt/rbenv" ] && eval "$(rbenv init -)"

# -- Python -- https://github.com/pyenv/pyenv
[ -d "$HOME/.local/opt/pyenv" ] && {
    export PYENV_ROOT="$HOME/.local/opt/pyenv"
    eval "$(pyenv init -)"
}

# -- Go
[ -d "$HOME/.go" ] && {
    export GOPATH="$HOME/.go"
    path=("$GOPATH/bin" $path)
}

# -- Rust
[ -d "$HOME/.cargo/bin" ] && path=("$HOME/.cargo/bin" $path)
[[ $command[racer] ]] && \
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# -- Android SDK
[ -d "$HOME/.local/opt/android-sdk" ] && {
    export ANDROID_HOME="$HOME/.local/opt/android-sdk"
}

# -- NVM/NPM
[ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"