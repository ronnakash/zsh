update_top_file_list() {
  local pwd_dir="$(realpath $1)"
  local list_file="$TOPFILECACHEPATH"
  echo "$pwd_dir"

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

update_last_file_cache() {
    local dir="$(realpath $1)"
    local list_file="$LASTFILECACHEPATH"
    
  echo "$dir"

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


# nvim_wrap() {
#   local file=
#   local dir=
#   local is_file=false

#   # Check if an argument is provided
#   if [ -n "$1" ]; then
#     # Check if the provided argument is a file
#     if [ -f "$1" ]; then
#       file="$(realpath "$1")"  # Get the full path of the provided file
#       dir="$(dirname "$file")" # Get the directory of the provided file
#       is_file=true             # Set is_file to true
#     # Check if the provided argument is a directory
#     elif [ -d "$1" ]; then
#       dir="$(realpath "$1")"   # Get the full path of the provided directory
#     else
#       echo "Invalid input: $1 is neither a file nor a directory." >&2
#       return 1
#     fi
#   else
#     dir="$(dirname "$pwd")"               # Use the current directory if no argument is provided
#   fi

#   echo "File: $file"
#   echo "Directory: $dir"
#   echo "Is File: $is_file"

#   if [ "$is_file" = true ]; then
#     update_top_file_list "$file"
#     update_last_file_cache "$file"
#   fi

#   update_last_directory_cache "$dir"
#   update_top_directory_list "$dir"

#   command nvim -c "cd $dir"
# }

# alias nvim="nvim_wrap"
