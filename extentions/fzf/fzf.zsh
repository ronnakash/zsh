#######################
###### functions ######
#######################

fzf_cd_all() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | 
    fzf-tmux --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    cd "$dir"
}

fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d -not -path '*/\.*' 2>/dev/null | 
    fzf-tmux --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --preview-window=right:70%:wrap --height 70% --reverse +m) && 
    cd "$dir"
}


fzf_magic_all() {
  local dir
  dir=$(find ${1:-.} 2>/dev/null | 
    fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_magic() {
  local dir
  dir=$(find ${1:-.} -not -path '*/\.*' 2>/dev/null | 
    fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_last_dir() {
  local dir
  local recent_dirs=$(tail -n 100 "$LASTDIRCACHEPATH" 2>/dev/null | tac)
  dir=$(printf "%s\n" "$recent_dirs" | 
    fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 40% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_top_dir() {
  local dir
  local top_dirs=$(head -n 100 "$TOPDIRCACHEPATH" 2>/dev/null | awk '{print $1}')
  dir=$(printf "%s\n" "$top_dirs" | 
    fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 40% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_last_file() {
  local dir
  local recent_dirs=$(tail -n 100 "$LASTFILECACHEPATH" 2>/dev/null | tac)
  dir=$(printf "%s\n" "$recent_dirs" | 
    fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 40% --reverse +m) &&
    nvim "$dir"
}

fzf_top_file() {
  local dir
  local top_files=$(head -n 100 "$TOPFILECACHEPATH" 2>/dev/null | awk '{print $1}')
  dir=$(printf "%s\n" "$top_files" | 
    fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 40% --reverse +m) &&
    nvim "$dir"
}

fzf_history() {
  local dir
  local top_files=$(tail -n +2 ~/.zsh_history 2>/dev/null | tail -n 1000 | tac | awk -F';' '{print $2}')
  dir=$(printf "%s\n" "$top_files" | 
    fzf-tmux --height 40% --reverse +m) &&
    eval "$dir"
}

#####################
###### aliases ######
#####################

# find files and directories, opens file in neovim and cds to directories
alias f='fzf_magic'

# like f but includes ignored files and directories
alias fa='fzf_magic_all'

# like f but only shows files
alias ff='fzf --preview "bat --color=always {}" --preview-window=right:70%:wrap --height 40% --reverse --bind="enter:execute(nvim {})"'

# find last visited dirs
alias cl="fzf_last_dir"

# find top most visited dirs
alias ct="fzf_top_dir"

# like f but only shows directories
alias c='fzf_cd'

# like fa but only shows directories
alias ca='fzf_cd_all'

# find last visited dirs
alias fl="fzf_last_file"

# find top most visited dirs
alias ft="fzf_top_file"

alias hs="fzf_history"

chpwd() {
  update_last_directory_cache "$(pwd)"
  update_top_directory_list "$(pwd)"
}
