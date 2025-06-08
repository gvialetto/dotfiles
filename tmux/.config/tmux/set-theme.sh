#!/usr/bin/env bash
# Sets up the appropriate tmux theme and spins a backround process
# to ensure if gnome session changes theme we follow it

readonly TMUX_THEMES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEFAULT_THEME="$TMUX_THEMES_DIR/tokyonight_night.tmux"

if ! command -v gsettings >/dev/null 2>&1; then
  tmux source-file "$DEFAULT_THEME"
  exit
fi

if [ "${DESKTOP_SESSION:-}" != "gnome" ]; then
  tmux source-file "$DEFAULT_THEME"
  exit
fi

function tmux_get_theme_from_gnome_scheme() {
  local colorscheme=$1
  [ -z "$colorscheme" ] && colorscheme="$(gsettings get org.gnome.desktop.interface color-scheme)"
  if [[ "$colorscheme" =~ .*dark.* ]]; then
    echo "$TMUX_THEMES_DIR/tokyonight_night.tmux"
  else
    echo "$TMUX_THEMES_DIR/tokyonight_day.tmux"
  fi
}
export -f tmux_get_theme_from_gnome_scheme

function tmux_bg_monitor_color_scheme {
  # HACK: set-hook won't actually work from the "main" thread, so we have to set it here
  # after sleeping a while to allow tmux to create the actual session...
  sleep 1
  # FIXME: session hooks are broken in tmux, we MUST use -g here
  # see https://github.com/tmux/tmux/issues/1245
  tmux set-hook -g session-closed "run-shell \"pkill -P $$\""

  gsettings monitor org.gnome.desktop.interface color-scheme | while read -r scheme; do
    tmux source-file "$(tmux_get_theme_from_gnome_scheme \""$scheme"\")"
  done
}
export -f tmux_bg_monitor_color_scheme

tmux source-file "$(tmux_get_theme_from_gnome_scheme)"
export TMUX TMUX_THEMES_DIR
nohup bash -c tmux_bg_monitor_color_scheme >&/dev/null &
