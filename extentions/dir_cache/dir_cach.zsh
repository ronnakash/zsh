# Function to update directory cache with the latest directories
update_last_directory_cache() {
  local dir="$PWD"
  # Append the current directory to the cache file
  echo "$dir" >> "$LASTDIRCACHEPATH"
  # Keep only the last 10 entries in the cache file
  tail -n 10 "$LASTDIRCACHEPATH" > "$LASTDIRCACHEPATH.tmp"
  mv "$LASTDIRCACHEPATH.tmp" "$LASTDIRCACHEPATH"
}

update_top_directory_cache() {
  set -x

  local dir="$PWD"
  local cache_file="$TOPDIRCACHEPATH"
  
  # Create cache file if it doesn't exist
  touch "$cache_file"
  touch "$cache_file".tmp

  # Initialize associative array if not already defined
  declare -A visited_dirs

  # Read existing cache file to populate visited_dirs array
  while IFS= read -r line; do
    if [[ -n "$line" ]]; then
      ((visited_dirs["$line"]++))
    fi
  done < "$cache_file"

  # Increment visit count for current directory
  ((visited_dirs["$dir"]++))

  # Sort and limit to top 10 visited directories
  sorted_keys=($(printf "%s\n" "${!visited_dirs[@]}" | sort -nrk2,2 | head -n 10))
  for key in "${sorted_keys[@]}"; do
    echo "$key" >> "$cache_file.tmp"
  done

  mv "$cache_file.tmp" "$cache_file"
}


chpwd() {
  update_last_directory_cache
  update_top_directory_cache
}

most_visited_dirs() {
  local cache_file="$TOPDIRCACHEPATH"

  # Read visit counts from cache file
  declare -A visited_dirs
  while IFS= read -r line; do
    if [[ -n "$line" ]]; then
      visited_dirs["$line"]=$(grep -c "^$line$" "$cache_file")
    fi
  done < "$cache_file"

  # Display top 10 most visited directories
  printf "%s\n" "${!visited_dirs[@]}" | sort -nrk2,2 | head -n 10
}

fzf_last_ten() {
  local dir
  # Read last 10 directories from cache
  local recent_dirs=$(tail -n 10 "$LASTDIRCACHEPATH" 2>/dev/null)
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 10 --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_top_ten() {
  local dir
  # Read last 10 directories from cache
  local recent_dirs=$(tail -n 10 "$TOPDIRCACHEPATH" 2>/dev/null)
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 10 --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

alias fl="fzf_last_ten"
alias ft="fzf_top_ten"
