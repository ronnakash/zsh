#!/bin/bash

selected="$1"

# TODO: select level
if [ -f "$selected" ]; then
    batcat --color=always "$selected"
elif [ -d "$selected" ]; then
    eza --long --color=always --git --no-filesize --no-time --tree --level=1 --icons=always  "$selected"
fi

