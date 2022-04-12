# Download base utilities that may or may not be available in the OS

# ls_colors => https://github.com/trapd00r/LS_COLORS
function _gv_data_ls_color() {
    local base_url="https://raw.githubusercontent.com"
    local ls_color_sh="${ZDOTDIR}/data/ls_color.sh"
    [ -f "${ls_color_sh}" ] || \
        curl -Ls "${base_url}/trapd00r/LS_COLORS/master/lscolors.sh" \
            -o "${ls_color_sh}"
    source "${ls_color_sh}"
}
_gv_data_ls_color

# fzf => https://github.com/junegunn/fzf
function _gv_bin_fzf() {
    local version="0.30.0"
    local base_url="https://github.com/junegunn/fzf/releases/download"
    local fzf_bin="${ZDOTDIR}/bin/fzf"
    [ -f "${fzf_bin}" ] || {
        curl -Ls "${base_url}/${version}/fzf-${version}-linux_amd64.tar.gz" \
        | tar xz -C "${ZDOTDIR}/bin"
        chmod 700 "${fzf_bin}"
    }
    local base_url="https://raw.githubusercontent.com/junegunn/fzf/"
    local fzf_tmux_bin="${ZDOTDIR}/bin/fzf-tmux"
    [ -f "${fzf_tmux_bin}" ] || {
        curl -Ls "${base_url}/${version}/bin/fzf-tmux" -o "${fzf_tmux_bin}"
        chmod 700 "${fzf_tmux_bin}"
    }
    [[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
}
_gv_bin_fzf

# ripgrep => https://github.com/BurntSushi/ripgrep/
function _gv_bin_ripgrep() {
    local version="13.0.0"
    local base_url="https://github.com/BurntSushi/ripgrep/releases/download"
    local filename="ripgrep-${version}-x86_64-unknown-linux-musl"
    local rg_bin="${ZDOTDIR}/bin/rg"
    [ -f "${rg_bin}" ] || {
        local tmpfile=$(mktemp /tmp/ripgrep.tar.gz.XXXXXX)
        curl -Ls "${base_url}/${version}/${filename}.tar.gz" -o "${tmpfile}"
        tar xz -f "${tmpfile}" --strip-components=1 \
            -C "${ZDOTDIR}/bin" "${filename}"/rg
        chmod 700 "${rg_bin}"
        tar xz -f "${tmpfile}" --strip-components=2 \
            -C "${ZDOTDIR}/data/completions" "${filename}"/complete/_rg
        rm -f ${tmpfile}
    }
}
_gv_bin_ripgrep

# exa => https://github.com/ogham/exa
function _gv_bin_exa() {
    local version=v0.10.1
    local base_url="https://github.com/ogham/exa/releases/download"
    local filename="exa-linux-x86_64-${version}"
    local exa_bin="${ZDOTDIR}/bin/exa"
    [ -f "${exa_bin}" ] || {
        local tmpdir=$(mktemp -d /tmp/exa.zip.XXXXXX)
        unzip -qq =(curl -Ls "${base_url}/${version}/${filename}.zip") -d "${tmpdir}"
        cp "${tmpdir}/bin/exa" "${exa_bin}"
        chmod 700 "${exa_bin}"
        cp "${tmpdir}/completions/exa.zsh" "${ZDOTDIR}/data/completions/_exa"
        rm -rf "${tmpdir}"
    }
}
_gv_bin_exa