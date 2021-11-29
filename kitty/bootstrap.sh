#!/usr/bin/env bash

GIT_TAG="master"
NERD_FONTS_URL="https://github.com/ryanoasis/nerd-fonts/raw/${GIT_TAG}/patched-fonts"
FONT_DIR=".local/share/fonts"

mkdir -p "${FONT_DIR}"

function _mkurl() {
    local font=$1
    local type=$(echo $1 | cut -d' ' -f3)
    local name=$(echo $1 | sed 's/ /%20/g')
    echo "${NERD_FONTS_URL}/FiraCode/$type/complete/$name.ttf"
}

fonts=(
    "Fira Code Retina Nerd Font Complete"
    "Fira Code Bold Nerd Font Complete"
)



for font in "${fonts[@]}"; do
    font_file="${FONT_DIR}/$font.ttf"
    [ -f "${font_file}" ] && continue
    echo -e "Downloading \e[2m$font\e[0m font"
    font_url=$(_mkurl "$font")
    curl -sSLo "${font_file}" "${font_url}"
done