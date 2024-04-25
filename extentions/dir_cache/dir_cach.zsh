update_directory_list() {
    local pwd_dir="$(pwd)"
    local list_file="$TOPDIRCACHEPATH"

    # Check if file exists, if not, create it with empty content
    touch "$list_file"

    # Check if pwd directory already exists in the file
    local found=false
    while IFS= read -r line; do
        dir=$(echo "$line" | awk '{print $1}')
        count=$(echo "$line" | awk '{print $2}')
        
        if [ "$dir" = "$pwd_dir" ]; then
            # Directory found, increment count
            new_count=$((count + 1))
            echo "$dir $new_count"
            found=true
        else
            echo "$line"
        fi
    done < "$list_file" > "$list_file.tmp"

    if [ "$found" = false ]; then
        # Directory not found, add it with count 1
        echo "$pwd_dir 1" >> "$list_file.tmp"
    fi

    # Sort the list by occurrence count (assuming already sorted)
    mv "$list_file.tmp" "$list_file"
    sort -nrk2 "$list_file" -o "$list_file"
}

# Function to update directory cache with the latest directories
update_last_directory_cache() {
  local dir="$PWD"
  # Append the current directory to the cache file
  echo "$dir" >> "$LASTDIRCACHEPATH"
  # Keep only the last 10 entries in the cache file
  tail -n 10 "$LASTDIRCACHEPATH" > "$LASTDIRCACHEPATH.tmp"
  mv "$LASTDIRCACHEPATH.tmp" "$LASTDIRCACHEPATH"
}

# update_top_directory_cache() {
#   local dir="$PWD"
#   local cache_file="$TOPDIRCACHEPATH"
#
#   # Create cache file if it doesn't exist
#   touch "$cache_file"
#   touch "$cache_file.tmp"
#
#   # Read existing cache file into associative array
#   declare -A visited_dirs
#   while IFS= read -r line; do
#     if [[ -n "$line" ]]; then
#       # Extract directory path and visit count from cache line
#       directory="${line%:*}"
#       count="${line#*:}"
#       visited_dirs["$directory"]=$count
#     fi
#   done < "$cache_file"
#
#   # Increment visit count for current directory
#   if [[ -n "${visited_dirs["$dir"]}" ]]; then
#     ((visited_dirs["$dir"]++))
#   else
#     visited_dirs["$dir"]=1
#   fi
#
#   # Sort directories by visit count in descending order and retrieve top 10
#   sorted_keys=()
#   while IFS= read -r line; do
#     echo "Read line: $line"
#     sorted_keys+=("$line")
#   done < <(printf "%s\n" "${!visited_dirs[@]}" | sort -t: -nrk2,2)
#
#   # Write sorted directories back to cache file
#   printf "%s\n" "${sorted_keys[@]}" > "$cache_file"
# }






chpwd() {
  update_last_directory_cache
  update_directory_list
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
  local recent_dirs=$(tail -n 10 "$LASTDIRCACHEPATH" 2>/dev/null | tac)
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 12 --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_top_ten() {
  local dir
  # Read last 10 directories from cache
  local recent_dirs=$(tail -n 10 "$TOPDIRCACHEPATH" 2>/dev/null | awk '{print $1}')
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 12 --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

alias fl="fzf_last_ten"
alias ft="fzf_top_ten"
