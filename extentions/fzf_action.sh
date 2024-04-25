#!/bin/bash

selected="$1"

if [ -f "$selected" ]; then
    nvim "$selected"
elif [ -d "$selected" ]; then
    cd "$(realpath "$selected")" || { echo "Error: Failed to change directory."; }
fi

