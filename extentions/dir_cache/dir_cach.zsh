# Function to update directory cache with the latest directories
update_directory_cache() {
  local dir="$PWD"
  # Append the current directory to the cache file
  echo "$dir" >> "$DIRCACHEPATH"
  # Keep only the last 10 entries in the cache file
  tail -n 10 "$DIRCACHEPATH" > "$DIRCACHEPATH.tmp"
  mv "$DIRCACHEPATH.tmp" "$DIRCACHEPATH"
}

chpwd() {
  # command cd "$@"
  update_directory_cache
}

fzf_last_ten() {
  local dir
  # Read last 10 directories from cache
  local recent_dirs=$(tail -n 10 "$DIRCACHEPATH" 2>/dev/null)
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 70% --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

alias fl="fzf_last_ten"
