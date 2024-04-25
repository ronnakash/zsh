#!/bin/bash

selected="$1"

if [ -f "$selected" ]; then
    batcat --color=always "$selected"
elif [ -d "$selected" ]; then
    eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always  "$selected"
fi

