#############################################
################  functions  ################
#############################################

tac() { tail -r -- "$@"; }

###### eza ######


eza_func() {
     local eza_options="$1"
     local level=1
     local remove_level=false

     shift 1

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -d=*|--level=*) 
                if [[ "${1#*=}" == "0" ]]; then
                    remove_level=true
                else
                    level="${1#*=}" 
                fi
                shift 1 
                ;;
            *) 
                echo "Unknown option: $1"
                return 1
                ;;
        esac
    done

    if ! "$remove_level"; then
        eza_options+=" --level=$level"
    fi

     eza_command="eza $eza_options"
     eval "$eza_command"
 }

eza_ll_func() {
     local eza_options="--long --color=always --git --no-filesize --no-time --tree --icons=always"
     eza_func "$eza_options" "$@"
 }

eza_ls_func() {
     local eza_options="--long --color=always --git --no-filesize --no-time --no-user --tree --icons=always --no-permissions"
     eza_func "$eza_options" "$@"
 }

eza_la_func() {
     local eza_options="--long --color=always --git --no-filesize --no-time --tree --icons=always --all"
     eza_func "$eza_options" "$@"
 }

###### GOLANG ######

go_project() {
  local dir
  local ezacmd="eza --long --color=always --git --no-filesize --no-time --tree --level=1 --icons=always {}"
  dir=$(find ${1:-~/golang} -maxdepth 1 -mindepth 1 -type d 2>/dev/null | fzf --preview "$ezacmd" --height 40% --reverse +m) && cd "$dir" && nvim
}

###### PROJECTS ######

# open_project() {
#   opts=`echo "java python go" | tr ' ' '\n'`
#   selected=$(echo "$opts" | fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh ~/repositories/{}' --preview-window=right:70%:wrap --height 40% --reverse +m)
#   dir=$(find "${1:-~/repositories/$selected}" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | fzf --preview "$ezacmd" --height 40% --reverse +m)
#   cd "$dir" || return 1
#   nvim
# }

open_project() {
  local ezacmd="eza --long --color=always --git --no-filesize --no-time --tree --level=1 --icons=always {}"

  opts=`echo "java python go" | tr ' ' '\n'`
  selected=$(echo "$opts" | fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh ~/repositories/{}' --preview-window=right:70%:wrap --height 40% --reverse +m)

  # TODO: dont show whole path to pick, just project name
  dir=$(find "${1:-$HOME/repositories/$selected}" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | fzf --preview "$ezacmd" --height 40% --reverse +m)
  cd "$dir"
  nvim
}

###### etc ######


klog_func() {
  local pod_name
  pod_name=$(kubectl get pods | grep "$1" | awk '{print $1}')
  pod_name=$(echo "$pod_name" | tr -d '\r')
  if [ -n "$pod_name" ]; then
    kubectl logs "$pod_name"
  else
    echo "Error: No matching pod found."
  fi
}

# TODO: watch is better
repeat_command() {
    local command="$1"
    local interval="${2:-1}" # Default interval is 1 second
    while true; do
        eval "$command"
        sleep "$interval"
    done
}
