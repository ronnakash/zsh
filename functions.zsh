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
  # TODO: IMPORTANT!! abort on not selected after both picks
  local ezacmd="eza --long --color=always --git --no-filesize --no-time --tree --level=1 --icons=always {}"

  opts=`echo "java python go" | tr ' ' '\n'`
  selected=$(echo "$opts" | fzf-tmux --preview '~/.config/zshconfig/extentions/fzf/fzf_print.sh ~/repositories/{}' --preview-window=right:70%:wrap --height 40% --reverse +m)

  # TODO: dont show whole path to pick, just project name
  dir=$(find "${1:-$HOME/repositories/$selected}" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | fzf --preview "$ezacmd" --height 40% --reverse +m)
  cd "$dir" || exit 1
  nvim
}

alias proj="open_project"

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

toggle_docker() {
  if [ "$(docker ps -q)" ]; then
    docker-compose down
  else
  docker-compose up -d
  fi
}

awslogin() {
  echo "Enter MFA"
  read mfa
  ~/repositories/java/devops-source/scripts/mfatoken.sh ron.nakash "$mfa"
}


git_vim_edit() {
  local branch_name="$1"
  local file_path="$2"
  local commit_message="$3"

  # Check if all arguments are provided
  if [ -z "$branch_name" ] || [ -z "$file_path" ] || [ -z "$commit_message" ]; then
    echo "Usage: git_vim_edit <branch_name> <file_path> <commit_message>"
    return 1
  fi

  # Checkout the branch
  git checkout $branch_name
  if [ $? -ne 0 ]; then
    echo "Failed to checkout branch $branch_name"
    return 1
  fi

  # # Checkout the branch
  # git checkout $branch_name
  # if [ $? -ne 0 ]; then
  #   echo "Failed to checkout branch $branch_name"
  #   return 1
  # fi

  # Open the file in Vim and execute the command to search and increment the version number
  vim -c "silent! /shared.version/" \
      -c "normal! n" \
      -c "normal! f<" \
      -c "normal! h" \
      # -c "normal! <C-a>" \
      -c "execute 'normal! '.nr2char(getchar())" \
      -c "let c = getline('.')[col('.') - 1]" \
      -c "let newc = substitute(c, '\\d\\+', '\\=submatch(0) + 1', '')" \
      -c "normal! r\\=newc" \
      -c "update" \
      -c "quit" $file_path



  # Print the modified line containing "shared.version>"
  local new_version_line=$(grep "shared.version>" $file_path)
  echo "Updated line: $new_version_line"

  # Add the changes to git
  git add $file_path

  # # Commit the changes
  # git commit -m "$commit_message"
  #
  # # Push the changes
  # git push origin $branch_name
}

ssi() {
  local branch_name=$1
  git_vim_edit "$branch_name" ./pom.xml "shared version"
}
