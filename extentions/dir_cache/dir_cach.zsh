update_directory_list() {
    local pwd_dir="$(pwd)"
    local list_file="$TOPDIRCACHEPATH"

    touch "$list_file"

    # Check if pwd directory already exists in the file
    local found=false
    while IFS= read -r line; do
        dir=$(echo "$line" | awk '{print $1}')
        count=$(echo "$line" | awk '{print $2}')
        
        if [ "$dir" = "$pwd_dir" ]; then
            new_count=$((count + 1))
            echo "$dir $new_count"
            found=true
        else
            echo "$line"
        fi
    done < "$list_file" > "$list_file.tmp"

    if [ "$found" = false ]; then
        echo "$pwd_dir 1" >> "$list_file.tmp"
    fi

    mv "$list_file.tmp" "$list_file"
    sort -nrk2 "$list_file" -o "$list_file"
}

update_last_directory_cache() {
  local dir="$PWD"
  # Append the current directory to the cache file
  echo "$dir" >> "$LASTDIRCACHEPATH"
  # Keep only the last 10 entries in the cache file
  tail -n 100 "$LASTDIRCACHEPATH" > "$LASTDIRCACHEPATH.tmp"
  mv "$LASTDIRCACHEPATH.tmp" "$LASTDIRCACHEPATH"
}

chpwd() {
  update_last_directory_cache
  update_directory_list
}

