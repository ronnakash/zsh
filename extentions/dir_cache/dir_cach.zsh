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

chpwd() {
  update_last_directory_cache
  update_directory_list
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
  local recent_dirs=$(head -n 10 "$TOPDIRCACHEPATH" 2>/dev/null | awk '{print $1}')
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 12 --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

alias fl="fzf_last_ten"
alias ft="fzf_top_ten"
