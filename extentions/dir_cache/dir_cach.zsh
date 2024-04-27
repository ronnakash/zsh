update_top_directory_list() {
    local pwd_dir="$1"
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
    local dir="$1"
    local list_file="$LASTDIRCACHEPATH"
    
    # Remove existing occurrences of the directory from the cache file
    if [ -f "$list_file" ]; then
        # Use grep to filter out the directory from the cache file
        grep -vFx "$dir" "$list_file" > "$list_file.tmp"
        mv "$list_file.tmp" "$list_file"
    fi

    # Append the current directory to the cache file
    echo "$dir" >> "$list_file"

    # Keep only the last 100 entries in the cache file (adjust as needed)
    tail -n 100 "$list_file" > "$list_file.tmp"
    mv "$list_file.tmp" "$list_file"
}

