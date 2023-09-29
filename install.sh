#!/usr/bin/env zsh

PKG=$1

function _info() {
    local msg=$1
    echo -e "\e[34m\e[1m---\e[0m ${msg}"
}

function _fatal() {
    local msg=$1
    echo -e "\e[31m\e[1m!!!\e[0m ${msg}" >&2
    exit 1
}

function _tab {
    local prefix="\t"
    "$@" > >(sed "s/^/$prefix/") 2> >(sed "s/^/$prefix/" >&2)
}

[ $# -eq 1 ] || { echo "Usage: $0 <package/directory>" >&2; exit 1; }
[ -d "${PKG}" ] || { _fatal "Package \e[1m${PKG}\e[0m does not exist. Bailing out."; }
hash stow 2>/dev/null || { _fatal "GNU \e[33mstow\e[39m is required. Please install it."; }

_info "Installing \e[1m${PKG}\e[0m package"

if [ -f "${PKG}/bootstrap.sh" ]; then
    _info "Running installation script: \e[2m${PKG}/bootstrap.sh\e[0m"
    cwd="$(pwd)"
    cd "${PKG}"
    _tab bash ./bootstrap.sh
    [ $? -ne 0 ] && { _fatal "Installation script failed. Bailing out."; }
    cd "${cwd}"
fi

_info "Invoking \e[33mstow\e[39m to create links"
_tab stow -vv "${PKG}"
[ $? -ne 0 ] && { _fatal "Stow has failed. Bailing out"; }
_info "\e[32m\e[1mInstallation complete!\e[0m"