#######################
###### functions ######
#######################

fzf_cd_all() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | 
    fzf --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    cd "$dir"
}

fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d -not -path '*/\.*' 2>/dev/null | 
    fzf --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --preview-window=right:70%:wrap --height 70% --reverse +m) && 
    cd "$dir"
}


fzf_magic_all() {
  local dir
  dir=$(find ${1:-.} 2>/dev/null | 
    fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_magic() {
  local dir
  dir=$(find ${1:-.} -not -path '*/\.*' 2>/dev/null | 
    fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_last_ten() {
  local dir
  local recent_dirs=$(tail -n 100 "$LASTDIRCACHEPATH" 2>/dev/null | tac)
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 40% --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}

fzf_top_ten() {
  local dir
  local recent_dirs=$(head -n 100 "$TOPDIRCACHEPATH" 2>/dev/null | awk '{print $1}')
  dir=$(printf "%s\n" "$recent_dirs" | fzf --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh {}' --preview-window=right:70%:wrap --height 40% --reverse +m) &&
  source ~/.config/zshconfig/extentions/fzf/fzf_action.sh "$dir"
}


#####################
###### aliases ######
#####################

# find files and directories, opens file in neovim and cds to directories
alias f='fzf_magic'

# like f but includes ignored files and directories
alias fa='fzf_magic_all'

# like f but only shows files
alias ff='fzf --preview "batcat --color=always {}" --preview-window=right:70%:wrap --height 40% --reverse --bind="enter:execute(nvim {})"'

# find last 10 visited dirs
alias fl="fzf_last_ten"

# find top 10 most visited dirs
alias ft="fzf_top_ten"

# like f but only shows directories
alias c='fzf_cd'

# like fa but only shows directories
alias ca='fzf_cd_all'

