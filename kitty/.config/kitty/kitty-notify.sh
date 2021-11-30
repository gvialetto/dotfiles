#!/usr/bin/env bash

app="$(basename ${KITTY_CHILD_CMDLINE})"

notify-send \
    -i terminal \
    -t 3000 \
    "Terminal notification" \
    "$app requires attention"
