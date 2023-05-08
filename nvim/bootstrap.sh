#!/usr/bin/env bash

readonly DIR="~/.config/nvim"
if [ ! -d "$DIR" ] || [ ! -d "$DIR/.git" ]; then
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim "$DIR"
  nvim --headless -c 'autocmd User LazyDone quitall'
fi 
