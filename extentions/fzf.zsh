#########################################
################## FZF ##################
#########################################


fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --height 40% --reverse +m) && cd "$dir"
}

# TODO: ff to find file, fd to find folder, f for all
alias f='fzf --preview "batcat --color=always {}" --height 40% --reverse --bind="enter:execute(nvim {})"'
alias c='fzf_cd'
