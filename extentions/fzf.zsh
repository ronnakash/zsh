#########################################
################## FZF ##################
#########################################


fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --preview-window=right:70%:wrap --height 70% --reverse +m) && cd "$dir"
}

# TODO: ff to find file, fd to find folder, f for all
alias ff='fzf --preview "batcat --color=always {}" --preview-window=right:70%:wrap --height 40% --reverse --bind="enter:execute(nvim {})"'
alias c='fzf_cd'

fzf_magic() {
  local dir
  dir=$(find ${1:-.} 2>/dev/null | fzf --preview '~/.config/zshconfig/extentions/fzf_print.sh {}' --preview-window=right:70%:wrap --height 70% --reverse +m) &&
    source ~/.config/zshconfig/extentions/fzf_action.sh "$dir"
}

alias f='fzf_magic'
